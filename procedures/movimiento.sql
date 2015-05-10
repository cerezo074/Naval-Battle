--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure MOVIMIENTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."MOVIMIENTO" 
(
  ENFILA IN NUMBER 
, ENCOLUMNA IN NUMBER 
, ANCHO IN NUMBER 
, LARGO IN NUMBER
, PROXIMAFILA OUT NUMBER
, PROXIMACOLUMNA OUT NUMBER
) IS

shootNoExist Number := 0;
enter Boolean := false;

BEGIN
  
  proximaFila := 0;
  proximaColumna := 0;
  
  -- rigth
  
  if enter = false and ((ENCOLUMNA + 1) <= ANCHO)  then
  
    select count(*) into shootNoExist from MYBOARD where FILA = ENFILA and COLUMNA = (ENCOLUMNA+1) and RESULTADO = 'N';
    
    if shootNoExist = 1 then
      PROXIMAFILA := ENFILA;
      PROXIMACOLUMNA := ENCOLUMNA+1;
      enter := true;
    end if;
  
  end if;
  
  -- down
  
  if enter = false and ((ENFILA + 1) <= LARGO)  then
  
    select count(*) into shootNoExist from MYBOARD where FILA = (ENFILA+1) and COLUMNA = ENCOLUMNA and RESULTADO = 'N';
    
    if shootNoExist = 1 then
      PROXIMAFILA := ENFILA+1;
      PROXIMACOLUMNA := ENCOLUMNA;
      enter := true;
    end if;
  
  end if;
  
  -- up
  
  if enter = false and ((ENFILA - 1) >= 1)  then
  
    select count(*) into shootNoExist from MYBOARD where FILA = (ENFILA - 1) and COLUMNA = ENCOLUMNA and RESULTADO = 'N';
    
    if shootNoExist = 1 then
      PROXIMAFILA := ENFILA-1;
      PROXIMACOLUMNA := ENCOLUMNA;
      enter := true;
    end if;
  
  end if;
  
  -- left
  
  if enter = false and ((ENCOLUMNA - 1) >= 1)  then
  
    select count(*) into shootNoExist from MYBOARD where FILA = ENFILA and COLUMNA = (ENCOLUMNA-1) and RESULTADO = 'N';
    
    if shootNoExist = 1 then
      PROXIMAFILA := ENFILA;
      PROXIMACOLUMNA := (ENCOLUMNA-1);
      enter := true;
    end if;
  
  end if;
  
  if not(enter) then
    PROXIMAFILA := 0;
    PROXIMACOLUMNA := 0;
  end if;
  
END MOVIMIENTO;

/
