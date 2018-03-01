library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use work.tipo.all;
LIBRARY lpm;
USE lpm.lpm_components.all;
library altera_mf;
use altera_mf.altera_mf_components.all;

entity pipeline is

port (
	clock : in std_logic;
	reset : in std_logic;
	pc_out	: out std_logic_vector(31 downto 0);
	ir_out	: out std_logic_vector(31 downto 0)
);

end pipeline;

architecture pipeline of pipeline is

component ula IS
	PORT(
		entrada_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);  -- Operando A da ula
		entrada_b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);  -- Operando B da ula
		ula_op    : IN STD_LOGIC_VECTOR(5 DOWNTO 0);   -- Código identificador da operação (6 bits)
		resultado : OUT STD_LOGIC_VECTOR(63 DOWNTO 0); -- Resultado das operações realizadas pela ula
		shamt     : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		operacao	 : out ESTADO
	);
END component;

component CONTROLE is
	port (
		IR 	: in std_logic_vector(31 downto 0);
		WB 	: out std_logic_vector(2 downto 0);
		M 		: out std_logic;
		EX 	: out std_logic_vector(1 downto 0);
		Shamt	: out std_logic_vector(4 downto 0);
		opAlu : out std_logic_vector(5 downto 0);
		lerMeM: out std_logic;
		readTam : out std_logic_vector(2 downto 0);
		storeTam : out std_logic_vector(1 downto 0);
		entradaAUla: out std_logic_vector(1 downto 0);
		saltoCond	: out std_logic;
		controleBeq : out std_logic_vector(1 downto 0);
		saltoIncond : out std_logic;
		selEndDesvio : out std_logic_vector(1 downto 0);
		JAL		: out std_logic;
		op		: out ISA
	);
end component;


component memory_instruction
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;


component Data_Memory
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

TYPE gerreg IS ARRAY (31 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);



--=============================================================================================================
signal opAtual : ESTADO; --DIZ O QUE A ULA ESTA FAZENDO ATUALMENT
signal entrandoNoPipe	: ISA; --DIZ A INSTRUCAO QUE ENTROU NO PIPELINE

SIGNAL banco_de_registradores					: gerreg;							-- Banco de registradores
signal hi: std_logic_vector(31 downto 0);						--REGISTRADORES HIGH E LOW
signal lo: std_logic_vector(31 downto 0);

-- REGISTRADORES DE PIPELINE IF/ID
signal IF_ID_IR  		: std_logic_vector(31 downto 0); --Instrucao a ser executada
signal IF_ID_PC		: std_logic_vector(31 downto 0); -- Pc que eh passado para o IF/ID
signal IF_ID_IMEDIATO: std_logic_vector(31 downto 0);
signal IF_ID_FLUSH	: std_logic;

--Apelidos
alias rs : std_logic_vector(4 downto 0) is IF_ID_IR(25 downto 21);
alias rt : std_logic_vector(4 downto 0) is IF_ID_IR(20 downto 16);

alias IF_ID_codop : std_logic_vector(5 downto 0) is IF_ID_IR(31 downto 26);

-- REGISTRADOR DE PIPELINE ID/EX
signal ID_EX_WB			: std_logic_vector(2 downto 0); 	--Sinal de controle do Write back
signal ID_EX_MEM			: std_logic;	--sinal de controle do estagio de acesso a memoria
signal ID_EX_EX			: std_logic_vector(1 downto 0);	--sinais de controle da fase de execucao
signal ID_EX_PC			: std_logic_vector(31 downto 0);
signal ID_EX_RS_DATA			: std_logic_vector(31 downto 0);	--contem o registrador 1 lido do BR
signal ID_EX_RT_DATA			: std_logic_vector(31 downto 0);	--contem o registrador 2 lido do BR
signal ID_EX_signalExt	: std_logic_vector(31 downto 0);	--contem o 16 bits menos significativo com o sinal extendido 
signal ID_EX_RS			: std_logic_vector(4 downto 0);
signal ID_EX_RD			: std_logic_vector(4 downto 0);  --possivel registrador de destino
signal ID_EX_RT			: std_logic_vector(4 downto 0);	--possivel registrador de destino
signal ID_EX_OPALU		: std_logic_vector(5 downto 0); --Pega a operacao da ula que vem do controle
signal ID_EX_SHAMT		: std_logic_vector(4 downto 0);
signal ID_EX_JAL			: std_logic;
signal ID_EX_LERMEM		: std_logic;
signal ID_EX_ENTRADA1ULA: std_logic_vector(1 downto 0);
signal ID_EX_readTam		: std_logic_vector(2 downto 0);
signal ID_EX_storeTam	: std_logic_vector(1 downto 0);

