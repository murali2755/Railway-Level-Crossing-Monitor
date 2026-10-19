
# Viva Notes - Railway Level Crossing Monitor

## Q1: What is the real-world problem?
Railway crossings rely on strict safety sequences. If a barrier fails to lower,
or a train passes before the barrier is down, it is a catastrophic failure. This
chip acts as a dedicated hardware watchdog to verify the sequence and trigger a
fail-safe immediately upon violation.

## Q2: Why dedicated hardware and not a microcontroller?
A microcontroller relies on software, boot time, and an operating system.
Dedicated hardware responds instantly, fails deterministically, and has no
software bugs. It is the standard for safety-critical railway applications.

## Q3: What is the sequential logic?
A 6-state FSM (IDLE, WARN, BARRIER, PASSING, CLEAR, FAULT). Yosys mapped this
to one-hot encoding (6 flip-flops), plus an 8-bit timeout counter and a 3-bit
error register, totaling 17 flip-flops.

## Q4: Why does it need sequential logic?
It must remember past events. If the train is in the PASSING state, the system
remembers the barrier is DOWN. A combinational circuit cannot remember states,
nor can it run timers (timeouts).

## Q5: What were the toughest bugs?
1. FSM timeout logic: Initial RTL failed to clear the counter on state changes.
2. GLS mismatch: The FSM state comparison failed in GLS because Yosys changed
   the state encoding to one-hot. We removed the internal state check in GLS
   to focus on interface verification.
3. OpenLane: RePlAce diverged because the initial placement density was too low
   for the actual utilization (10% vs 20%). Fixed by raising PL_TARGET_DENSITY
   to 0.40.

## Q6: How is timing verified?
Static Timing Analysis (STA) across all 16 PVT corners. Pre-layout showed
+29.93 ns worst setup, post-layout showed +28.85 ns worst setup. Hold is +0.20 ns.
All corners pass.

## Q7: What does the fail-safe do?
If the FSM reaches S_FAULT, it latches the error_code and sets fail_safe = 1.
The system stays in this state until a hardware reset is applied.

## Q8: What is the die area?
Exactly 100 um x 100 um = 10,000 um^2.

---

## Numbers to Remember

| Metric | Value |
|---|---|
| Die size | 100 um x 100 um = 0.01 mm^2 |
| Core area | 88.96 um x 78.24 um |
| Total cells | 139 |
| Flip-flops | 17 |
| Utilisation | 19% |
| Clock period | 50 ns (20 MHz) |
| Worst setup slack (post) | +28.85 ns (ss_n40C_1v28) |
| Worst hold slack (post) | +0.20 ns (ff_n40C_1v95) |
| DRC violations | 0 |
| LVS errors | 0 |
| Antenna violations | 0 |
| CVC errors | 0 |
| TritonRoute violations | 0 |
| GDS size (KLayout) | 512,482 bytes |
| Total runtime | 3 min 27 sec |
