
package Pak3 is
        type Wektor is array(Integer range <>) of Float;
	procedure Show(W1 : in Wektor);
	procedure FillRandom(W1 : in out Wektor);
	function CheckAsc(W1 : in Wektor) return Boolean;
	procedure Sort(W1 : in out Wektor);
	procedure Check(W1 : in Wektor);
        procedure WriteToFile(W1 : in Wektor);

end Pak3;
