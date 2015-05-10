--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PRINTMYBOARD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."PRINTMYBOARD" AS 

-- Declare variables

columna MYBOARD.COLUMNA%TYPE := 0;
fila MYBOARD.FILA%TYPE := 0;
resultado MYBOARD.RESULTADO%TYPE := 0;
cantidad MYBOARD.CANTIDAD%TYPE := 0;

filaActual Number := 0;
resultString VARCHAR2(10000);

-- Declare Cursors

CURSOR RESULTS is select * from MYBOARD order by FILA, COLUMNA asc;
  
  
BEGIN
  
  filaActual := 1;
  open RESULTS;
  
  loop
  
    fetch RESULTS into columna, fila, resultado, cantidad;
    exit when RESULTS%NOTFOUND;
    
    if filaActual != fila then
      resultString := resultString || CHR(10);
      filaActual := fila;
    end if;
  
    if resultado = 'N' then
      resultString := resultString || /*' O'*/' N';
    elsif resultado = 'X' then
      resultString := resultString || ' X';
    else
      if cantidad > 10 then
        resultString := resultString ||' '||TO_CHAR(cantidad);
      else 
        resultString := resultString ||' '||TO_CHAR(cantidad);
      end if;
      
    end if;
  
  end loop;
  
  close RESULTS;
  
  DBMS_OUTPUT.PUT_LINE(CHR(10)||'El resultado es: '||CHR(10)||CHR(10)||resultString||CHR(10));
  
END PRINTMYBOARD;

/
