--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure UBICAR_BARCOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."UBICAR_BARCOS" as

  /*Declare variables*/
  
  ancho Number := 10;
  largo Number := 10;

  idShip Number := 0;
  fila Number := 0;
  columna Number := 0;
  sentido Number := 0;
  barcoCreado Boolean := false;
  
  centinel boolean := false;
  totalShips Number := 0;
  cont Number := 1;
  aleatorioFila BARCOS.FILA%TYPE := 0;
  aleatorioColumna BARCOS.COLUMNA%TYPE := 0;
  aleatorioSentido BARCOS.SENTIDO%TYPE := 0;
  
  /*Declare Cursors*/
  --cursor idShips is select NMPLACA_BARCO from vbn1_barcos;

begin

  delete from BARCOS;
  commit;
  --open idShips;
  
  for i in 1..6 loop
    
    /*iterate on all ships for late setup a point on board*/
    --fetch idShips into idShip;
    --exit when idShips%notfound;
    
    centinel := true;
    
    while centinel loop
      
      aleatorioFila := RANDOMINRANGE(1,largo);
      aleatorioColumna := RANDOMINRANGE(1,ancho);
      aleatorioSentido := RANDOMINRANGE(0,1);
      --DBMS_OUTPUT.PUT_LINE(chr(10)||'aFila: '||aleatorioFila||chr(10)||'aCol: '||aleatorioColumna||chr(10)||'Sentido: '||aleatorioSentido||chr(10));
      
      barcoCreado := CREAR_BARCO_POSICION(i,aleatorioFila, aleatorioColumna, aleatorioSentido, ancho, largo);
      
      if barcoCreado then
      /*(aleatorioFila != 1 and aleatorioFila != largo) and (aleatorioColumna != 1 and aleatorioColumna != ancho) and*/    
        --DBMS_OUTPUT.PUT_LINE('Ship: '||i);
        --DBMS_OUTPUT.PUT_LINE('row: '||aleatorioFila);
        --DBMS_OUTPUT.PUT_LINE('column: '||aleatorioColumna);
        --DBMS_OUTPUT.PUT_LINE('orientation: '||aleatorioSentido||chr(10));
        
        if aleatorioSentido = 1 then
          update pruebaprofe set ocupado = 1 where col = aleatorioColumna and fila = aleatorioFila;
          update pruebaprofe set ocupado = 1 where col = aleatorioColumna+1 and fila = aleatorioFila;
          update pruebaprofe set ocupado = 1 where col = aleatorioColumna+2 and fila = aleatorioFila;
          commit;
        else
          update pruebaprofe set ocupado = 1 where col = aleatorioColumna and fila = aleatorioFila;
          update pruebaprofe set ocupado = 1 where col = aleatorioColumna and fila = aleatorioFila+1;
          update pruebaprofe set ocupado = 1 where col = aleatorioColumna and fila = aleatorioFila+2;
          commit;
        end if;
        
        centinel := false;
      
      end if;
            
    end loop;
    
  end loop;
  
  --close idShips;
  
  --DBMS_OUTPUT.PUT_LINE('Cursor Cerrado');
  
end;

/