--APELIDOS DO REG. ID_EX
alias AluSrc : std_logic is ID_EX_EX(1);
alias RegDst : std_logic is ID_EX_EX(0);
alias ID_EX_regWrite : std_logic is ID_EX_WB(1);

-- REGISTRADOR DE PIPELINE EX/MEM


signal EX_MEM_ALUresult	: std_logic_vector(63 downto 0);
signal EX_MEM_WB			: std_logic_vector(2 downto 0);
signal EX_MEM_MEM			: std_logic;
signal EX_MEM_REGDESTINO: std_logic_vecTOR(4 downto 0);
signal EX_MEM_PC			: std_logic_vector(31 downto 0);
signal EX_MEM_JAL			: std_logic;
signal EX_MEM_LERMEM		: std_logic;
signal EX_MEM_readTam		: std_logic_vector(2 downto 0);
signal EX_MEM_storeTam	: std_logic_vector(1 downto 0);
signal EX_MEM_RT_DATA		: std_logic_vector(31 downto 0);

--Apelidos para EX/MEM
alias MemWrite : std_logic is EX_MEM_MEM;
alias EX_MEM_regWrite	: std_logic is EX_MEM_WB(1);	--SINAL Q ATIVA ESCRITA NO BANCO DE REGISTRADOres    
alias addressToMemoryData : std_LOGIC_VECTOR is EX_MEM_ALUresult(11 downto 0);

-- REGISTRADORES PIPELINE MEM/WB
signal MEM_WB_WB			: std_logic_vector(2 downto 0);
signal MEM_WB_ReadData 	: std_logic_vector(31 downto 0);
signal MEM_WB_ALUresult : std_logic_vector(63 downto 0);
signal MEM_WB_REGDESTINO: std_logic_vector(4 downto 0);
signal MEM_WB_PC			: std_logic_vector(31 downto 0);
signal MEM_WB_JAL			: std_logic;
signal MEM_WB_readTam	: std_logic_vector(2 downto 0);

--Apelidos para MEM/WB
alias multi			:std_logic is MEM_WB_WB(2); -- Habilita a escrita no HIGH e no LOW
alias regWrite 	:std_logic is MEM_WB_WB(1); -- HABILITA ESCRITA NO BANCO DE REG
alias MemToReg 	:std_logic is MEM_WB_WB(0);

--Registrador de acesso a memoria de instrucao
signal PC		: std_logic_vector(31 downto 0);
signal PCaux	: std_logic_vector(31 downto 0);
signal MBR		: std_logIC_VECTOR(31 downto 0); --Recebe o instrucao que vem da memoria  	

--Registrador para memoria de dados
signal MBR_DADO: std_logic_vector(31 downto 0); --Recebe o dado que veio da memoria de dados
signal dataFromMemory	: std_logic_vector(31 downto 0);
signal dataToMemory		: std_logic_vector(31 downto 0);

--Sinais do controle
signal controle_WB : std_logic_vector(2 downto 0);
signal controle_MEM: std_logic;
signal controle_EX : std_logic_vector(1 downto 0);
signal Shamt : std_logic_vector(4 downto 0);
signal opALu : std_logic_vector(5 downto 0);
signal lerMeM : std_logic;
signal TamRead : std_logic_vector(2 downto 0);	--tamanho da leitura
signal storeTam : std_logic_vector(1 downto 0);	--tamanho do store
signal saltoCond : std_logic;
signal controleBeq : std_logic_vector(1 downto 0);
signal saltoIncond : std_logic;
signal selEndDesvio : std_logic_vector(1 downto 0);

--sinais auxiliares da ULA
signal entrada1ULA : std_logic_vector(31 downto 0);
signal entrada2ULA : std_logic_vector(31 downto 0);
signal resultadoUla: std_logic_vector(63 downto 0);

signal muxEntradaA : std_logic_vector(1 downto 0); --serve pra tratar HI e LOW

--SINAIS DE SALTO
signal endDesvio			: std_logic_vector(31 downto 0); -- SINAL DO ENDERECO DE DESvio que pode vir de um jump ou BEQ
signal endDesvioJUMP  	: std_logic_vector(31 downto 0);
signal endDesvioBEQ		: std_logic_vector(31 downto 0);
signal endDesvioJR		: std_logic_vector(31 downto 0);

--sinais da unidade de forwarding
signal forwardA : std_logic_vector(1 downto 0);
signal forwardB : std_logic_vector(1 downto 0);

