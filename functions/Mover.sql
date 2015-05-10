--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function SE_PUEDE_MOVER
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SYSTEM"."SE_PUEDE_MOVER" 
(
  FILA IN NUMBER 
, COLUMNA IN NUMBER 
, ANCHO IN NUMBER 
, LARGO IN NUMBER 
) RETURN BOOLEAN AS

shootNoExist Number := 0;

BEGIN
  
  -- rigth
  
  if ((COLUMNA + 1) <= ANCHO)  then
  
    select count(*) into shootNoExist 
    from MYBOARD 
    where FILA = FILA and COLUMNA = (COLUMNA+1) and RESULTADO = 'N';
    
    if shootNoExist = 0 then
      return true;
    end if;
  
  end if;
  
  -- down
  
  if ((FILA + 1) <= LARGO)  then
  
    select count(*) into shootNoExist 
    from MYBOARD 
    where FILA = (FILA+1) and COLUMNA = COLUMNA and RESULTADO = 'N';
    
    if shootNoExist = 0 then
      return true;
    end if;
  
  end if;
  
  -- up
  
  if ((FILA - 1) >= 1)  then
  
    select count(*) into shootNoExist 
    from MYBOARD 
    where FILA = (FILA - 1) and COLUMNA = COLUMNA and RESULTADO = 'N';
    
    if shootNoExist = 0 then
      return true;
    end if;
  
  end if;
  
  -- left
  
  if ((COLUMNA - 1) >= 1)  then
  
    select count(*) into shootNoExist 
    from MYBOARD 
    where FILA = FILA and COLUMNA = (COLUMNA-1) and RESULTADO = 'N';
    
    if shootNoExist = 0 then
      return true;
    end if;
  
  end if;
  
  return false;
  
END SE_PUEDE_MOVER;

/
