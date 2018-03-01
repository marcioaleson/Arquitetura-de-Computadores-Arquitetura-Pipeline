-- Declaração de bibliotecas
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all; -- Verificar implicações do uso
use ieee.std_logic_arith.all;
use work.tipo.all;
-- Entidade ula - Depois deve ser transformada em um componente
ENTITY ula IS
	PORT(
		entrada_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);  -- Operando A da ula
		entrada_b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);  -- Operando B da ula
		ula_op    : IN STD_LOGIC_VECTOR(5 DOWNTO 0);   -- Código identificador da operação (6 bits)
		resultado : buffer STD_LOGIC_VECTOR(63 DOWNTO 0); -- Resultado das operações realizadas pela ula
		shamt     : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		operacao	 : out ESTADO
	);
END ula;

-- Arquitetura da entidade ula
ARCHITECTURE operacoes_ula OF ula IS
 -- criar uma variável para manter o valor de resultado


component Logical_Shifter
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		direction		: IN STD_LOGIC ;
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

component DIVIDER
	PORT
	(
		denom		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		numer		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		quotient		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		remain		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;


component Arith_Shifter
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		direction		: IN STD_LOGIC ;
		distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

--Sinais da divisao
signal quociente 					: std_logic_vector(31 downto 0);
signal resto	  					: std_logic_vector(31 downto 0);

--Sinais do deslocamento logico
signal ResDeslocado_Logico	: std_logic_vector(31 downto 0);

--Sinais de Deslocamento AritimETICO
signal resDeslocado_Arit	:std_logic_vector(31 downto 0);


signal direction						:std_logic;
signal distanceDesloc				: std_LOGIC_VECTOR(4 downto 0); 
signal dadoADescolocar				:std_logic_vector(31 downto 0);
signal entradaBunsigned		: std_LOGIC_VECTOR(31 downto 0);

BEGIN
	
	with ula_op select
		direction <= 	'1' when "001010",
							'1' when "001100",
							'1' when "001101",
							'1' when "001111",
							'0' when others;
								
	with ula_op select								--SELECIONA SE VAI SER O SHAMT OU UM REGISTRADOR Q VAI DIZER A QNTD DESLOCADA
		distanceDesloc <= shamt when "001010",
								shamt when "001100",
								shamt when "001011",
								entrada_b(4 downto 0) when others;
	
	with ula_op select								--SELECIONA O DADO A SER DESLOCADO
		dadoADescolocar <= entrada_b when "001010",
								 entrada_b when "001100",
								 entrada_b when "001011",
								 entrada_a when others;
	
	--INSTANCIA DO DIVISOR =========================================================================================
	DIVIDER_inst : DIVIDER PORT MAP (
		denom	 => entrada_b,
		numer	 => entrada_a,
		quotient	 => quociente,
		remain	 => resto
	);
	
	--INSTANCIA DO DESLOCADOR LOGICO =================================================================================
	Logical_Shifter_inst : Logical_Shifter PORT MAP (
		data	 => dadoADescolocar,
		direction	 => direction,
		distance	 => distanceDesloc,
		result	 => ResDeslocado_Logico
	);
	
	--INSTANCIA DO DESLOCADOR ARITIMETICO =====================================================================================
	Arith_Shifter_inst : Arith_Shifter PORT MAP (
		data	 => dadoADescolocar,
		direction	 => direction,
		distance	 => distanceDesloc,
		result	 => resDeslocado_Arit
	);
	
	
	
		
	processo: PROCESS(ula_op,entrada_a,entrada_b,quociente,resto,resDeslocado_Logico,resDeslocado_Arit)
	BEGIN
		CASE ula_op IS
			-- Operação de soma
			WHEN "000001" =>			--SOMa
				operacao <= soma;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 DOWNTO 0) <= entrada_a + entrada_b;
			
			-- Operação de subTRACAO
			WHEN "000010" =>		--SUBTRACAO
				operacao <= subtract;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 DOWNTO 0) <= entrada_a - entrada_b;
			
			-- Operação de multiplcaoca
			WHEN "000011" =>	
				operacao <= mult;
				resultado(63 downto 32) <= (others => '0');
				resultado <= entrada_a * entrada_b;
			
			--Operacao de AND
			when "000100" =>
				operacao <= opAnd;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 DOWNTO 0) <= entrada_a and entrada_b;
				
			--Operacao de OR
			when "000101" =>
				operacao <= opOr;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 DOWNTO 0) <= entrada_a or entrada_b;
			
			--Operacao de XOR
			when "000110" =>
				operacao <= opXor;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 DOWNTO 0) <= entrada_a xor entrada_b;	
			
			--Operacao de NOR
			when "000111" =>
				operacao <= opNor;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 DOWNTO 0) <= entrada_a nor entrada_b;		
			
			--OPERACAO DIVISAO
			when "001000" =>
				operacao <= divisao;
				resultado(63 downto 32) <= resto;
				resultado(31 downto 0) <= quociente;
			
			--SET LESS THAN
			when "001001" =>
				operacao <= slt;
				resultado(63 downto 32) <= (others => '0');
				if conv_integer(entrada_a) < conv_integer(entrada_b) then
					resultado(31 downto 0) <= "00000000000000000000000000000001";
				else
					resultado(31 downto 0) <= (others => '0');
				end if;
				
			-- SLTIU
			
			when "010010" =>
				operacao <= sltiu;
				resultado(63 downto 32) <= (others => '0');
				
				--entradaBunsigned <= not(entrada_b) + 1;
				
				
				if (entrada_a < (31 downto 16 => '0')&entrada_b(15 downto 0)) then
					resultado(31 downto 0) <= "00000000000000000000000000000001";
				else
					resultado(31 downto 0) <= (others => '0');
				end if;
			
			
			--SHIFT RIGHT LOGICAL IMEDIATO
			when "001010" =>
				operacao <= opSrl;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 dowNTO 0) <= resDeslocado_Logico;
				
			--SHIFT LEFT LOGICAL IMEDIATO
			when "001011" =>
				operacao <= opSll;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 downto 0) <= resDeslocado_Logico;
			
			--SHIFT RIGHT ARIT IMEDIATO
			when "001100" =>
				operacao <= opSra;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 downto 0) <= resDeslocado_Arit;
			
			--SHIFT RIGHT LOGICAL 
			when "001101" =>
				operacao <= srlv;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 downto 0) <= resDeslocado_Logico;
			
			--SHIFT LEFT LOGICAL
			when "001110" =>
				operacao <= sllv;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 downto 0) <= resDeslocado_Logico;
			
			--SHIFT RIGHT ARIT
			when "001111" =>
				operacao <= srav;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 downto 0) <= resDeslocado_Arit;
			
			--LUI
			when "010000" =>
				operacao <= LUI;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 downto 16) <= entrada_b(15 downto 0);
				resultado(15 downto 0) <= (others => '0');
			
			--PASSA DADO DA ENTRADA A (MFH E MFL)
			when "010001" =>
				operacao <= MVHMFL;
				resultado(63 downto 32) <= (others => '0');
				resultado(31 downto 0) <= entrada_a;
			
			
			-- ...
			WHEN OTHERS =>
				operacao <= nop;
				resultado <= (others => '0');
		
		END CASE;
		
		
		
	END PROCESS processo;
	
END operacoes_ula;