--sinal do dado para o banco de registradores
signal dataForReg	:std_logic_vector(63 downto 0);

--sinal que sai do mux controlado pelo forwardB
signal fioForwardB	: std_logic_vector(31 downto 0);


--sinais de forward do beq
signal forwardRs : std_logic_vector(1 downto 0);
signal forwardRt : std_logic_vector(1 downto 0);

--sinal que controla a escrita no PC
signal escrevePC		: std_logic;

signal resultadoDaComparacaoBEQ: std_logic;
signal resultadoDaComparacaoBNE: std_logic;
signal resultadoBGEZ				 : std_logic;

signal flagDeSalto : std_logic;

--sinal que controla a escrita no reg. de pipelINE IF/ID
signal escreveIF_ID	: std_logic;

--TEMPORARIO, vaai mudar com os conflitos
signal srcPC			: std_logic;

--SINAIS SELECIONADOS PARA COMPARACAO DO BEQ
signal fioRS	: std_logic_vector(31 downto 0);
signal fioRT	: std_logic_vector(31 downto 0);

--sinal que pega a insTRUCAO
signal fioIR : std_logic_vecTOR(31 downto 0);

signal fioADaUla : std_logic_vector(31 downto 0);

--Concatena a selecao de fonte do PC e o sinal do reset
signal aux			: std_logIC_VECTOR(2 downto 0);

signal JAL : std_logic;

signal forwardHigh_Low : std_logic_vector(1 downto 0);

signal fioHigh : std_logic_vector(31 downto 0);
signal fioLow 	: std_logic_vector(31 downto 0);

signal storeExecMux	: std_logic;
signal dadoFromMuxToStoreExec	: std_logic_vector(31 downto 0);
signal storeMemMux 	: std_logic;
signal dadoToWriteInMemory	: std_logic_vector(31 downto 0);

signal RS_DATA_FORWARD 	: std_logic;
signal RT_DATA_FORWARD	: std_logic;
signal fioRSData	: std_logic_vector(31 downto 0);
signal fioRTData	: std_logic_vector(31 downto 0);

signal gambiarraPC	: std_logic_vector(31 downto 0);

signal bolhaCounter	: std_logic_vector(31 downto 0);
signal flushCounter	: std_logic_vector(31 downto 0);

signal flagBolha 		: std_logic;

begin


pc_out <= gambiarraPC;
ir_out <= IF_ID_IR;

--======================================================================== INSTANCIACAO DE COMPONENTES ============================================

--INSTANCIA DA ULA
ulaDoPipe: ula port map(
	entrada_a => entrada1ULA,
	entrada_b => entrada2ULA,  -- Operando B da ula
	ula_op    => ID_EX_OPALU,   -- Código identificador da operação (6 bits)
	resultado => resultadoUla, -- Resultado das operações realizadas pela ula
	shamt     => ID_EX_SHAMT,
	operacao	 => opAtual
);



--=========================================================================================================================
--INSTANCIA DO Controle
ControleDoPipe : CONTROLE port map(
	IR => fioIR,
	WB => controle_WB,
	M	=> controle_MEM,
	EX => controle_EX,
	Shamt	=> Shamt,
	opAlu => opAlu,
	lerMeM => lerMeM,
	readTam => TamRead,
	storeTam => storeTam,
	entradaAUla => muxEntradaA,
	saltoCond => saltoCond,
	controleBeq => controleBeq,
	saltoIncond => saltoIncond,
	selEndDesvio => selEndDesvio,
	JAL => JAL,
	op => entrandoNoPipe
);

--============================================================================================================================
--INSTANCIA DA MEMORIA DE INSTRUCAO

memory_instruction_inst : memory_instruction PORT MAP (
		address	 => gambiarraPC(11 downto 0),
		clock	 => clock,
		q	 => MBR
);
--============================================================================================================================
--INSTANCIA DA MEMORIA DE DADOS
Data_Memory_inst : Data_Memory PORT MAP (
		address	 => EX_MEM_ALUresult(11 downto 0),
		clock	 => clock,
		data	 => DataToMemory,
		wren	 => MemWrite,
		q	 => MBR_DADO
	);

--====================================================FIM DE INSTANCIACOES=======================================================================
--***********************************************************************************************************************************************
--===================================== PROCESSOS DE ESCRITA E LEITURA NOS REGISTRADORES DE PIPELINE ============================================
--IF_ID
aux <= srcPc&reset&escrevePC;
with aux select	
	PCAux <= "00000000000000000000000000000000" when "011",
			"00000000000000000000000000000000" when "111",
			PC + 1 		when "001",
			endDesvio 	when "101",
			PC 			when "000",
			PC 			when "010",
			PC 			when "100",
			PC 			when "110",
			"00000000000000000000000000000000" when others;

