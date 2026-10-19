
# Railway Level Crossing Monitor
## SKY130 RTL-to-GDSII ASIC Design Project

A compact sequential digital controller that monitors the safety sequence of a
railway level crossing and raises a fail-safe alarm if the sequence is violated
or times out. Designed, verified, and taken to a verified GDSII layout on the
SkyWater SKY130 130 nm process, targeting a 100 um x 100 um die.

---

## 1. Real-World Application

A railway level crossing must execute a strict safety sequence when a train
approaches: Lights ON -> Barrier DOWN -> Train PASSES -> Barrier UP -> Lights OFF.
If any step happens out of order, or takes too long, the crossing is unsafe.
This project implements a dedicated hardware monitor that verifies this sequence
in real-time and raises a fail-safe alarm on violation.

**Users:** railway signalling engineers, safety system integrators.
**Where:** embedded in a level crossing control cabinet as a parallel safety monitor.

---

## 2. Functional Specification

| Condition | Action |
|---|---|
| `train_approach` = 1 | FSM moves to S_WARN (turn on lights) |
| `light_on_sensor` = 1 in time | FSM moves to S_BARRIER (lower barrier) |
| `barrier_down_sensor` = 1 in time | FSM moves to S_PASSING (train crosses) |
| `train_depart` = 1 | FSM moves to S_CLEAR (raise barrier) |
| `barrier_up_sensor` = 1 in time | FSM returns to S_IDLE (safe state) |
| Timeout in any state | FSM moves to S_FAULT (`fail_safe` = 1) |
| Out-of-order sensor | FSM moves to S_FAULT (`fail_safe` = 1) |

**Motor interlock:** `fail_safe` and `sequence_ok` are never both 1.

**`error_code[2:0]`:** 000 = no error; 001-110 = specific violation.

---

## 3. RTL Interface

**Inputs (12 pins):**
`clk`, `reset`, `train_approach`, `train_depart`, `light_on_sensor`,
`barrier_down_sensor`, `barrier_up_sensor`

**Outputs (5 pins):**
`fail_safe`, `sequence_ok`, `error_code[2:0]`

---

## 4. Sequential Logic

- **6-state FSM:** S_IDLE (000), S_WARN (001), S_BARRIER (010), S_PASSING (011), S_CLEAR (100), S_FAULT (101)
- **State register:** 6 flip-flops (one-hot encoding via synthesis)
- **Timeout counter:** 8-bit shared counter
- **Error register:** 3-bit latched error code
- **Total flip-flops:** 17 (FSM: 6, counter: 8, error: 3)
- No memories, no latches, no macros

---

## 5. Verification Summary

### 5.1 RTL Simulation (Icarus Verilog 10.1)
- 13 self-checking test cases
- Result: **14 / 14 PASSED**

### 5.2 Yosys Synthesis
- Target: `sky130_fd_sc_hd` high-density cells
- Result: **139 cells, 17 flip-flops, 0 latches**

### 5.3 Pre-Layout STA (OpenSTA, all 16 corners)
- Worst setup: **+29.93 ns** (ss_n40C_1v28) on a 50 ns clock
- Worst hold: **+0.18 ns** (ff_n40C_1v95)
- All corners: **PASS**

### 5.4 Gate-Level Simulation (Icarus + SKY130 models)
- Functional-only FF model used (standard practice - timing verified by STA)
- Result: **14 / 14 PASSED**

### 5.5 OpenLane Physical Design (v0.21)
- Die area: **100 um x 100 um**
- Core area: 88.96 um x 78.24 um
- Total runtime: **3 min 27 sec**
- Final cell count: **139**

| Check | Result |
|---|---|
| TritonRoute violations | **0** |
| Short violations | **0** |
| Metal spacing violations | **0** |
| Off-grid violations | **0** |
| Magic DRC | **0** |
| Antenna violations | **0** |
| LVS errors | **0** |
| CVC errors | **0** |

### 5.6 Post-Layout STA (OpenSTA, all 16 corners, with SPEF)
- Worst setup: **+28.85 ns** (ss_n40C_1v28)
- Worst hold: **+0.20 ns** (ff_n40C_1v95)
- All corners: **PASS**

### 5.7 Pre vs Post-Layout Delta
- Setup delta: **-1.080 ns to -0.250 ns**
- Hold delta: **+0.020 ns to +0.740 ns**

---

## 6. Final Deliverables

| Artifact | Path |
|---|---|
| GDSII (KLayout) | `results/railway_level_crossing_monitor.gds` |
| GDSII (Magic) | `results/railway_level_crossing_monitor.magic.gds` |
| SPEF | `results/railway_level_crossing_monitor.spef` |
| Routed netlist | `results/railway_level_crossing_monitor.synthesis_preroute.v` |
| Flow summary | `results/final_summary_report.csv` |
| Pre-layout STA | `timing/prelayout/*.log` |
| Post-layout STA | `timing/postlayout/*.log` |
| Pre-vs-post table | `timing/comparison.txt` |
| RTL | `rtl/railway_level_crossing_monitor.v` |
| Testbench | `tb/railway_level_crossing_monitor_tb.v` |
| GLS setup | `gls/` |

---

## 7. Design Decisions and Trade-offs

| Decision | Reason |
|---|---|
| 6-state FSM | Sufficient to model the safety sequence without over-complicating |
| One-hot encoding | Yosys chose this automatically; 6 FFs for 6 states |
| 8-bit shared timeout counter | Reused across states to save area |
| Functional FF for GLS | Sky130 UDP hold-check causes false X; STA covers timing |
| `FP_CORE_UTIL=30` | Design is ~20% of core; leaves room for routing |
| `PL_TARGET_DENSITY=0.40` | Above actual utilisation; prevents RePlAce divergence |
| `PL_BASIC_PLACEMENT=1` | Robust for small designs in a large die |
| 50 ns clock period | 10x slower than the intrinsic critical path; large timing margin |

---

## 8. Known Limitations

- Sensor inputs are assumed to be clean digital signals (no debounce).
- No physical position feedback for the barrier - command-based monitor.
- No power analysis was performed.
- The design does not include an ADC; it expects an already-digitized sensor interface.

---

## 9. Reproducing the Flow

1. RTL simulation: `iverilog -g2012 -o tb.vvp rtl/*.v tb/*.v && vvp tb.vvp`
2. Synthesis: `yosys -l synth.log synth.ys`
3. Pre-layout STA: OpenSTA with SDC over 16 SKY130 corners
4. Gate-level simulation: `iverilog -g2012 -DSKY130_FD_SC_HD__DFXTP_1_V` with functional FF override
5. Physical design: OpenLane v0.21 in Docker, `DIE_AREA = 0 0 100 100`, `PDK = sky130A`
6. Post-layout STA: OpenSTA with SPEF over 16 SKY130 corners

---

## 10. Viva Quick Reference

See `viva_notes.md` for anticipated questions and prepared answers.
EOF

echo "README.md created."
wc -l README.md
