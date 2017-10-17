library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity IM is
    port (
		  rst  : in std_logic;
        addr : in  std_logic_vector(31 downto 0);
        data : out std_logic_vector(31 downto 0)
    );
end IM;
 
architecture behavioral of IM is
    type memoria_rom is array (0 to 63) of std_logic_vector (31 downto 0);
    signal ROM : memoria_rom := (
"10000010000100000010000000001000", --0:	82 10 20 08 	mov  8, %g1
"10000100000100000011111111111001", --4:	84 10 3f f9 	mov  -7, %g2
"10010000000000000100000000000010", --8:	90 00 40 02 	add  %g1, %g2, %o0
"10000010000110000100000000000010", --c:	82 18 40 02 	xor  %g1, %g2, %g1
"10010100001010000100000000000010", --10:	94 28 40 02 	andn  %g1, %g2, %o2
"10010110001110000100000000000010", --14:	96 38 40 02 	xnor  %g1, %g2, %o3
"10011000001000000100000000000010", --18:	98 20 40 02 	sub  %g1, %g2, %o4
"00000001000000000000000000000000", --nop
"00000001000000000000000000000000", --nop
"00000001000000000000000000000000", --nop
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000" -- Fila con datos 56 a 63                                                  
    );
begin
	process(rst, addr)
	begin
	 if (rst = '1') then
			data <= "00000000000000000000000000000000";
		else
			data <= ROM(conv_integer(addr));
	 end if;
	end process;
end behavioral;




--from random import randint

--n = 64

--for i in xrange(n):
   -- x = randint(0, 1<<32)
    --num = str(bin(x))[2:]
    --num = (32 - len(num)) * '0' + num
    --print "\"" + num + "\","
