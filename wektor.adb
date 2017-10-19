with Ada.Text_IO,Ada.Float_Text_IO, Ada.Numerics.Discrete_Random, Ada.Calendar;
use Ada.Text_IO,Ada.Float_Text_IO, Ada.Calendar;



procedure Wektor is
  type Wektor is array(Integer range <>) of Float;
  W1 : Wektor(1 .. 10);
	T1, T2 : Time;
	D : Duration;
 
procedure Show(W1 : in Wektor) is
begin
	 for I in W1'First..W1'Last loop 
   Put("Tab(" & I'Img & ")="); 
   Put( W1(I),3,4,0 );  
   New_Line;
  end loop;
end Show;

procedure FillRandom(W1 : in out Wektor) is
	package Los_Float is new Ada.Numerics.Discrete_Random(Integer);
  use Los_Float;
 	Wart : Float;
  Gen: Generator; 
begin
  Reset(Gen);
  for I in W1'First..W1'Last loop
    Wart := Float(Random(Gen));
		W1(I) := Wart;
  end loop;
end FillRandom;

function CheckAsc(W1 : in Wektor) return Boolean is
begin
	return (for all I in W1'First..(W1'Last - 1) => W1(I) <= W1(I+1));
end CheckAsc;

procedure Sort (W1 : in out Wektor) is
	Size : Integer;
	Tmp : Float;
begin
	Size := W1'Length;
	
	loop
		for I in 1 .. Size - 1 loop
			if (W1(I) > W1(I+1)) then 
				Tmp := W1(I); -- swap
				W1(I) := W1(I+1);
				W1(I+1) := Tmp;
			end if;
		end loop;
		Size := Size - 1;
	exit when (Size <= 1);
	end loop;
end Sort;

procedure Check(W1 : in Wektor) is
begin
	if CheckAsc(W1) then
		Put("Tab is sorting ascending");
	else 
		Put("Tab is not sorting ascending");
	end if;

	New_Line;
end Check;

procedure WriteToFile(W1 : in Wektor) is 
	File : File_Type;
	FileName : String := "wektor1.txt";
begin
	Create(File, Out_File, FileName);
	for I in W1'First..W1'Last loop
		Put_Line(File, W1(I)'Img & " ");
	end loop;
	Close(File);
end WriteToFile;

begin
	T1 := Clock;

	W1 := (others => 1.5);

	Show(W1);	
	FillRandom(W1);

	Show(W1);
	Check(W1);

	Sort(W1);
	Show(W1);
	Check(W1);
	
	T2 := Clock;
	D := T2 - T1;

	WriteToFile(W1);
	Put_Line("Runtime: " & D'Img & " [s]");
end Wektor;
