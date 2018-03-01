onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipeline/clock
add wave -noupdate /pipeline/reset
add wave -noupdate /pipeline/opAtual
add wave -noupdate -radix decimal /pipeline/banco_de_registradores
add wave -noupdate /pipeline/hi
add wave -noupdate /pipeline/lo
add wave -noupdate /pipeline/IF_ID_IR
add wave -noupdate /pipeline/IF_ID_PC
add wave -noupdate /pipeline/IF_ID_IMEDIATO
add wave -noupdate -itemcolor {Green Yellow} /pipeline/IF_ID_FLUSH
add wave -noupdate -itemcolor {Green Yellow} /pipeline/IF_ID_codop
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/rt
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/rs
add wave -noupdate -itemcolor {Green Yellow} /pipeline/forwardRs
add wave -noupdate -itemcolor {Green Yellow} /pipeline/forwardRt
add wave -noupdate -itemcolor {Green Yellow} /pipeline/escrevePC
add wave -noupdate -itemcolor {Green Yellow} /pipeline/resultadoDaComparacaoBEQ
add wave -noupdate -itemcolor {Green Yellow} /pipeline/resultadoDaComparacaoBNE
add wave -noupdate -itemcolor {Green Yellow} /pipeline/flagDeSalto
add wave -noupdate -itemcolor {Green Yellow} /pipeline/escreveIF_ID
add wave -noupdate -itemcolor {Green Yellow} /pipeline/srcPC
add wave -noupdate -itemcolor {Green Yellow} /pipeline/fioRT
add wave -noupdate -itemcolor {Green Yellow} /pipeline/fioIR
add wave -noupdate -itemcolor {Green Yellow} /pipeline/JAL
add wave -noupdate -itemcolor {Green Yellow} /pipeline/MBR
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/PC
add wave -noupdate /pipeline/endDesvio
add wave -noupdate /pipeline/endDesvioJUMP
add wave -noupdate /pipeline/endDesvioBEQ
add wave -noupdate /pipeline/endDesvioJR
add wave -noupdate /pipeline/ID_EX_WB
add wave -noupdate /pipeline/ID_EX_MEM
add wave -noupdate /pipeline/ID_EX_EX
add wave -noupdate /pipeline/ID_EX_PC
add wave -noupdate /pipeline/ID_EX_REG1
add wave -noupdate /pipeline/ID_EX_REG2
add wave -noupdate /pipeline/ID_EX_signalExt
add wave -noupdate /pipeline/auxExt
add wave -noupdate /pipeline/ID_EX_RS
add wave -noupdate /pipeline/ID_EX_RD
add wave -noupdate /pipeline/ID_EX_RT
add wave -noupdate /pipeline/ID_EX_OPALU
add wave -noupdate /pipeline/ID_EX_SHAMT
add wave -noupdate /pipeline/ID_EX_JAL
add wave -noupdate /pipeline/ID_EX_LERMEM
add wave -noupdate /pipeline/ID_EX_ENTRADA1ULA
add wave -noupdate /pipeline/ID_EX_readTam
add wave -noupdate /pipeline/ID_EX_storeTam
add wave -noupdate /pipeline/EX_MEM_ALUresult
add wave -noupdate /pipeline/EX_MEM_WB
add wave -noupdate /pipeline/EX_MEM_MEM
add wave -noupdate /pipeline/EX_MEM_REGDESTINO
add wave -noupdate /pipeline/EX_MEM_PC
add wave -noupdate /pipeline/EX_MEM_JAL
add wave -noupdate /pipeline/EX_MEM_LERMEM
add wave -noupdate /pipeline/EX_MEM_readTam
add wave -noupdate /pipeline/EX_MEM_storeTam
add wave -noupdate /pipeline/MEM_WB_WB
add wave -noupdate /pipeline/MEM_WB_ReadData
add wave -noupdate /pipeline/MEM_WB_ALUresult
add wave -noupdate /pipeline/MEM_WB_REGDESTINO
add wave -noupdate /pipeline/MEM_WB_PC
add wave -noupdate /pipeline/MEM_WB_JAL
add wave -noupdate /pipeline/PCaux
add wave -noupdate /pipeline/MBR_DADO
add wave -noupdate /pipeline/dataFromMemory
add wave -noupdate /pipeline/dataToMemory
add wave -noupdate /pipeline/controle_WB
add wave -noupdate /pipeline/controle_MEM
add wave -noupdate /pipeline/controle_EX
add wave -noupdate /pipeline/Shamt
add wave -noupdate /pipeline/opALu
add wave -noupdate /pipeline/lerMeM
add wave -noupdate /pipeline/TamRead
add wave -noupdate /pipeline/storeTam
add wave -noupdate /pipeline/saltoCond
add wave -noupdate /pipeline/controleBeq
add wave -noupdate /pipeline/saltoIncond
add wave -noupdate /pipeline/selEndDesvio
add wave -noupdate /pipeline/entrada1ULA
add wave -noupdate /pipeline/entrada2ULA
add wave -noupdate /pipeline/resultadoUla
add wave -noupdate /pipeline/muxEntradaA
add wave -noupdate /pipeline/forwardA
add wave -noupdate /pipeline/forwardB
add wave -noupdate /pipeline/dataForReg
add wave -noupdate /pipeline/fioForwardB
add wave -noupdate /pipeline/fioRS
add wave -noupdate /pipeline/fioADaUla
add wave -noupdate /pipeline/aux
add wave -noupdate /pipeline/forwardHigh_Low
add wave -noupdate /pipeline/fioHigh
add wave -noupdate /pipeline/fioLow
add wave -noupdate /pipeline/MemToReg
add wave -noupdate /pipeline/regWrite
add wave -noupdate /pipeline/multi
add wave -noupdate /pipeline/EX_MEM_regWrite
add wave -noupdate /pipeline/MemWrite
add wave -noupdate /pipeline/RegDst
add wave -noupdate /pipeline/AluSrc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 226
configure wave -valuecolwidth 236
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {838 ps}
force -freeze sim:/pipeline/reset 1 0
force -freeze sim:/pipeline/clock 1 0, 0 {50 ps} -r 100
