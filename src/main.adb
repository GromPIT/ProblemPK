-- *************************************************************
-- * Problem producent - konsument z wykorzystaniem monitora   *
-- *          12 maja 2023 (c) by Piotr M. Garczyński          *
-- *************************************************************
-- *  Plik: main.adb                                           * 
-- *************************************************************

-- Producenci produkuje liczby float i umieszcza na stosie, póki jest niepełny
-- Konsumenci pobierają liczby float z tego stosu, dopóki jest niepusty.

-- Całość ochrony współdzielonego zasobu zdefiniowana jest w StosPackage.

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with stosPackage; use stosPackage;

procedure main is 
   task type Producent(id: Integer);

   task body Producent is 
      idw : Integer;
      x : Float;
      G : Generator;
      time : Float;
   
   begin
      idw := id;
      Reset(G);

      loop 
         --  sekcja lokalna
         x := Random(G) * 100.0;
         Put_Line("P"&Integer'Image(idw)&" wyprodukował liczbę "&Float'Image(x));

         --  sekcja krytyczna
         Put_Line("P"&Integer'Image(id)&" oczekuje na bufor");
         StosBufor.Wstaw(id, x);
         Put_Line("P"&Integer'Image(idw)&" zwolnił bufor ");
        
         --  sekcja lokalna 
         Time := Random(G) * 1.0;
         Delay(Duration(Time));
      end loop;
   end Producent;
      
   task type Konsument(id: Integer);

   task body Konsument is 
      idw : Integer;
      x : Float;
      G : Generator;
      Time : Float;
   
   begin
      idw := id;

      loop    
         --  sekcja krytyczna
         Put_Line("K"&Integer'Image(idw)&" oczekuje na bufor ");
         StosBufor.Pobierz(id, x);
         Put_Line("K"&Integer'Image(idw)&" zwolnił bufor ");

         --  sekcja lokalna
         Time := Random(G) * 1.0;
         Delay(Duration(Time));
      end loop;
   end Konsument;

   P1:Producent(id => 1);   
   P2:Producent(id => 2);
   --  P3:Producent(id => 3);

   K1:Konsument(id => 1);
   --  K2:Konsument(id => 2);
   --  K3:Konsument(id => 3);
   --  K4:Konsument(id => 4);
   --  K5:Konsument(id => 5);
   --  K6:Konsument(id => 6);

   
begin
   
   null;
end main;
