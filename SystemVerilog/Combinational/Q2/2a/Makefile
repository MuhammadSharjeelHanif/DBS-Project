# Makefile for SystemVerilog odd parity simulation in ModelSim

# Variables for ModelSim commands
VLOG = vlog -sv
VSIM = vsim -voptargs="+acc"  # Removed -c to launch GUI
VSIM1 = vsim -c 
WAVE_VIEW = vsim -view vsim.wlf

# Directory for source files (current directory)
SRC_DIR = .

# Source files for odd parity
4_1mux_SRC = $(SRC_DIR)/design/Q2a.sv $(SRC_DIR)/verif/tb.sv

# Default target
all: compile

compile:
	$(VLOG) $(4_1mux_SRC) 
	$(VSIM1) tb -do "log -r /*; run -all; exit"

simulate_gui:
	$(VLOG) $(4_1mux_SRC)
	$(VSIM) tb -do "log -r /*; run -all"

# View waveforms (for existing .wlf files)
view_wave:
	$(WAVE_VIEW)

.PHONY: all compile simulate_gui view_wave clean

