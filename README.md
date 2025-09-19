# APB Protocol Verification (SystemVerilog)

This project implements and verifies an APB slave using SystemVerilog.

## Components
- **DUT**: Simple APB slave (memory-based).
- **Testbench**:
  - Generator
  - Driver
  - Monitor
- **Interface**: Encapsulates APB signals.

## Simulation
Compiled and simulated using **Synopsys VCS**.
Current status: ✅ End-to-end flow runs.  
Next step: fix slave `pready` logic and add read/write testcases.

---
*Work in progress – more updates.*
