# APB Protocol Verification in SystemVerilog

## Overview

This project implements a simple **APB (Advanced Peripheral Bus) VIP** using SystemVerilog. The goal is to provide a complete verification environment including a generator, driver, monitor, scoreboard, environment, and testbench to verify an APB slave module.

The APB protocol is widely used in SoC designs for connecting low-bandwidth peripherals like UARTs, timers, and GPIOs.

---

## Repository Structure

APB-Protocol/
├── rtl/
│ └── apb_slave.sv # APB slave RTL implementation
├── top/
│ └── apb_master.sv # Top-level testbench module
├── env/
│ ├── apb_interface.sv # APB interface with clocking blocks
│ ├── apb_transaction.sv # APB transaction class
│ ├── apb_generator.sv # Transaction generator
│ ├── apb_driver.sv # APB driver
│ ├── apb_monitor.sv # APB monitor with coverage
│ ├── apb_scoreboard.sv # Scoreboard for checking results
│ └── apb_env.sv # APB environment class
├── test/
│ └── apb_package.sv # Package including all APB classes
└── README.md 


---

## APB Interface Signals

- `pclk` : Clock signal
- `rst_n` : Active-low reset
- `psel` : Slave select
- `penable` : Enable for access phase
- `pwrite` : Read/Write control
- `pwdata` : Write data
- `prdata` : Read data
- `pready` : Slave ready
- `pslaverr` : Error flag

---

## Verification Components

### Generator (`apb_generator.sv`)

Generates random read and write transactions to stimulate the APB slave.

### Driver (`apb_driver.sv`)

Drives transactions on the APB bus following the APB protocol handshake.

### Monitor (`apb_monitor.sv`)

Observes the bus, samples transactions, and collects coverage.

### Scoreboard (`apb_scoreboard.sv`)

Checks read data from the slave against expected data and reports pass/fail statistics.

### Environment (`apb_env.sv`)

Instantiates generator, driver, monitor, and scoreboard; manages mailbox communication and process execution.

---

## Running Simulation

1. **Compile all files** using your simulator:

```bash
vcs rtl/apb_slave.sv top/apb_master.sv env/*.sv test/apb_package.sv

2. Run simulation:
./simv

3. Check results:

Scoreboard summary will display total checks, pass, and fail counts.

Monitor coverage will be printed in percentage.

example output :

[SOC] PASS: addr=15 expected=2747377201 actual=2747377201
[SOC] PASS: addr=2 expected=1567832486 actual=1567832486
==================================
 APB Scoreboard Summary 
 Total checks = 28
 Pass         = 28
 Fail         = 0
==================================
Coverage of APB monitor: 50.00%

Key Features

Complete SystemVerilog VIP for APB protocol.

Randomized transactions with constraints.

Driver implements proper APB handshake.

Monitor with functional coverage (pwrite, pwdata).

Scoreboard compares expected vs actual read data.

Supports easy extension for multiple slaves.


## ✒️ Author
Brahma Ganesh Katrapalli — katrapallibrahmaganesh@gmail.com

---
