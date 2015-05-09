--------------------------------------------------------
-- Archivo creado  - sábado-mayo-09-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure MOVIMIENTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."MOVIMIENTO" 
(
  FILA IN NUMBER 
, COLUMNA IN NUMBER 
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
  
  if ((COLUMNA + 1) <= ANCHO)  then
  
    select count(*) into shootNoExist 
    from MYBOARD 
    where FILA = FILA and COLUMNA = (COLUMNA+1) and RESULTADO = 'N';
    
    if shootNoExist = 0 then
      PROXIMAFILA := FILA;
      PROXIMACOLUMNA := COLUMNA+1;
      enter := true;
    end if;
  
  end if;
  
  -- down
  
  if ((FILA + 1) <= LARGO)  then
  
    select count(*) into shootNoExist 
    from MYBOARD 
    where FILA = (FILA+1) and COLUMNA = COLUMNA and RESULTADO = 'N';
    
    if shootNoExist = 0 then
      PROXIMAFILA := FILA+1;
      PROXIMACOLUMNA := COLUMNA;
      enter := true;
    end if;
  
  end if;
  
  -- up
  
  if ((FILA - 1) >= 1)  then
  
    select count(*) into shootNoExist 
    from MYBOARD 
    where FILA = (FILA - 1) and COLUMNA = COLUMNA and RESULTADO = 'N';
    
    if shootNoExist = 0 then
      PROXIMAFILA := FILA-1;
      PROXIMACOLUMNA := COLUMNA;
      enter := true;
    end if;
  
  end if;
  
  -- left
  
  if ((COLUMNA - 1) >= 1)  then
  
    select count(*) into shootNoExist 
    from MYBOARD 
    where FILA = FILA and COLUMNA = (COLUMNA-1) and RESULTADO = 'N';
    
    if shootNoExist = 0 then
      PROXIMAFILA := FILA;
      PROXIMACOLUMNA := (COLUMNA-1);
      enter := true;
    end if;
  
  end if;
  
  if not(enter) then
    PROXIMAFILA := 0;
    PROXIMACOLUMNA := 0;
  end if;
  
END MOVIMIENTO;

/