gambiarraPC	<= PCAux(29 downto 0)&"00";



process (clock, reset,bolhaCounter)
	begin
		if reset = '1' then
			pc <= (others =>'0');
			
			bolhaCounter <= (others => '0');
			
			
		elsif clock'event and clock = '1' then
			pc <= pcAux;
			if flagBolha = '1' then
				bolhaCounter <= bolhaCounter + 1;
			end if;
		end if;
end process;

IF_ID : process (clock, reset,IF_ID_FLUSH,escreveIF_ID)
begin
	if reset = '1' then		--Se o sinal reset tiver habilitado zera os sinais desse estagio do pipeline
		IF_ID_IR <= (others => '0');
		IF_ID_PC <= (others => '0');
		flushCounter <= (others => '0');
		
	elsif clock'event and clock = '1' and IF_ID_FLUSH = '1' then
		
		IF_ID_IR <= (others => '0');
		IF_ID_PC <= (others => '0');
		flushCounter <= flushCounter + 1;
		
	elsif clock'event and clock = '1' and escreveIF_ID = '1' then
		
		IF_ID_IR <= MBR;		--O registrador IR do Registrador de pipeline IF/ID recebe a instrucao que foi buscada nesse ciclo
		IF_ID_PC <= PC+1;		--O PC+1 eh passado para o registrador de pipeline IF/ID para possiveis calculos de enderecos com o beq
	end if;
end process;



						
--==============================================================================================================================

--PIPELINE ID/EX	ACESSO AO BANCO DE REGISTRADORES E DECODIFICACAO DA INSTRUCAO
ID_EX : process (clock, reset)

begin
	if reset = '1' then			--Se o sinal reset tiver habilitado zera os sinais desse estagio do pipeline e o banco de registradores
	
		for I in 0 to 31 loop
			banco_de_registradores(I) <= (others => '0');
		end loop;
	--	srcPC <= '0';
		ID_EX_RS <= (others => '0');
		ID_EX_RS_DATA <= (others => '0');
		ID_EX_RT_DATA <= (others => '0');
		ID_EX_signalExt <= (others => '0');
		ID_EX_PC <= (others => '0');
		ID_EX_RD <= (others => '0');
		ID_EX_RT <= (others => '0');
		ID_EX_EX <= (others => '0');
		ID_EX_MEM <= '0';
		ID_EX_WB <= (others => '0');
		hi <= (others => '0');
		lo <= (others => '0');
		ID_EX_JAL <= '0';
		ID_EX_LERMEM <= '0';
		ID_EX_ENTRADA1ULA <= "00";
		ID_EX_readTam <= (others => '0');
		ID_EX_storeTam <= (others => '0');
		ID_EX_OPALU <= (others => '0');
		ID_EX_SHAMT <= (others => '0');
		
	elsif clock'event and clock = '1' then	
		
		--PARTE DE ESCRITA EM REGISTRADORES
		if regWrite = '1' then -- VERIFICA SE A ESCRITA NO REGISTRADOR ESTA HABILITADA e se o registrador destino eh diferento do registrador zero
			if multi = '1' then
				hi <= dataForReg(63 downto 32);
				lo <= dataForReg(31 downto 0);
			elsif MEM_WB_JAL = '1' then
				banco_de_registradores(31) <= MEM_WB_PC;
			elsif conv_integer(MEM_WB_REGDESTINO) /= 0 then		--Verifica o registrador destino
				banco_de_registradores(conv_integer(MEM_WB_REGDESTINO)) <= dataForReg(31 downto 0);
			end if;

		end if;
		
		--PARTE DE LEITURA DE REGISTRADORES
		ID_EX_WB <= controle_WB;
		ID_EX_MEM <= controle_MEM;
		ID_EX_EX <= controle_EX;
		ID_EX_OPALU <= opALu;
		ID_EX_SHAMT <= shamt;
		ID_EX_JAL <= JAL;
		ID_EX_LERMEM <= lerMeM;
		ID_EX_RS_DATA <= fioRSData;--banco_de_registradores(conv_integer(IF_ID_IR(25 downto 21)));	--O registrador de pipeline ID/EX  recebe o valor do registrador 1 buscado (RS)
		ID_EX_RT_DATA <= fioRTData;--banco_de_registradores(conv_integer(IF_ID_IR(20 downto 16)));	--O registrador de pipeline ID/EX  recebe o valor do registrador 2 buscado (RT)
		ID_EX_signalExt <= (31 downto 16 => IF_ID_IR(15))&IF_ID_IR(15 DOWNTO 0);	--faco a extensao de sinal e escrevo no registrado de pipeline ID/EX
		ID_EX_RS <= IF_ID_IR(25 downto 21);
		ID_EX_RT <= IF_ID_IR(20 downto 16); 					--Escrevo os dois possiveis registrador destinos(RT e RD)
		ID_EX_RD <= IF_ID_IR(15 downto 11);
		ID_EX_PC <= IF_ID_PC;
		ID_EX_ENTRADA1ULA <= muxEntradaA;
		ID_EX_readTam <= tamRead;
		ID_EX_storeTam <= storeTam;
	end if;
