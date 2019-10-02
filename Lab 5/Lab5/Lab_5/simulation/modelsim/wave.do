onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /testbench/Clk
add wave -noupdate -label Run /testbench/Run
add wave -noupdate -label ClrA_LdB /testbench/ClearA_LoadB
add wave -noupdate -label Reset /testbench/Reset
add wave -noupdate -label Switches -radix binary /testbench/S
add wave -noupdate -label X -radix binary /testbench/X
add wave -noupdate -label A_reg -radix binary /testbench/processor0/A
add wave -noupdate -label B_reg -radix binary /testbench/processor0/B
add wave -noupdate -label Sum /testbench/S
add wave -noupdate -label {FSM State} -radixenum symbolic /testbench/processor0/FSM/curr_state
add wave -noupdate -label M /testbench/processor0/FSM/M
add wave -noupdate -label Add /testbench/processor0/FSM/Add
add wave -noupdate -label Sub /testbench/processor0/FSM/Sub
add wave -noupdate -label Shift_En /testbench/processor0/FSM/Shift_En
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {163897 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {154101 ps} {231979 ps}
