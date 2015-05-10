--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function BARCO_CERCA
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SYSTEM"."BARCO_CERCA" 
(
  ENFILA IN NUMBER DEFAULT 0 
, ENCOLUMNA IN NUMBER DEFAULT 0 
, ANCHO IN NUMBER DEFAULT 0 
, LARGO IN NUMBER DEFAULT 0 
) RETURN BOOLEAN AS 

barcoExiste Number := 0;

BEGIN
  
  -- rigth
  
  if (ENCOLUMNA + 1) <= ANCHO  then
  
    select count(*) into barcoExiste from BARCOS where FILA = ENFILA and COLUMNA = (ENCOLUMNA+1);
    
    if barcoExiste = 1 then
      return true;
    end if;
  
  end if;
  
  -- down
  
  if (ENFILA + 1) <= LARGO  then
  
    select count(*) into barcoExiste from BARCOS where FILA = (ENFILA+1) and COLUMNA = ENCOLUMNA;
    
    if barcoExiste = 1 then
      return true;
    end if;
  
  end if;
  
  -- up
  
  if (ENFILA - 1) >= 1  then
      
    select count(*) into barcoExiste from BARCOS where FILA = (ENFILA-1) and COLUMNA = ENCOLUMNA;
    
    if barcoExiste = 1 then
      return true;
    end if; 
  
  end if;
  
  -- left
  
  if (ENCOLUMNA - 1) >= 1 then
    
    select count(*) into barcoExiste from BARCOS where FILA = ENFILA and COLUMNA = (ENCOLUMNA-1);
    
    if barcoExiste = 1 then
      return true;
    end if;
  
  end if;
  
  return false;
  
END BARCO_CERCA;

/
