CREATE OR REPLACE PROCEDURE "SYSTEM"."DISPARAR" AS 

ancho number := 0;
largo number := 0;
disparos number := 0;

impacto number := 0;
lugarDisparado number := 0;
juegoIniciado number := 0;

BEGIN
  
  delete from pruebaprofe;
  
  --Leer Disparos
  --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
  disparos := 1;
  
  loop
    
    --Leer la variable CDESTADO desde y asigarlo a juego iniciado
    --SELECT CDESTADO FROM into salvarez_bn.VBN1_PARAMETROS;
    --juegoIniciado := 1;
    select batalla into juegoIniciado from batalla;
        
    DBMS_OUTPUT.PUT_LINE('Intentando disparar');
    
    if juegoIniciado = 1 then
      
      update pruebaprofe set ocupado = 1 where fila = 1 and col = 1;
      update pruebaprofe set ocupado = 1 where fila = 1 and col = 2;
      update pruebaprofe set ocupado = 1 where fila = 1 and col = 3;
      
      --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
    
      --Iniciamos la estrategia de aleatorio
      while disparos > 0 loop
        
        --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
        
        disparos := disparos - 1;
        
      end loop;
      
    end if;
    
    exit when juegoIniciado = 1;
    
  end loop;
  
  DBMS_OUTPUT.PUT_LINE('Procedimiento terminado');
  
END DISPARAR;

/