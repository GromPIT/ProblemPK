-- *************************************************************
-- * Problem producent - konsument z wykorzystaniem monitora   *
-- *          12 maja 2023 (c) by Piotr M. Garczyński          *
-- *************************************************************
-- *  Plik: stosPackage.ads                                    * 
-- *************************************************************
with ADA.Text_IO; use ADA.Text_IO;

package stosPackage is 
   type stosArray is array(integer range<>) of Float; -- tablica stosu
   
   type stosStruktura(pojemnosc:Integer) is record    -- struktura stosu
      st:stosArray(1..pojemnosc);
      wsk:Integer:=0;   
   end record;
   
   pojemnosc : constant Integer:= 5;                 -- pojemność stosu

   protected StosBufor is 
      -- Procedura typu Entry () pozwala wejść w procedurę wtedy (i tylko wtedy),
      -- kiedy spełniony jest warunek definiowany w body pakietu. 
      -- Dzięki temu realizujemy ochronę współdzielonego zasobu.
      entry Wstaw(id: Integer; x:in float);
      entry Pobierz(id: Integer; x: out float);

   private
      -- prywatny, niedostępny spoza StosBufor stos o wskazanej pojemności.
      stos: stosStruktura(pojemnosc);
   
   end StosBufor;

 end stosPackage; 
