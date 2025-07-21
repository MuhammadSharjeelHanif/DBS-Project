# Makefile for SystemVerilog odd parity simulation in ModelSim

# Variables for ModelSim commands
VLOG = vlog -sv
VSIM = vsim -voptargs="+acc"  # Removed -c to launch GUI
VSIM1 = vsim -c 
WAVE_VIEW = vsim -view vsim.wlf

# Directory for source files (current directory)
SRC_DIR = .

# Source files for this task
THIS_TASK = $(SRC_DIR)/des/delay.sv $(SRC_DIR)/des/posedge_detector.sv $(SRC_DIR)/des/negedge_detector.sv $(SRC_DIR)/des/change_detector.sv $(SRC_DIR)/des/pulse_generator.sv $(SRC_DIR)/verif/tb.sv

# Default target
all: compile

compile:
	$(VLOG) $(THIS_TASK) 
	$(VSIM1) tb -do "log -r /*; run -all; exit"

simulate_gui:
	$(VLOG) $(THIS_TASK)
	$(VSIM) tb -do "log -r /*; run -all"

# View waveforms (for existing .wlf files)
view_wave:
	$(WAVE_VIEW)

.PHONY: all compile simulate_gui view_wave clean