end process;

--PIPELINE EX/MEM =====================================================================================================
								
								
EX_MEM : process(clock,reset)

begin
	if reset = '1' then	--Se o sinal reset tiver habilitado zera os sinais desse estagio do pipeline e o banco de registradores
		EX_MEM_ALUresult <= (others => '0');
		EX_MEM_MEM <= '0';
		EX_MEM_REGDESTINO <= (others => '0');
		EX_MEM_WB <= (others => '0');
		EX_MEM_PC <= (others => '0');
		EX_MEM_JAL <= '0';
		EX_MEM_LERMEM <= '0';
		EX_MEM_readTam <= (others => '0');
		EX_MEM_storeTam <= (others => '0');
		EX_MEM_RT_DATA <= (others => '0');
	elsif clock'event and clock = '1' then
		EX_MEM_WB 			<= ID_EX_WB;		--passa pra frente os sinais de controle WB
		EX_MEM_MEM			<= ID_EX_MEM;		--passa pra frente os sinais de controle MEM
		EX_MEM_ALUresult  <= resultadoUla;
		EX_MEM_PC <= ID_EX_PC;
		EX_MEM_JAL <= ID_EX_JAL;
		EX_MEM_LERMEM <= ID_EX_LERMEM;
		EX_MEM_readTam <= ID_EX_readTam;
		EX_MEM_storeTam <= ID_EX_storeTam;
		EX_MEM_RT_DATA <= dadoFromMuxToStoreExec;
		
		if regDst = '0' then		--MUX que seleciona o registrador destino
			EX_MEM_REGDESTINO <= ID_EX_RT;
		else
			EX_MEM_REGDESTINO <= ID_EX_RD;
		end if;
	end if;
end process;

--=====================================================================================================================================
--PIPELINE MEM/WB

MEM_WB : process(clock,reset)

begin
	if reset = '1' then
		MEM_WB_ALUresult <= (others => '0');
		MEM_WB_REGDESTINO <= (others => '0');
		MEM_WB_ReadData <= (others => '0');
		MEM_WB_WB <= (others => '0');
		MEM_WB_PC <= (others => '0');
		MEM_WB_JAL <= '0';
	elsif clock'event and clock = '1' then
		MEM_WB_ALUresult <= EX_MEM_ALUresult;
		MEM_WB_WB <= EX_MEM_WB;
		MEM_WB_REGDESTINO <= EX_MEM_REGDESTINO;
		MEM_WB_ReadData <= DataFromMemory;
		MEM_WB_PC <= EX_MEM_PC;
		MEM_WB_JAL <= EX_MEM_JAL;
		MEM_WB_readTam <= EX_MEM_readTam;
	end if;

end process;
--================================================ FIM DOS PROCESSOS DE REGISTRADORES DE PIPELINE ===============================================
--***********************************************************************************************************************************************




--=================================================== ELEMENTOS ADICIONAIS DA ARQUITETURA =======================================================

--UNIDADE DE FORWARDING PARA LEITURA DE REGISTRADORES
forward_RS_RT : process(IF_ID_IR,MEM_WB_REGDESTINO, regWrite)
begin
	if regWrite = '1' then
		
		if RS = MEM_WB_REGDESTINO and RS /= "00000"then
			RS_DATA_FORWARD <= '1';
		else
			RS_DATA_FORWARD <= '0';
		end if;
		
		if RT = MEM_WB_ReGDESTINO and RT /= "00000" then
			RT_DATA_FORWARD <= '1';
		else
			RT_DATA_FORWARD <= '0';
		end if;
		
	else
		RS_DATA_FORWARD <= '0';
		RT_DATA_FORWARD <= '0';
	end if;
	
end process;


--=======================================================================================================
--MUX Que seleciona o dado ser escrito no banco de reg (MEM ou ULA)
with memToReg select
	dataForReg <= 	MEM_WB_ALUresult when '0',
						"00000000000000000000000000000000"&dataFromMemory when others;
						
				
