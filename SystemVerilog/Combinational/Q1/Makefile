# Makefile for SystemVerilog odd parity simulation in ModelSim

# Variables for ModelSim commands
VLOG = vlog -sv
VSIM = vsim -voptargs="+acc"  # Removed -c to launch GUI
VSIM1 = vsim -c 
WAVE_VIEW = vsim -view vsim.wlf

# Directory for source files (current directory)
SRC_DIR = .

# Source files for odd parity
ODD_PARITY_SRC = $(SRC_DIR)/design/Q1.sv $(SRC_DIR)/verif/testbench.sv

# Default target
all: odd_parity

compile:
	$(VLOG) $(ODD_PARITY_SRC) 
	$(VSIM1) testbench -do "log -r /*; run -all; exit"

simulate_gui:
	$(VLOG) $(ODD_PARITY_SRC)
	$(VSIM) testbench -do "log -r /*; run -all"

# View waveforms (for existing .wlf files)
view_wave:
	$(WAVE_VIEW)


