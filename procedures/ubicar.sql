--------------------------------------------------------
-- Archivo creado  - sábado-mayo-09-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure UBICAR_BARCOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."UBICAR_BARCOS" as

  type Ship is record (
    shipId Number,
    shipRow Number,
    shipColumn Number,
    shipOrientation Number
  );
  
  type ShipsSorted is table of Ship index by binary_integer;  

  /*Declare variables*/
  
  ancho Number := 10;
  largo Number := 10;

  idShip Number := 0;
  fila Number := 0;
  columna Number := 0;
  sentido Number := 0;
  
  centinel boolean := false;
  totalShips Number := 0;
  cont Number := 1;
  aleatorioFila SHIPS.FILA%TYPE := 0;
  aleatorioColumna SHIPS.COLUMNA%TYPE := 0;
  aleatorioSentido SHIPS.SENTIDO%TYPE := 0;
  barco Ship;
  lista ShipsSorted;
  
  /*Declare Cursors*/
  --cursor idShips is select NMPLACA_BARCO from vbn1_barcos;

begin

  delete from SHIPS;
  
  --open idShips;
  
  for i in 1..6 loop
    
    /*iterate on all ships for late set up a point on map*/
    --fetch idShips into idShip;
    --exit when idShips%notfound;
    
    centinel := true;
    
    while centinel loop
      
      aleatorioFila := RANDOMINRANGE(1,largo);
      aleatorioColumna := RANDOMINRANGE(1,ancho);
      aleatorioSentido := RANDOMINRANGE(0,1);
      --DBMS_OUTPUT.PUT_LINE(chr(10)||'aFila: '||aleatorioFila||chr(10)||'aCol: '||aleatorioColumna||chr(10)||'Sentido: '||aleatorioSentido||chr(10));
      
      if CREAR_BARCO_POSICION(aleatorioFila,aleatorioColumna,aleatorioSentido,ancho,largo) and (aleatorioFila != 1 and aleatorioFila != largo) and (aleatorioColumna != 1 and aleatorioColumna != ancho) then
        
        barco.shipId := i;
        barco.shipRow := aleatorioFila;
        barco.shipColumn := aleatorioColumna;
        barco.shipOrientation := aleatorioSentido;
        lista(cont) := barco;
        --DBMS_OUTPUT.PUT_LINE('Posicion libre: '||i);
        centinel := false;
        cont := cont + 1;
      
        --DBMS_OUTPUT.PUT_LINE('Posicion ocupada');
      
      end if;
            
    end loop;
    
  end loop;
  
  --close idShips;
  
  --DBMS_OUTPUT.PUT_LINE('Cursor Cerrado');
  
  --select count(*) into totalShips from vbn1_barcos;
  
  if true then
      
    for i in 1..6 loop
   
      --DBMS_OUTPUT.PUT_LINE(chr(10)||'#SHIP#');
      barco := lista(i);
      --DBMS_OUTPUT.PUT_LINE('Ship: '||barco.shipId);
      --DBMS_OUTPUT.PUT_LINE('row: '||barco.shipRow);
      --DBMS_OUTPUT.PUT_LINE('column: '||barco.shipColumn);
      --DBMS_OUTPUT.PUT_LINE('orientation: '||barco.shipOrientation||chr(10));
      insert into SHIPS values(barco.shipColumn,barco.shipRow,barco.shipId,barco.shipOrientation);
      
      if barco.shipOrientation = 1 then
        update pruebaprofe set ocupado = 1 where col = barco.shipColumn and fila = barco.shipRow;
        update pruebaprofe set ocupado = 1 where col = barco.shipColumn+1 and fila = barco.shipRow;
        update pruebaprofe set ocupado = 1 where col = barco.shipColumn+2 and fila = barco.shipRow;
      else
        update pruebaprofe set ocupado = 1 where col = barco.shipColumn and fila = barco.shipRow;
        update pruebaprofe set ocupado = 1 where col = barco.shipColumn and fila = barco.shipRow+1;
        update pruebaprofe set ocupado = 1 where col = barco.shipColumn and fila = barco.shipRow+2;
      end if;
      
    end loop;
    
    commit;
    
  end if;
  
end;

/