--============================================================ TRATAMENTO DOS CONFLITOS DE DADOS ===============================================

--======================================================================================================================
--hazard detection unit

--escrevePC <= '0' when ID_EX_LERMEM = '1' and ((ID_EX_RT = RS) or (ID_EX_RT = RT)) else '1';
--escreveIF_ID <= '0' when ID_EX_LERMEM = '1' and ((ID_EX_RT = RS) or (ID_EX_RT = RT)) else '1';
--fioIR <= (others=>'0') when ID_EX_LERMEM = '1' and ((ID_EX_RT = RS) or (ID_EX_RT = RT)) else IF_ID_IR;

hazard_detection_unit: process(RS,RT,ID_EX_RT,IF_ID_IR,ID_EX_LERMEM,ID_EX_RD,EX_MEM_REGDESTINO,EX_MEM_LERMEM)
begin

	if ID_EX_LERMEM = '1' and ((ID_EX_RT = RS) or (ID_EX_RT = RT and IF_ID_Codop = "000000")) then		--BOLHA PARA CONFLITOS DE DADOS 
		escrevePC <= '0';
		escreveIF_ID <= '0';
		fioIR <= (others => '1'); 			--NOP
		flagBolha  <= '1';
		
	elsif IF_ID_Codop = "000100" or IF_ID_Codop = "000101"  or IF_ID_Codop = "000001" or (IF_ID_IR(5 downto 0) = "001000" and IF_ID_Codop = "000000") then			---VERIFICA SE EH UM SALTO CONDICIONAL ou um JR
		
		if	rs = ID_EX_RD and regDst = '1' and ID_EX_RD /= "00000" and ID_EX_regWrite = '1'  then		--A ULA IRA ESCREVER NO REGISTRADOR A SER COMPARADO
			escrevePC <= '0';
			escreveIF_ID <= '0';
			fioIR <= (others =>'1');
			flagBolha  <= '1';

		elsif rs = ID_EX_RT and regDst = '0' and ID_EX_RT /= "00000" and ID_EX_regWrite = '1' then			
			escrevePC <= '0';
			escreveIF_ID <= '0';
			fioIR <= (others => '1');
			flagBolha  <= '1';
		elsif rs = EX_MEM_REGDESTINO and EX_MEM_LERMEM = '1' and EX_MEM_REGDESTINO /= "00000" then		--EH UM LOAD
			escrevePC <= '0';
			escreveIF_ID <= '0';
			fioIR <= (others => '1');
			flagBolha  <= '1';
		elsif	rt = ID_EX_RD and regDst = '1' and ID_EX_RD /= "00000" and ID_EX_regWrite = '1' then 		--A ULA IRA ESCREVER NO REGISTRADOR A SER COMPARADO
			escrevePC <= '0';
			escreveIF_ID <= '0';
			fioIR <= (others => '1');
			flagBolha  <= '1';
		elsif rt = ID_EX_RT and regDst = '0'  and ID_EX_RT /= "00000" and ID_EX_regWrite = '1' then
			escrevePC <= '0';
			escreveIF_ID <= '0';
			fioIR <= (others=> '1');
			flagBolha  <= '1';
		elsif rt = EX_MEM_REGDESTINO and EX_MEM_LERMEM = '1' then
			escrevePC <= '0';
			escreveIF_ID <= '0';
			fioIR <= (others =>'1');
			flagBolha  <= '1';
		else
			flagBolha <= '0';
			escrevePC <= '1';
			escreveIF_ID <= '1';
			fioIR <= IF_ID_IR;
		end if;
	
	else
		flagBolha  <= '0';
		escrevePC <= '1';
		escreveIF_ID <= '1';
		fioIR <= IF_ID_IR;
	end if;

end process;

--====================================================================================================================
--FORwarding_Unit

Forwarding_Unit :process(ID_EX_RS,ID_EX_RT,EX_MEM_REGDESTINO,MEM_WB_REGDESTINO)
	begin
	
	if EX_MEM_regWrite = '1' and (EX_MEM_REGDESTINO /= "00000") and  EX_MEM_REGDESTINO = ID_EX_RS  then			--HAZARD EX
		forwardA <= "10";
	elsif regWrite = '1' and (MEM_WB_REGDESTINO /= "00000") and MEM_WB_REGDESTINO = ID_EX_RS then				--HAZARD MEM
		forwardA <= "01";
	else
		forwardA <= "00";
	end if;
	
	if EX_MEM_regWrite = '1' and (EX_MEM_REGDESTINO /= "00000") and EX_MEM_REGDESTINO = ID_EX_RT then			--HAZARD EX
		forwardB <= "10";
	elsif regWrite = '1' and (MEM_WB_REGDESTINO /= "00000" ) and MEM_WB_REGDESTINO = ID_EX_RT then				--HAZARD MEM
		forwardB <= "01";
	else
		forwardB <= "00";
	end if;
	
