with Ada.Text_IO,Ada.Float_Text_IO, Ada.Calendar, Pak3;
use Ada.Text_IO, Ada.Calendar, Pak3;

procedure Lab3 is
      W1 : Wektor(1 .. 10);
      T1, T2 : Time;
      D : Duration;
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
end Lab3;
