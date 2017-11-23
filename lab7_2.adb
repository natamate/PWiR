with Ada.Text_IO;
use Ada.Text_IO;

generic 
    Size: Natural;
    type ElementType is (<>);
package Lab7_2 is

type TBuf is array (Integer range 1..Size) of ElementType;

protected type Buf_Gen(Size : Integer) is
	entry Put(Sign : in ElementType);
	entry Get(Sign : out ElementType);

 	private
 		B : TBuf(1..Size);
 		Counter  : Integer:=0;
 		IndexPut   : Integer:=1;
 		IndexGet : Integer:=1;
end Buf_Gen;

end Lab7_2;

--protected body Buf is
--entry Put(Sign : in ElementType)
--when Counter<Size is begin
--	B(IndexPut) := Sign;
--	IndexPut := IndexPut+1;
--	Counter := Counter+1;
--end Put;

--entry Get(Sign: out ElementType)
--when Counter>0 is begin
--	IndexGet := IndexPut;
--	Counter := Counter - 1;
--	IndexPut := IndexPut - 1;
--	Sign := B(IndexGet);
--end Get;
--end Buf_Gen;
