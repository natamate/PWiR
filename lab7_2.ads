with Ada.Text_IO;
use Ada.Text_IO;

generic 
    Size: Natural;
    type ElementType is (<>);
package Lab7_2 is

type TBuff is array (Integer range <>) of ElementType;

protected type Buf_Gen(Size : Integer) is
	entry Put(Sign : in ElementType);
	entry Get(Sign : out ElementType);

 	private
 		B : TBuff(1..Size);
 		Counter  : Integer:=0;
 		IndexPut   : Integer:=1;
 		IndexGet : Integer:=1;
end Buf_Gen;

end Lab7_2;
