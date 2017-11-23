-- semaforb.adb
-- semafr binarny 
-- Zaimplementuj semafor liczbowy i zastosuj:
-- wer. 1 - na zadaniu,

with Ada.Text_IO;
use Ada.Text_IO;

procedure Lab7_3 is
  
-- typ chroniony 
protected type Semafor_Liczbowy(Init_Sem: Integer := 0) is
  entry Wait;
  procedure Signal;
  private
   S : Integer := Init_Sem;
end Semafor_Liczbowy ;

protected body Semafor_Liczbowy  is
  entry Wait when S > 0 is
  begin
    S := S-1;
  end Wait;

  procedure Signal  is
  begin
    S := S+1;
  end Signal;
end Semafor_Liczbowy ;
  
Semafor1: Semafor_Liczbowy(0);  
  
task Producent; 

task body Producent is
begin  
  Put_Line("$ produkuję ... " );
  delay 0.7;
  Put_Line("$ wysyłam sygnał...");
  Semafor1.Signal;
  Put_Line("$ kończę produkcję..."); 
end Producent;

task Konsument; 

task body Konsument is
begin  
  Put_Line("# czekam na sygnał...");
  Semafor1.Wait;
  Put_Line("# dostałem sygnał ...");
end Konsument;

begin
  Put_Line("@ jestem w procedurze glownej");
end Lab7_3;
  
