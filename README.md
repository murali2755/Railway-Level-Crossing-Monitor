# 🚦 Railway Level Crossing Monitor

### RTL-to-GDSII ASIC Design using SkyWater SKY130

<p align="center">
  <img src="./images.jpeg" alt="Railway Level Crossing with Warning Lights and Barriers" width="720">
</p>

A Verilog-based railway level crossing monitoring project that checks the sequence of railway crossing events and identifies unexpected transitions or timeouts. The project demonstrates RTL verification, synthesis, multi-corner Static Timing Analysis (STA), gate-level simulation, and physical design through GDSII generation.

| Project Information | Details |
|---|---|
| Project | Railway Level Crossing Monitor |
| Author | [murali2755](https://github.com/murali2755) |
| Technology | SkyWater SKY130A |
| Standard-cell library | `sky130_fd_sc_hd` |
| RTL language | Verilog HDL |
| Design flow | RTL → Synthesis → STA → GLS → Physical Design → GDSII |
| Repository | [Railway-Level-Crossing-Monitor](https://github.com/murali2755/Railway-Level-Crossing-Monitor) |

---

## Table of Contents

1. [Overview](#1-overview)
2. [Functional Specification](#2-functional-specification)
3. [Architecture](#3-architecture)
4. [Repository Structure](#4-repository-structure)
5. [RTL Verification](#5-rtl-verification)
6. [Logic Synthesis](#6-logic-synthesis)
7. [Pre-layout Timing Analysis](#7-pre-layout-timing-analysis)
8. [Gate-Level Simulation](#8-gate-level-simulation)
9. [Physical Design](#9-physical-design)
10. [Post-layout Timing Analysis](#10-post-layout-timing-analysis)
11. [Pre-layout vs Post-layout Comparison](#11-pre-layout-vs-post-layout-comparison)
12. [Reproducing the Project](#12-reproducing-the-project)
13. [Limitations](#13-limitations)
14. [Author](#14-author)

---

## 1. Overview

A railway level crossing must follow an appropriate sequence of events:

**Train approaches → Warning lights activate → Barrier is confirmed down → Train passes → Train departs → Barrier is confirmed up.**

This project implements a digital monitoring controller that checks sensor feedback and raises a fail-safe indication if an event occurs out of sequence or a monitored operation exceeds its timeout.

### Project Highlights

- Six-state Finite State Machine (FSM)
- Timeout and invalid-sequence detection
- Error-code reporting and fail-safe indication
- RTL simulation and waveform verification
- SKY130 standard-cell synthesis
- Pre-layout and post-layout STA
- Multi-corner timing analysis
- Physical design and GDSII generation

## 2. Functional Specification

| Event or Condition | Expected Response |
|---|---|
| `train_approach` | Enter warning state |
| `light_on_sensor` | Confirm warning lights |
| `barrier_down_sensor` | Confirm barrier-down status |
| `train_depart` | Enter crossing-clear stage |
| `barrier_up_sensor` | Confirm barrier-up status and return to idle |
| Timeout or invalid sequence | Enter fault state and assert `fail_safe` |

### RTL Interface

| Inputs | Outputs |
|---|---|
| `clk`, `reset` | `fail_safe` |
| `train_approach` | `sequence_ok` |
| `train_depart` | `error_code[2:0]` |
| `light_on_sensor` | |
| `barrier_down_sensor` | |
| `barrier_up_sensor` | |

## 3. Architecture

```text
 train_approach ───┐
 train_depart ─────┤
 light_on_sensor ──┤
 barrier_down ─────┼───┐
 barrier_up ───────┤   │
 clk / reset ──────┘   ▼
                 +--------------------+
                 | Railway Crossing   |
                 | Monitoring FSM     |
                 |                    |
                 | Timeout Counter    |
                 | Error Detection    |
                 +--------------------+
                    │       │       │
                    ▼       ▼       ▼
                 fail_safe sequence_ok error_code
```

The controller uses six conceptual states:

- `S_IDLE` — waiting for a train
- `S_WARN` — warning phase
- `S_BARRIER` — barrier confirmation
- `S_PASSING` — train passing
- `S_CLEAR` — crossing-clear sequence
- `S_FAULT` — fault handling

## 4. Repository Structure

```text
Railway-Level-Crossing-Monitor/
├── rtl/
├── tb/
├── sim/
│   └── rtl/
├── synthesis/
├── liberty/
├── constraints/
├── timing/
├── gls/
├── openlane/
├── results/
├── evidence/
├── Results_Screenshoots/
├── plot_results.py
├── show_summary.sh
├── viva_notes.md
└── README.md
```

The screenshots referenced below are stored in the repository root. The folders above describe the project organization; inspect the repository for the precise contents of each folder.

## 5. RTL Verification

RTL simulation checks the controller's state transitions and output behavior for normal crossing operation, invalid event sequences, and fault conditions.

### RTL Waveform — GTKWave

<p align="center">
  <img src="./railway_gtkwave.png" alt="Railway Level Crossing RTL Waveform" width="900">
</p>

*Figure 1 — RTL simulation waveform displayed using GTKWave.*

## 6. Logic Synthesis

Yosys converts the Verilog RTL into a synthesized logic netlist using the selected standard-cell library.

### 6.1 Synthesis Statistics

<p align="center">
  <img src="./D1_synthesis_stats.png.png" alt="Yosys Synthesis Statistics" width="900">
</p>

*Figure 2 — Synthesis statistics generated by Yosys.*

### 6.2 Standard-cell Breakdown

<p align="center">
  <img src="./D2_cell_breakdown.png.png" alt="Standard Cell Breakdown" width="900">
</p>

*Figure 3 — Distribution of mapped standard cells.*

### 6.3 Synthesized Netlist

<p align="center">
  <img src="./D3_netlist.png" alt="Synthesized Netlist" width="900">
</p>

*Figure 4 — Synthesized hardware netlist.*

The project documentation reports 139 mapped standard cells, 17 flip-flops, and zero latches.

## 7. Pre-layout Timing Analysis

Pre-layout STA evaluates timing paths before physical implementation. The analysis uses clock constraints and timing libraries to assess setup and hold requirements.

### 7.1 Pre-layout Summary

<p align="center">
  <img src="./E1_prelayout_summary.png.png" alt="Pre-layout STA Summary" width="900">
</p>

*Figure 5 — Pre-layout timing summary.*

### 7.2 Worst Setup Path

<p align="center">
  <img src="./E2_worst_setup_path.png.png" alt="Worst Setup Timing Path" width="900">
</p>

*Figure 6 — Worst setup timing path.*

### 7.3 Worst Hold Path

<p align="center">
  <img src="./E3_WORST_HOLD.png" alt="Worst Hold Timing Path" width="900">
</p>

*Figure 7 — Worst hold timing path.*

### 7.4 WNS and TNS Across Corners

<p align="center">
  <img src="./E5_wns_tns_sweep.png.png" alt="Pre-layout WNS and TNS Corner Sweep" width="900">
</p>

*Figure 8 — Pre-layout timing metrics across process, voltage, and temperature corners.*

## 8. Gate-Level Simulation

Gate-Level Simulation (GLS) verifies the synthesized netlist using a testbench and the appropriate simulation models.

The purpose is to confirm that the synthesized logic retains the expected behavior. Timing checks are evaluated separately using STA and, where configured, timing-aware simulation.

## 9. Physical Design

The physical implementation flow uses OpenLane and the configured SKY130 technology files.

The major stages include floorplanning, placement, clock tree synthesis, routing, and final layout generation.

### 9.1 OpenLane Flow Completion

<p align="center">
  <img src="./G1_openlane_success.png" alt="OpenLane Flow Completion" width="900">
</p>

*Figure 9 — OpenLane flow completion evidence.*

### 9.2 Floorplan

<p align="center">
  <img src="./Fig5_2_floorplan.png" alt="Physical Design Floorplan" width="900">
</p>

*Figure 10 — Die and core floorplan.*

### 9.3 Placement

<p align="center">
  <img src="./Fig5_3_placement.png" alt="Standard Cell Placement" width="900">
</p>

*Figure 11 — Standard-cell placement.*

### 9.4 Routing

<p align="center">
  <img src="./Fig5_4_routing.png" alt="Routed Physical Design" width="900">
</p>

*Figure 12 — Physical routing results.*

### 9.5 Final GDSII Layout

<p align="center">
  <img src="./Fig5_5_final_gds.png" alt="Final GDSII Layout" width="900">
</p>

*Figure 13 — Final layout representation.*

## 10. Post-layout Timing Analysis

Post-layout STA evaluates timing after physical implementation. When extracted parasitics are included, the analysis accounts for physical interconnect effects.

### 10.1 Post-layout Setup WNS

<p align="center">
  <img src="./G7_post_setup_wns.png" alt="Post-layout Setup WNS" width="900">
</p>

*Figure 14 — Post-layout setup worst negative slack.*

### 10.2 Post-layout Hold WNS

<p align="center">
  <img src="./G8_post_hold_wns.png" alt="Post-layout Hold WNS" width="900">
</p>

*Figure 15 — Post-layout hold worst negative slack.*

### 10.3 Post-layout Setup TNS

<p align="center">
  <img src="./G9_post_setup_tns.png" alt="Post-layout Setup TNS" width="900">
</p>

*Figure 16 — Post-layout setup total negative slack.*

### 10.4 Post-layout Hold TNS

<p align="center">
  <img src="./G12_post_holf_tns.png" alt="Post-layout Hold TNS" width="900">
</p>

*Figure 17 — Post-layout hold total negative slack.*

## 11. Pre-layout vs Post-layout Comparison

The comparison evaluates how physical implementation affects timing performance. The same timing constraints and corresponding PVT corners should be used for a valid comparison.

### 11.1 Pre-layout Setup WNS

<p align="center">
  <img src="./G14_pre_setup_wns.png" alt="Pre-layout Setup WNS" width="900">
</p>

### 11.2 Pre-layout Hold WNS

<p align="center">
  <img src="./G15_pre_hold_wns.png" alt="Pre-layout Hold WNS" width="900">
</p>

### 11.3 Pre-layout Setup TNS

<p align="center">
  <img src="./G16_Pre_setup_tns.png" alt="Pre-layout Setup TNS" width="900">
</p>

### 11.4 Pre-layout Hold TNS

<p align="center">
  <img src="./G17_pre_hold_tns.png" alt="Pre-layout Hold TNS" width="900">
</p>

### 11.5 Additional Pre-layout Setup Timing

<p align="center">
  <img src="./G18_Pre_setup_ws.png" alt="Additional Pre-layout Setup Timing" width="900">
</p>

### 11.6 Direct Pre-layout vs Post-layout Comparison

<p align="center">
  <img src="./G10_prevspost_setup_wns.png" alt="Pre-layout versus Post-layout Setup WNS" width="900">
</p>

*Figure 23 — Comparison of setup WNS before and after physical implementation.*

<p align="center">
  <img src="./G11_pre_vs_Post_hold_tns.png" alt="Pre-layout versus Post-layout Hold TNS" width="900">
</p>

*Figure 24 — Comparison of pre-layout and post-layout hold TNS.*

### Timing Metrics Explained

| Metric | Meaning |
|---|---|
| WNS | Worst Negative Slack |
| TNS | Total Negative Slack |
| Setup slack | Indicates whether data arrives before the required setup time |
| Hold slack | Indicates whether data remains stable for the required hold time |
| Critical path delay | Delay of the limiting timing path |
| PVT corner | Process, voltage, and temperature operating condition |

Positive slack generally indicates that the corresponding timing requirement is met. Negative slack indicates a timing violation.

## 12. Reproducing the Project

Clone the repository:

```bash
git clone https://github.com/murali2755/Railway-Level-Crossing-Monitor.git
cd Railway-Level-Crossing-Monitor
```

Inspect the RTL and testbench directories:

```bash
ls rtl
ls tb
```

For RTL simulation, use the testbench and source files included in your repository. For synthesis, STA, GLS, and physical design, follow the scripts and configuration provided in their respective directories.

Required dependencies may include:

- Icarus Verilog
- GTKWave
- Yosys
- OpenSTA
- OpenLane
- SKY130 PDK and timing libraries

## 13. Limitations

- This is an educational hardware-monitoring prototype, not a certified railway signalling system.
- Sensor signals are assumed to be suitable digital inputs.
- Physical deployment would require additional redundancy, diagnostics, safety analysis, and regulatory approval.
- Reported performance values must be interpreted using the actual timing constraints and reports.

## 14. Author

**Murali**

GitHub: [@murali2755](https://github.com/murali2755)

Project Repository: [Railway-Level-Crossing-Monitor](https://github.com/murali2755/Railway-Level-Crossing-Monitor)

---

⭐ If you find this project useful, consider starring the repository.