end process; 

--MUX QUE CONTROLA A ENTRADA A DA ULA============================================================================
with ID_EX_ENTRADA1ULA select
	entrada1ULA <= fioHigh when "11",
						fioLow when "10",
						fioADaUla when others;
						
--================================================================================================================
--MUX CONTROLADO PELO ForwardA 
with forwardA select
	fioADaUla <= ID_EX_RS_DATA when "00",
						EX_MEM_ALUresult(31 downto 0) when "10",
						dataForReg(31 downto 0) when "01",
						(others => '0') when others;

--===============================================================================================================
--MUX CONTROLADO PELO FORwardB 
with forwardB select
	fioForwardB <= ID_EX_RT_DATA when "00",
						EX_MEM_ALUresult(31 downto 0) when "10",
						dataForReg(31 downto 0) when "01",
						(others => '0') when others;

						
--===============================================================================================================						
--MUX DE ENTRADA B DA ULA 
with aluSrc select

	entrada2ULA <= fioForwardB when '0',
						ID_EX_signalExt when '1',
						(others => '0') when others;
--==============================================FIM DOS TRATAMENTO DE CONFLITOS DE DADOS ==========================================================						
--*************************************************************************************************************************************************




--===================================================== CONTROLE DE SALTOS ========================================================================

--AND QUE CONTROLA A FONTE DO PC =========================================================================
srcPC <= (saltoCond and flagDeSalto) or saltoIncond;

--================================================================================================================
--COMPARACAO
comparacaoDeRegs : process(fioRS,fioRT)
begin
	if fioRS = fioRT then
		resultadoDaComparacaoBEQ <= '1';
		resultadoDaComparacaoBNE <= '0';
		resultadoBGEZ <= '1';
	elsif conv_integer(fioRS) > conv_integer(fioRT) then 
		resultadoDaComparacaoBEQ <= '0';
		resultadoDaComparacaoBNE <= '1';
		resultadoBGEZ <= '1';
	else
		resultadoDaComparacaoBEQ <= '0';
		resultadoDaComparacaoBNE <= '1';
		resultadoBGEZ <= '1';
	end if;

end process;	
--========================================================================================================
--MUX QUE SELECIONA A COMPARACAO CORRETA
with controleBeq select
	flagDeSalto <= resultadoDaComparacaoBEQ when "00",
						resultadoDaComparacaoBNE when "01",
						resultadoBGEZ when others;
					
--===========================================================================================================================
with selEndDesvio select
	endDesvio <= 	endDesvioJUMP when "01",
						endDesvioJR when "11",
						endDesvioBEQ when others;
--=================================================verifica se o salto foi tomado e ativa o flush sincrono
with srcPC select
	IF_ID_FLUSH <= '1' when '1',
						'0' when others;

--========================================================================================================
--Calculo do desvio do BEQ
IF_ID_IMEDIATO <= (31 downto 16 => IF_ID_IR(15))&IF_ID_IR(15 downto 0);
endDesvioBEQ <= IF_ID_PC + IF_ID_IMEDIATO;

--===========================================================================================================================
--calculo do desvio do JR
endDesvioJR <= fioRS;

--====================================================================================================================
--calcula o endereco de desvio do JUMP e JAL
endDesvioJUMP <= IF_ID_PC(31 downto 28)&"00"&IF_ID_IR(25 downto 0);			
		
--================================================ FIM DO TRATAMENTO DE SALTO =============================================================
--*****************************************************************************************************************************************
--========================================== TRATAMENTO DOS STORES E LOAD(byte,half) =====================================================

--MUX que trata os variados tipos de store
with EX_MEM_storeTam select
	DataToMemory <= 	(31 downto 16 => '0')&dadoToWriteInMemory(15 downto 0) when "11",
							(31 downto 8 => '0')&dadoToWriteInMemory(7 downto 0) when "10",
							dadoToWriteInMemory when others;

--MUX que trata os variados tipo de load que se pode ter
with MEM_WB_readTam select
	DataFromMemory <= (31 downto 16 => MBR_DADO(15))&MBR_DADO(15 downto 0) when "111",
							(31 downto 16 => '0')&MBR_DADO(15 downto 0) when "110",
							(31 downto 8 => MBR_DADO(7))&MBR_DADO(7 downto 0) when "101",
							(31 downto 8 => '0')&MBR_DADO(7 downto 0) when "100",
							MBR_DADO when others;

