library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;

entity CONTROLEALU is
port (
	funct : in std_logic_vector(5 downto 0);
	OpAlu : in std_logic_vector(1 downto 0);
	operacaoNaALU : out std_logic_vector(3 downto 0)
);
end CONTROLEALU;

architecture ControlAlu of CONTROLEALU is


begin

process
begin

	if OpAlu = "00" then					--LOAD OU STORE
		OperacaoNaALU <= "0010";
	elsif OpAlu = "01" then				--BEQ
		OperacaoNaALU <= "0110";
	elsif OpAlu = "10" then				--TIPO R
		
		if funct = "100000" then		--ADD
			OperacaoNaALU <= "0010";
		elsif funct = "100010" then 	--SUB
			OperacaoNaALU <= "0110";
		elsif funct = "100100" then	--AND
			operacaoNaALU <= "0000";
		elsif funct = "100101" then	--OR
			operacaoNaALU <= "0001";
		elsif funct = "101010" then	--SLT
			operacaoNaALU <= "0111";
		end if;
		
	end if;

end process;

end ControlAlu;
