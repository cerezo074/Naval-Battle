--------------------------------------------------------
-- Archivo creado  - sábado-mayo-09-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure DISPARAR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."DISPARAR" AS 

ancho number := 10;
largo number := 10;
disparos number := 0;

impacto number := 0;
lugarDisparado number := 0;
juegoIniciado number := 0;

BEGIN
  
  --tomamos el ancho y el largo de las configuraciones
  --select NMANCHO, NMLARGO into ancho, largo from VBN1_PARAMETROS;
  
  delete from myboard;
  
  for i in 1..largo loop

    for j in 1..ancho loop 
    
      insert into MYBOARD values (i,j,'N',0);
    
    end loop;

  end loop; 
  
  --Leer Disparos
  --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
  disparos := 1;
  
  loop
    
    --Leer la variable CDESTADO desde y asigarlo a juego iniciado
    --SELECT CDESTADO into juegoIniciado FROM into salvarez_bn.VBN1_PARAMETROS;
    juegoIniciado := 1;
    
    DBMS_OUTPUT.PUT_LINE('Intentando disparar');
    
    if juegoIniciado = 1 then
      
      --disparamos en las 3 primeras posiciones
      update pruebaprofe set ocupado = 1 where fila = 1 and col = 1;
      update pruebaprofe set ocupado = 1 where fila = 1 and col = 2;
      update pruebaprofe set ocupado = 1 where fila = 1 and col = 3;
      
      --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
    
      --Iniciamos la estrategia de aleatorio
      while disparos > 0 loop
        
        --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
        DBMS_OUTPUT.PUT_LINE('BOOM!!!');
        disparos := disparos - 1;
        
      end loop;
      
    end if;
    
    exit when juegoIniciado = 1;
    
  end loop;
    
END DISPARAR;

/