--============================================== FIM DO TRATAMENTO DOS STORES E LOADS ========================================================
--********************************************************************************************************************************************
--================================================== UNIT FORWARD BEQ ========================================================================

--FORWARD UNIT DO BEQ
conflito_BEQ: process(EX_MEM_REGDESTINO,EX_MEM_LERMEM,EX_MEM_regWrite,rs,rt,MEM_WB_REGDESTINO,regWrite)
begin
	if rs = EX_MEM_REGDESTINO and EX_MEM_REGDESTINO /= "00000" and EX_MEM_LERMEM = '0' and EX_MEM_regWrite = '1' then
		forwardRs <= "10";
	elsif rs = MEM_WB_REGDESTINO and MEM_WB_REGDESTINO /= "00000" and regWrite = '1' then
		forwardRs <= "01";
	else
		forwardRs <= "00";
	end if;
	
	if rt = EX_MEM_REGDESTINO and EX_MEM_REGDESTINO /= "00000" and EX_MEM_LERMEM = '0' and EX_MEM_regWrite = '1' then
		forwardRt <= "10";
	elsif rt = MEM_WB_REGDESTINO and MEM_WB_REGDESTINO /= "00000" and regWrite = '1' then
		forwardRt <= "01";
	else
		forwardRt <= "00";
	end if;
	
end process;

-- MUX QUE CONTROLA O FORWARD DO BEQ
with forwardRs select
	fioRS <= EX_MEM_ALUresult(31 downto 0) when "10",
				dataForReg(31 downto 0) when "01",
				banco_de_registradores(conv_integer(rs)) when others;

with forwardRt select
	fioRT <= EX_MEM_ALUresult(31 downto 0) when "10",
				dataForReg(31 downto 0) when "01",
				banco_de_registradores(conv_integer(rt)) when others;

-- MUX QUE GARANTE A LEITURA CORRETA AO BANCO DE REGISTRADORES NAQUELE MOMENTO
with RS_DATA_FORWARD select
	fioRSData <= 	dataForReg(31 downto 0) when '1',
						banco_de_registradores(conv_integer(RS)) when others;

with RT_DATA_FORWARD select
	fioRTData <= 	dataForReg(31 downto 0) when '1',
						banco_de_registradores(conv_integer(RT)) when others;
			
--====================================================== FIM DO BEQ ================================================================================
--*************************************************************************************************************************************************			
--================================================ MFHI E MFLO =====================================================================================
MFLO: process(EX_MEM_WB,MEM_WB_WB)
begin
	if EX_MEM_WB(2) = '1' then
		forwardHigh_Low <= "01";
	elsif MEM_WB_WB(2) = '1' then
		forwardHigh_Low <= "10";
	else
		forwardHigh_Low <= "00";
	end if;
end process;

with forwardHigh_Low select
	fioHigh <= EX_MEM_ALUresult(63 downto 32) when "01",
				  MEM_WB_ALUresult(63 downto 32) when "10",
				  hi when others;
with forwardHigh_Low select
	fioLow <= EX_MEM_ALUresult(31 downto 0) when "01",
				 MEM_WB_ALUresult(31 downto 0) when "10",
				 lo when others;

--=============================================== FIM DO MFHI E MFLO =============================================================================
--************************************************************************************************************************************************
--==================================================== TRATAMENTO DOS CONFLITOS DO SW ============================================================

store_exec_stage: process(ID_EX_RT,regWrite,MEM_WB_REGDESTINO,ID_EX_MEM)
begin

	if ID_EX_RT = MEM_WB_REGDESTINO and RegWrite = '1' and ID_EX_MEM = '1' then
		storeExecMux <= '1';
	else	
		storeExecMux <= '0';
	end if;

end process;

with storeExecMux select
	dadoFromMuxToStoreExec <= 	dataForReg(31 downto 0) when '1',
										ID_EX_RT_DATA when others;

store_mem_stage: process(EX_MEM_MEM, MEM_WB_REGDESTINO,EX_MEM_REGDESTINO,regWrite)
begin
	if MEM_WB_REGDESTINO = EX_MEM_REGDESTINO and EX_MEM_MEM = '1' and regWrite = '1' then
		storeMemMux <= '1';
	else 
		storeMemMux <= '0';
	end if;
end process;

with storeMemMux select
	dadoToWriteInMemory <= 	dataForReg(31 downto 0) when '1',
									EX_MEM_RT_DATA when others;
		
end architecture;