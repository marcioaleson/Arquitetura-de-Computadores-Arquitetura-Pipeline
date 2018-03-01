library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use work.tipo.all;

entity CONTROLE is
port (
	IR 		: in std_logic_vector(31 downto 0);
	WB 		: out std_logic_vector(2 downto 0);
	M 			: out std_logic;
	EX 		: out std_logic_vector(1 downto 0);
	Shamt		: out std_logic_vector(4 downto 0);
	opAlu 	: out std_logic_vector(5 downto 0);
	lerMem	: out std_logic;
	readTam 	: out std_logic_vector(2 downto 0);
	storeTam : out std_logic_vector(1 downto 0);
	entradaAUla: out std_logic_vector(1 downto 0);
	saltoCond: out std_logic;
	controleBeq : out std_logic_vector(1 downto 0);
	saltoIncond: out std_logic;
	selEndDesvio : out std_logic_vector(1 downto 0);
	JAL			: out std_logic;
	op			: out ISA
);
end CONTROLE;

architecture CONTROLE of CONTROLE is

alias codop is IR(31 downto 26);
alias funct is IR(5 downto 0);

begin

Shamt <= IR(10 downto 6);

controle : process(codop,funct)
	begin
	if codop = "000000" then		--TIPO R =============================================================================
		case funct is
			--ADD
			when "100000" =>			
				opAlu <= "000001";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				JAL <= '0';
				op <= add;
			--ADDU
			when "100001" =>		
				opAlu <= "000001";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				selEndDesvio <= "00";
				controleBeq <= "00";
				JAL <= '0';
				op <= addu;
			--SUB	
			when "100010" =>			
				opAlu <= "000010";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				selEndDesvio <= "00";
				controleBeq <= "00";
				JAL <= '0';
				op <= sub;
			--SUBU	
			when "100011" =>			
				opAlu <= "000010";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				selEndDesvio <= "00";
				controleBeq <= "00";
				JAL <= '0';
				op <= subu;
			--MULT	
			when "011000" => 		
				opAlu <= "000011";
				WB <= "110";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				selEndDesvio <= "00";
				controleBeq <= "00";
				JAL <= '0';
				op <= mult;
			--MULTU
			when "011001" => 	
				opAlu <= "000011";
				WB <= "110";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= multu;
			--AND
			when "100100" =>		
				opAlu <= "000100";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= aand;
			--OR
			when "100101" =>		
				opAlu <= "000101";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				selEndDesvio <= "00";
				controleBeq <= "00";
				JAL <= '0';
				op <= oor;
			--XOR
			when "100110" => 
				opAlu <= "000110";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				selEndDesvio <= "00";
				controleBeq <= "00";
				JAL <= '0';
				op <= xxor;
			--NOR
			when "100111" => 
				opAlu <= "000111";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= nnor;
			--DIV
			when "011010" => 
				opAlu <= "001000";
				WB <= "110";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= div;
			--DIVU
			when "011011" => 
				opAlu <= "001000";
				WB <= "110";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= divu;
				
			--SET LESS THAN
			when "101010" =>	
				opAlu <= "001001";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= slt;
				
			--SHIFT RIGHT LOGICAL IMEDIATO
			when "000010" =>
				opAlu <= "001010";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= srli;
			--SHIFT LEFT LOGICAL IMEDIATO
			when "000000" =>
				opAlu <= "001011";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				selEndDesvio <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= slll;
			--SHIFT RIGHT ARIT IMEDIATO
			when "000011" =>
				opAlu <= "001100";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= srai;
			--SHIFT Right LOGICAL
			when "000110" =>
				opAlu <= "001101";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= ssrl;
			--SHIFT LEFT LOGICAL
			when "000100" =>
				opAlu <= "001110";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= ssll;
			--SHIFT RIGHT ARIT
			when "000111" =>
				opAlu <= "001111";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= ssra;
			--MOVE FROM HIGH
			when "010000" =>
				opAlu <= "010001";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "11";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= mfhi;
			--MOVE FROM LOW
			when "010010" =>
				opAlu <= "010001";
				WB <= "010";
				EX <= "01";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "10";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= mflo;
			--JUMP REGISTER
			when "001000" =>
				opAlu <= "000000";
				WB <= "000";
				EX <= "00";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				saltoIncond <= '1';
				controleBeq <= "00";
				selEndDesvio <= "11";
				JAL <= '0';
				op <= jr;
			when others =>
				opALu <= (others => '0');
				WB <=	(others => '0');
				EX <= (others => '0');
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				controleBeq <= "00";
				entradaAUla <= "00";
				selEndDesvio <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				JAL <= '0';
				op <= desconhecida;
		end case;
	else						--TIPO I ou J =========================================================================================
		case codop is 	
			--ADDI
			when "001000" =>
				opALu <= "000001";
				WB <= "010";
				EX <= "10";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= addi;
			--ADDIU
			when "001001" =>
				opALu <= "000001";
				WB <= "010";
				EX <= "10";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= addiu;
			--Load Word
			when "100011" =>
				opAlu <= "000001";
				WB <= "011";
				EX <= "10";
				M <= '0';
				lerMem <= '1';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= lw;
			--Store Word
			when "101011" =>
				opAlu <= "000001";
				WB <= "001";
				EX <= "10";
				M <= '1';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= sw ;
			--ANDI
			when "001100" =>
				opAlu <= "000100";
				WB <= "010";
				EX <= "10";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= andi;
			--ORI
			when "001101" =>
				opAlu <= "000101";
				WB <= "010";
				EX <= "10";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= ori;
			--SET LESS THAN IMEDIATO
			when "001010" =>
				opAlu <= "001001";
				WB <= "010";
				EX <= "10";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= slti;
				
			--SET LESS THAN IMEDIATO unsigned
			when "001011" =>
				opAlu <= "010010";
				WB <= "010";
				EX <= "10";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= sltiu;
				
			--LOAD BYTE
			when "100000" =>
				opAlu <= "000001";
				WB <= "011";
				EX <= "10";
				M <= '0';
				lerMem <= '1';
				readTam <= "100";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= lb;
			--LOAD HALF WORd
			when "100001" => 
				opAlu <= "000001";
				WB <= "011";
				EX <= "10";
				M <= '0';
				lerMem <= '1';
				readTam <= "111";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= lh ;
			--LOAD Byte unsigned
			when "100100" =>
				opAlu <= "000001";
				WB <= "011";
				EX <= "10";
				M <= '0';
				lerMem <= '1';
				readTam <= "100";
				storeTam <= "00";
				entradaAUla <= "00";
				selEndDesvio <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				JAL <= '0';
				op <= lbu ;
			--load HALF WORD unsigned
			when "100101" =>
				opAlu <= "000001";
				WB <= "011";
				EX <= "10";
				M <= '0';
				lerMem <= '1';
				readTam <= "110";
				storeTam <= "00";
				entradaAUla <= "00";
				selEndDesvio <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				saltoIncond <= '0';
				JAL <= '0';
				op <= lhu;
			--store byte
			when "101000" =>
				opAlu <= "000001";
				WB <= "001";
				EX <= "10";
				M <= '1';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "10";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				saltoIncond <= '0';
				selEndDesvio <= "00";
				JAL <= '0';
				op <= sb;
			--store halF
			when "101001" =>
				opAlu <= "000001";
				WB <= "001";
				EX <= "10";
				M <= '1';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "11";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= sh;
			--LUI
			when "001111" =>
				opALu <= "010000";
				WB <= "010";
				EX <= "10";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= lui;
			--BEQ
			
			when "000100" =>
				opALu <= "000000";
				WB <= "000";
				EX <= "00";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '1';
				controleBeq <= "00";
				saltoIncond <= '0';
				selEndDesvio <= "00";
				JAL <= '0';
				op <= beq;
			
			--BGEZ
			when "000001" =>
			
				opALu <= "000000";
				WB <= "000";
				EX <= "00";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '1';
				controleBeq <= "10";
				saltoIncond <= '0';
				selEndDesvio <= "00";
				JAL <= '0';
				op <= bgez;
				
			
			
			--BNE
			when "000101" =>
				opALu <= "000000";
				WB <= "000";
				EX <= "00";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '1';
				controleBeq <= "01";
				saltoIncond <= '0';
				selEndDesvio <= "00";
				JAL <= '0';
				op <= bne;
			--===================================================================================== TIPO J ========================================
			--JUMP
			when "000010" =>
				opALu <= "000000";
				WB <= "000";
				EX <= "00";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				saltoIncond <= '1';
				selEndDesvio <= "01";
				JAL <= '0';
				op <= jump;
			-- JUMP AND LINK
			when "000011" =>
			
				opALu <= "000000";
				WB <= "010";
				EX <= "00";
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				saltoCond <= '0';
				controleBeq <= "00";
				saltoIncond <= '1';
				selEndDesvio <= "01";
				JAL <= '1';
				op <= jumpAndLink;
			
			--NOP	
			when "111111" =>
				opALu <= (others => '0');
				WB <= (others => '0');
				EX <= (others => '0');
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= nop;
		
		
			when others =>
				opALu <= (others => '0');
				WB <= (others => '0');
				EX <= (others => '0');
				M <= '0';
				lerMem <= '0';
				readTam <= "000";
				storeTam <= "00";
				entradaAUla <= "00";
				controleBeq <= "00";
				saltoCond <= '0';
				selEndDesvio <= "00";
				saltoIncond <= '0';
				JAL <= '0';
				op <= desconhecida;
		end case;
	end if;
end process;

end CONTROLE;
