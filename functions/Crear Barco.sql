--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function CREAR_BARCO_POSICION
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SYSTEM"."CREAR_BARCO_POSICION" 
(
  BARCOID IN NUMBER DEFAULT 0
, ENFILA IN NUMBER DEFAULT 0 
, ENCOLUMNA IN NUMBER DEFAULT 0 
, ENSENTIDO IN NUMBER DEFAULT 0
, ANCHO IN NUMBER DEFAULT 0
, LARGO IN NUMBER DEFAULT 0
) RETURN BOOLEAN AS

/*Declare variables*/

shipOnPosition number := 0;
shipNearBy Boolean := false;

BEGIN
  
  /*
  Check the first point of the ship, we need to see if there is a ship on this position,
  it doesn't care if the orientation of the ship if vertical or horizontal for the first position.
  */
  if ENFILA = 1  or ENCOLUMNA = 1 or ENFILA = LARGO or ENCOLUMNA = ANCHO or ENFILA+2 = LARGO or ENCOLUMNA+2 = ANCHO then
    return false;
  end if;
  
  select count(*) into shipOnPosition from BARCOS where FILA = ENFILA and COLUMNA = ENCOLUMNA;
  
  if shipOnPosition != 1  then
    
    shipNearBy := BARCO_CERCA(ENFILA,ENCOLUMNA,ANCHO,LARGO);
    
    if shipNearBy then 
      return false;
    end if;
    
    /*Horizontal*/
    if ENSENTIDO = 1 then
      
      /*The lenght of a ship is three space so the first point was checked before on line 27*/
      for i in 1..2 loop
        
        /*Check if the position is into the board*/
        if (ENCOLUMNA+i) > ANCHO then
          --DBMS_OUTPUT.PUT_LINE('Columna fuera: '||(columna+i));
          return false;
        end if;
        
        select count(*) into shipOnPosition from BARCOS where FILA = ENFILA and COLUMNA = (ENCOLUMNA+i);
        
        /*There is a ship on this position*/
        if (shipOnPosition = 1) then
              --DBMS_OUTPUT.PUT_LINE('Posicion ocupada en columna: '||(COLUMNA+i));
              return false;
        end if;
        
        shipNearBy := BARCO_CERCA(ENFILA,ENCOLUMNA+i,ANCHO,LARGO);
    
        if shipNearBy then 
          return false;
        end if;
          
      end loop;
      
      /*There isn't a ship on this position*/
      --DBMS_OUTPUT.PUT_LINE('Posicion desocupada fila: '||fila||' - columna: '||COLUMNA);
      insert into BARCOS values (ENFILA,ENCOLUMNA,ENSENTIDO,BARCOID);
      insert into BARCOS values (ENFILA,ENCOLUMNA+1,ENSENTIDO,BARCOID);
      insert into BARCOS values (ENFILA,ENCOLUMNA+2,ENSENTIDO,BARCOID);
      commit;
      return true;
      
    else
    
    /*Vertical,the orientation variable has taken any value different of 1*/

      for i in 1..2 loop
        
        if (ENFILA+i) > LARGO then
        --DBMS_OUTPUT.PUT_LINE('Fila fuera: '||(fila+i));
          return false;
        end if;
                
        --here is the same sentece with a little change of the ERROR1234 and this works fine
        select count(*) into shipOnPosition from BARCOS where FILA = (ENFILA+i) and COLUMNA = ENCOLUMNA;
        
        if (shipOnPosition = 1) then
              --DBMS_OUTPUT.PUT_LINE('Posicion ocupada en fila: '||(FILA+i));
              return false;
        end if;
      
        shipNearBy := BARCO_CERCA(ENFILA+i,ENCOLUMNA,ANCHO,LARGO);
    
        if shipNearBy then 
          return false;
        end if;
      
      end loop;
      
      --DBMS_OUTPUT.PUT_LINE('Posicion desocupada fila: '||fila||' - columna: '||COLUMNA);
      insert into BARCOS values (ENFILA,ENCOLUMNA,ENSENTIDO,BARCOID);
      insert into BARCOS values (ENFILA+1,ENCOLUMNA,ENSENTIDO,BARCOID);
      insert into BARCOS values (ENFILA+2,ENCOLUMNA,ENSENTIDO,BARCOID);
      commit;
      return true;
    
    end if;
    
  else
  /*There is a ship on this position, so we can't put the ship*/
    --DBMS_OUTPUT.PUT_LINE('Posicion ocupada fila: '||ENFILA||' - columna: '||ENCOLUMNA);
    return false;
  end if;
  
END CREAR_BARCO_POSICION;

/
