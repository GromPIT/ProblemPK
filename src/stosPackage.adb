-- *************************************************************
-- * Problem producent - konsument z wykorzystaniem monitora   *
-- *          12 maja 2023 (c) by Piotr M. Garczyński          *
-- *************************************************************
-- *  Plik: stosPackage.adb                                    * 
-- *************************************************************

package body stosPackage is 
   protected body StosBufor is 
      -- Procedura typu Entry () when Warunek, pozwala wejść w procedurę
      -- wtedy (i tylko wtedy), kiedy warunek po when jest spełniony. 
      -- Dzięki temu realizujemy ochronę współdzielonego zasobu
      entry wstaw(id: Integer; x:in float) when stos.wsk < pojemnosc is begin
         Put_Line("P"&Integer'Image(id)&" uzyskał dostęp do bufora");
         stos.wsk := stos.wsk + 1;   
         stos.St(stos.wsk) := x;
         Put_Line("P"&Integer'Image(id)&" wstawił na stos "&Float'Image(x));
      end wstaw;
   
      entry pobierz(id: Integer; x:out float) when stos.wsk > 0 is begin
         Put_Line("K"&Integer'Image(id)&" uzyskał dostęp do bufora");
         x := stos.St(stos.wsk);
         stos.wsk := stos.wsk - 1;
         Put_Line("K"&Integer'Image(id)&" pobrał ze stosu "&Float'Image(x));
      end pobierz;
   end StosBufor;
end stosPackage;
