onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipeline/clock
add wave -noupdate /pipeline/reset
add wave -noupdate /pipeline/opAtual
add wave -noupdate -radix decimal -childformat {{/pipeline/banco_de_registradores(31) -radix decimal} {/pipeline/banco_de_registradores(30) -radix decimal} {/pipeline/banco_de_registradores(29) -radix decimal} {/pipeline/banco_de_registradores(28) -radix decimal} {/pipeline/banco_de_registradores(27) -radix decimal} {/pipeline/banco_de_registradores(26) -radix decimal} {/pipeline/banco_de_registradores(25) -radix decimal} {/pipeline/banco_de_registradores(24) -radix decimal} {/pipeline/banco_de_registradores(23) -radix decimal} {/pipeline/banco_de_registradores(22) -radix decimal} {/pipeline/banco_de_registradores(21) -radix decimal} {/pipeline/banco_de_registradores(20) -radix decimal} {/pipeline/banco_de_registradores(19) -radix decimal} {/pipeline/banco_de_registradores(18) -radix decimal} {/pipeline/banco_de_registradores(17) -radix decimal} {/pipeline/banco_de_registradores(16) -radix decimal} {/pipeline/banco_de_registradores(15) -radix decimal} {/pipeline/banco_de_registradores(14) -radix decimal} {/pipeline/banco_de_registradores(13) -radix decimal} {/pipeline/banco_de_registradores(12) -radix decimal} {/pipeline/banco_de_registradores(11) -radix decimal} {/pipeline/banco_de_registradores(10) -radix decimal} {/pipeline/banco_de_registradores(9) -radix decimal} {/pipeline/banco_de_registradores(8) -radix decimal} {/pipeline/banco_de_registradores(7) -radix decimal} {/pipeline/banco_de_registradores(6) -radix decimal} {/pipeline/banco_de_registradores(5) -radix decimal} {/pipeline/banco_de_registradores(4) -radix decimal} {/pipeline/banco_de_registradores(3) -radix decimal} {/pipeline/banco_de_registradores(2) -radix decimal} {/pipeline/banco_de_registradores(1) -radix decimal} {/pipeline/banco_de_registradores(0) -radix decimal}} -expand -subitemconfig {/pipeline/banco_de_registradores(31) {-radix decimal} /pipeline/banco_de_registradores(30) {-radix decimal} /pipeline/banco_de_registradores(29) {-radix decimal} /pipeline/banco_de_registradores(28) {-radix decimal} /pipeline/banco_de_registradores(27) {-radix decimal} /pipeline/banco_de_registradores(26) {-radix decimal} /pipeline/banco_de_registradores(25) {-radix decimal} /pipeline/banco_de_registradores(24) {-radix decimal} /pipeline/banco_de_registradores(23) {-radix decimal} /pipeline/banco_de_registradores(22) {-radix decimal} /pipeline/banco_de_registradores(21) {-radix decimal} /pipeline/banco_de_registradores(20) {-radix decimal} /pipeline/banco_de_registradores(19) {-radix decimal} /pipeline/banco_de_registradores(18) {-radix decimal} /pipeline/banco_de_registradores(17) {-radix decimal} /pipeline/banco_de_registradores(16) {-radix decimal} /pipeline/banco_de_registradores(15) {-radix decimal} /pipeline/banco_de_registradores(14) {-radix decimal} /pipeline/banco_de_registradores(13) {-radix decimal} /pipeline/banco_de_registradores(12) {-radix decimal} /pipeline/banco_de_registradores(11) {-radix decimal} /pipeline/banco_de_registradores(10) {-radix decimal} /pipeline/banco_de_registradores(9) {-radix decimal} /pipeline/banco_de_registradores(8) {-radix decimal} /pipeline/banco_de_registradores(7) {-radix decimal} /pipeline/banco_de_registradores(6) {-radix decimal} /pipeline/banco_de_registradores(5) {-radix decimal} /pipeline/banco_de_registradores(4) {-radix decimal} /pipeline/banco_de_registradores(3) {-radix decimal} /pipeline/banco_de_registradores(2) {-radix decimal} /pipeline/banco_de_registradores(1) {-radix decimal} /pipeline/banco_de_registradores(0) {-radix decimal}} /pipeline/banco_de_registradores
add wave -noupdate /pipeline/hi
add wave -noupdate /pipeline/lo
add wave -noupdate /pipeline/IF_ID_PC
add wave -noupdate /pipeline/IF_ID_IMEDIATO
add wave -noupdate /pipeline/IF_ID_FLUSH
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_WB
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_MEM
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_EX
add wave -noupdate -itemcolor {Medium Aquamarine} -radix decimal /pipeline/ID_EX_signalExt
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_OPALU
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_SHAMT
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_JAL
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_LERMEM
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_ENTRADA1ULA
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_readTam
add wave -noupdate -itemcolor {Medium Aquamarine} /pipeline/ID_EX_storeTam
add wave -noupdate -itemcolor Firebrick /pipeline/IF_ID_IR
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/banco_de_registradores(2)
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/entrada1ULA
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/entrada2ULA
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/rt
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/rs
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/ID_EX_RS_DATA
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/ID_EX_RT_DATA
add wave -noupdate -itemcolor {Green Yellow} /pipeline/forwardA
add wave -noupdate -itemcolor {Green Yellow} /pipeline/forwardB
add wave -noupdate -itemcolor {Green Yellow} /pipeline/RS_DATA_FORWARD
add wave -noupdate -itemcolor {Green Yellow} /pipeline/RT_DATA_FORWARD
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/EX_MEM_ALUresult
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/EX_MEM_REGDESTINO
add wave -noupdate -itemcolor {Green Yellow} -radix decimal /pipeline/MEM_WB_ALUresult
add wave -noupdate -itemcolor {Green Yellow} -radix unsigned /pipeline/MEM_WB_REGDESTINO
add wave -noupdate -itemcolor {Medium Blue} -radix decimal /pipeline/PC
add wave -noupdate /pipeline/ID_EX_RS
add wave -noupdate /pipeline/ID_EX_PC
add wave -noupdate /pipeline/ID_EX_RD
add wave -noupdate /pipeline/ID_EX_RT
add wave -noupdate /pipeline/EX_MEM_WB
add wave -noupdate /pipeline/EX_MEM_MEM
add wave -noupdate /pipeline/EX_MEM_PC
add wave -noupdate /pipeline/EX_MEM_JAL
add wave -noupdate /pipeline/EX_MEM_LERMEM
add wave -noupdate /pipeline/EX_MEM_readTam
add wave -noupdate /pipeline/EX_MEM_storeTam
add wave -noupdate /pipeline/EX_MEM_SELREGDESTINO
add wave -noupdate /pipeline/EX_MEM_RT_DATA
add wave -noupdate /pipeline/MEM_WB_WB
add wave -noupdate /pipeline/MEM_WB_ReadData
add wave -noupdate /pipeline/MEM_WB_PC
add wave -noupdate /pipeline/MEM_WB_JAL
add wave -noupdate /pipeline/MEM_WB_lerMem
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
add wave -noupdate /pipeline/storeTam
add wave -noupdate /pipeline/saltoCond
add wave -noupdate /pipeline/controleBeq
add wave -noupdate /pipeline/saltoIncond
add wave -noupdate /pipeline/selEndDesvio
add wave -noupdate /pipeline/resultadoUla
add wave -noupdate /pipeline/muxEntradaA
add wave -noupdate /pipeline/endDesvio
add wave -noupdate /pipeline/endDesvioJUMP
add wave -noupdate /pipeline/endDesvioBEQ
add wave -noupdate /pipeline/endDesvioJR
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
add wave -noupdate /pipeline/storeExecMux
add wave -noupdate /pipeline/dadoFromMuxToStoreExec
add wave -noupdate /pipeline/storeMemMux
add wave -noupdate /pipeline/dadoToWriteInMemory
add wave -noupdate /pipeline/fioRSData
add wave -noupdate /pipeline/fioRTData
add wave -noupdate /pipeline/MemToReg
add wave -noupdate /pipeline/regWrite
add wave -noupdate /pipeline/multi
add wave -noupdate /pipeline/EX_MEM_regWrite
add wave -noupdate /pipeline/MemWrite
add wave -noupdate /pipeline/ID_EX_regWrite
add wave -noupdate /pipeline/RegDst
add wave -noupdate /pipeline/AluSrc
add wave -noupdate /pipeline/IF_ID_codop
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 222
configure wave -valuecolwidth 234
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
WaveRestoreZoom {0 ps} {842 ps}
