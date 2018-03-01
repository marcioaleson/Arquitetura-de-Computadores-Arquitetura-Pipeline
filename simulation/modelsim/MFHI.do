onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipeline/clock
add wave -noupdate /pipeline/reset
add wave -noupdate /pipeline/opAtual
add wave -noupdate -radix decimal /pipeline/banco_de_registradores
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/hi
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/lo
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/rt
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/rs
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/PC
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/EX_MEM_ALUresult
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/ulaDoPipe/entrada_a
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/ulaDoPipe/entrada_b
add wave -noupdate /pipeline/IF_ID_IR
add wave -noupdate /pipeline/IF_ID_PC
add wave -noupdate /pipeline/IF_ID_IMEDIATO
add wave -noupdate /pipeline/IF_ID_FLUSH
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
add wave -noupdate /pipeline/EX_MEM_WB
add wave -noupdate /pipeline/EX_MEM_MEM
add wave -noupdate /pipeline/EX_MEM_REGDESTINO
add wave -noupdate /pipeline/EX_MEM_zero
add wave -noupdate /pipeline/EX_MEM_PC
add wave -noupdate /pipeline/EX_MEM_JAL
add wave -noupdate /pipeline/EX_MEM_LERMEM
add wave -noupdate /pipeline/MEM_WB_WB
add wave -noupdate /pipeline/MEM_WB_ReadData
add wave -noupdate /pipeline/MEM_WB_ALUresult
add wave -noupdate /pipeline/MEM_WB_REGDESTINO
add wave -noupdate /pipeline/MEM_WB_PC
add wave -noupdate /pipeline/MEM_WB_JAL
add wave -noupdate /pipeline/PCaux
add wave -noupdate /pipeline/MBR
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
add wave -noupdate /pipeline/TamStore
add wave -noupdate /pipeline/saltoCond
add wave -noupdate /pipeline/controleBeq
add wave -noupdate /pipeline/saltoIncond
add wave -noupdate /pipeline/selEndDesvio
add wave -noupdate /pipeline/entrada1ULA
add wave -noupdate /pipeline/entrada2ULA
add wave -noupdate /pipeline/zero
add wave -noupdate /pipeline/resultadoUla
add wave -noupdate /pipeline/muxEntradaA
add wave -noupdate /pipeline/endDesvio
add wave -noupdate /pipeline/endDesvioJUMP
add wave -noupdate /pipeline/endDesvioBEQ
add wave -noupdate /pipeline/endDesvioJR
add wave -noupdate /pipeline/forwardA
add wave -noupdate /pipeline/forwardB
add wave -noupdate /pipeline/dataForReg
add wave -noupdate /pipeline/fioForwardB
add wave -noupdate /pipeline/forwardRs
add wave -noupdate /pipeline/forwardRt
add wave -noupdate /pipeline/escrevePC
add wave -noupdate /pipeline/resultadoDaComparacaoBEQ
add wave -noupdate /pipeline/resultadoDaComparacaoBNE
add wave -noupdate /pipeline/flagDeSalto
add wave -noupdate /pipeline/escreveIF_ID
add wave -noupdate /pipeline/srcPC
add wave -noupdate /pipeline/fioRS
add wave -noupdate /pipeline/fioRT
add wave -noupdate /pipeline/fioIR
add wave -noupdate /pipeline/fioADaUla
add wave -noupdate /pipeline/aux
add wave -noupdate /pipeline/JAL
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
add wave -noupdate /pipeline/ulaDoPipe/ula_op
add wave -noupdate /pipeline/ulaDoPipe/zero
add wave -noupdate /pipeline/ulaDoPipe/resultado
add wave -noupdate /pipeline/ulaDoPipe/shamt
add wave -noupdate /pipeline/ulaDoPipe/operacao
add wave -noupdate /pipeline/ulaDoPipe/quociente
add wave -noupdate /pipeline/ulaDoPipe/resto
add wave -noupdate /pipeline/ulaDoPipe/ResDeslocado_Logico
add wave -noupdate /pipeline/ulaDoPipe/resDeslocado_Arit
add wave -noupdate /pipeline/ulaDoPipe/direction
add wave -noupdate /pipeline/ulaDoPipe/distanceDesloc
add wave -noupdate /pipeline/ulaDoPipe/dadoADescolocar
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {503 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
configure wave -valuecolwidth 208
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
WaveRestoreZoom {0 ps} {874 ps}