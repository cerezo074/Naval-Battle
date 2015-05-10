--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure DISPARAR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."DISPARAR" AS 

ancho number := 4;
largo number := 6;
disparos number := 0;

impacto number := 0;
lugarDisparado number := 0;
juegoIniciado number := 0;

aleatorioFila Number := 0;
aleatorioColumna Number := 0;
resultado Number := 0;
disparoNoUsado Number := 0;
usarAleatorio Boolean := false;
backTracking Boolean := false;--cuando no podemos movernos o no hay un siguiente movimiento
huboTiroBueno Boolean := false;
proximaFila Number := 0;
proximaColumna Number := 0;
ultimoTiroBuenoFila Number := 0;
ultimoTiroBuenoColumna Number := 0;

estrategia Boolean := true;
validarDesvio Boolean := false;
marcadorFila Number;
marcadorColumna Number;

centinela Boolean := false;
cont Number := 0;

disparosPermitidos Number := 0;
indiceActualTirosBuenos Number := 0;

--No se usan
v_hundidos Number := 0;
v_error Varchar2(1000);

BEGIN
  
  --esto es para prueba ADAED

  delete from PRUEBAPROFE;
  
  for i in 1..largo loop

    for j in 1..ancho loop 
    
      insert into PRUEBAPROFE values (j,i,0);
    
    end loop;

  end loop;
  
/*
  update PRUEBAPROFE set ocupado = 1 where col = 3 and fila = 4;
  update PRUEBAPROFE set ocupado = 1 where col = 3 and fila = 5;
  update PRUEBAPROFE set ocupado = 1 where col = 3 and fila = 6;
  
  update PRUEBAPROFE set ocupado = 1 where col = 1 and fila = 4;
  update PRUEBAPROFE set ocupado = 1 where col = 2 and fila = 4;
  update PRUEBAPROFE set ocupado = 1 where col = 5 and fila = 5;
  update PRUEBAPROFE set ocupado = 1 where col = 6 and fila = 5; 
  update PRUEBAPROFE set ocupado = 1 where col = 7 and fila = 5;
  update PRUEBAPROFE set ocupado = 1 where col = 8 and fila = 5;
  update PRUEBAPROFE set ocupado = 1 where col = 9 and fila = 5; 
  update PRUEBAPROFE set ocupado = 1 where col = 10 and fila = 5;
  update PRUEBAPROFE set ocupado = 1 where col = 7 and fila = 3;
  update PRUEBAPROFE set ocupado = 1 where col = 7 and fila = 4; 
  update PRUEBAPROFE set ocupado = 1 where col = 7 and fila = 5;
  update PRUEBAPROFE set ocupado = 1 where col = 7 and fila = 6; 
  update PRUEBAPROFE set ocupado = 1 where col = 7 and fila = 7;
  update PRUEBAPROFE set ocupado = 1 where col = 5 and fila = 3;
  update PRUEBAPROFE set ocupado = 1 where col = 8 and fila = 3;
  update PRUEBAPROFE set ocupado = 1 where col = 6 and fila = 3;
  update PRUEBAPROFE set ocupado = 1 where col = 7 and fila = 2;
 */ 
  --prueba ADAED
  
  --tomamos el ancho y el largo de las configuraciones
  --select NMANCHO, NMLARGO into ancho, largo from VBN1_PARAMETROS;
  
  delete from MYBOARD;
  delete from GOODSHOOTS;
    
  for i in 1..largo loop

    for j in 1..ancho loop 
    
      insert into MYBOARD values (j,i,'N',0);
    
    end loop;

  end loop; 
  commit;
  
  --Leer Disparos
  --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
  disparos := 15;
  
  marcadorFila := 3;
  marcadorColumna := 1;
  aleatorioFila := marcadorFila;
  aleatorioColumna := marcadorColumna;
  
  loop
    
    --Leer la variable CDESTADO y asigarlo a juego iniciado
    --SELECT CDESTADO into juegoIniciado FROM into salvarez_bn.VBN1_PARAMETROS;
    juegoIniciado := 1;
    
    DBMS_OUTPUT.PUT_LINE('Intentando disparar');
    
    if juegoIniciado = 1 then
    
      --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
      
      --Iniciamos la estrategia de aleatorio
      while disparos > 0 loop
        
        --SELECT NMDISPAROS into disparos FROM salvarez_bn.VBN1_USUARIOS;
        if not(estrategia) then
          if usarAleatorio then
            aleatorioFila := RANDOMINRANGE(1,largo);
            aleatorioColumna := RANDOMINRANGE(1,ancho);
          end if;
        end if;

        select count (*) into disparoNoUsado from MYBOARD where columna = aleatorioColumna and fila = aleatorioFila and RESULTADO = 'N';
        
        if disparoNoUsado = 1 then
          
          --salvarez_bn.sp_disparo( aleatorioFila , aleatorioColumna , resultado, v_hundidos, v_error );
          select ocupado into resultado from PRUEBAPROFE where col = aleatorioColumna and fila = aleatorioFila; 
          
          if resultado = 1 then
            
            update MYBOARD set resultado = 'O', cantidad = 1 where columna = aleatorioColumna and fila = aleatorioFila;
            commit;
            --REMOVER, esto se hace solo
            disparos := disparos - 1;
            
            huboTiroBueno := true;
            backTracking := true;
            usarAleatorio := false;
            ultimoTiroBuenoFila := aleatorioFila;
            ultimoTiroBuenoColumna := aleatorioColumna;
            indiceActualTirosBuenos := indiceActualTirosBuenos + 1;
            
            MOVIMIENTO(aleatorioFila, aleatorioColumna,ancho,largo,proximaFila,proximaColumna);
            
            if not(proximaFila = 0 and proximaColumna = 0) then
                aleatorioFila := proximaFila;
                aleatorioColumna := proximaColumna;
            else
              --backtrack
              
              if indiceActualTirosBuenos = 1 then
                backTracking := false;
                if not(estrategia) then
                  usarAleatorio := true;
                end if;
              else
                
                --bucle para llegar a un indice bueno que se pueda mover BUCLE
                  
                  cont := indiceActualTirosBuenos - 1;
                  centinela := true;
                  
                if cont > 1 then
                  
                 loop
                    
                  select fila, columna into aleatorioFila, aleatorioColumna 
                  from GOODSHOOTS 
                  where lastindex = cont;
                  
                  MOVIMIENTO(aleatorioFila, aleatorioColumna,ancho,largo,proximaFila,proximaColumna);
                  
                  if proximaFila = 0 and proximaColumna = 0 then
                   backTracking := false;
                   if not(estrategia) then
                    usarAleatorio := true;
                   end if;
                  else
                   backTracking := true;
                   usarAleatorio := false;
                   aleatorioFila := proximaFila;
                   aleatorioColumna := proximaColumna;
                   centinela := false;
                  end if;--evalua si nos podemos mover en el anterior tiro bueno
                  
                  cont :=  cont - 1;
                  exit when (cont = 0 or centinela = false);
                  
                  end loop;
                
                else
                
                 backTracking := false;
                 if not(estrategia) then
                  usarAleatorio := true;
                 end if;
                
                end if;--valida si no esta en el primer tiro
                
                --BUCLE
                
              end if;--evalua if el primer tiro bueno no se puede mover
              
            end if;--evalua movimiento
            
          else--cuando fallamos el tiro
            
            update MYBOARD set resultado = 'X', cantidad = 0 where columna = aleatorioColumna and fila = aleatorioFila;
            commit;
            --REMOVER, esto se hace solo
            disparos := disparos - 1;
            
            if backTracking = true then
                           
              --bucle para llegar a un indice bueno que se pueda mover BUCLE
                  
              cont := indiceActualTirosBuenos;
              centinela := true;
                
              if cont >= 1 then
                
               loop
                  
                select fila, columna into aleatorioFila, aleatorioColumna 
                from GOODSHOOTS 
                where lastindex = cont;
                
                MOVIMIENTO(aleatorioFila, aleatorioColumna,ancho,largo,proximaFila,proximaColumna);
                
                if proximaFila = 0 and proximaColumna = 0 then
                 backTracking := false;
                 if not(estrategia) then
                  usarAleatorio := true;
                 end if;
                else
                 backTracking := true;
                 usarAleatorio := false;
                 aleatorioFila := proximaFila;
                 aleatorioColumna := proximaColumna;
                 centinela := false;
                end if;--evalua si nos podemos mover en el anterior tiro bueno
                
                cont :=  cont - 1;
                exit when (cont = 0 or centinela = false);
                
                end loop;
              
              else
              
               backTracking := false;
               if not(estrategia) then
                usarAleatorio := true;
               end if;
              
              end if;--valida si no esta en el primer tiro
                
                --BUCLE 
                           
            else--no veniamos haciendo backtracking
               backTracking := false;
               if not(estrategia) then
                usarAleatorio := true;
               end if; 
            end if;--evalua si venimos de un tiro bueno
            
          end if;--evaluacion disparo
          
          if huboTiroBueno then
            insert into GOODSHOOTS values(ultimoTiroBuenoFila,ultimoTiroBuenoColumna,indiceActualTirosBuenos);
            commit;
            huboTiroBueno := false;
          end if;--actualizacion tiros buenos
          
        end if;--disparo usado        
        
        if not(backTracking) then 
        
          if estrategia then
            
            marcadorFila := marcadorFila - 1;
            marcadorColumna := marcadorColumna + 1;
            aleatorioFila := marcadorFila;
            aleatorioColumna := marcadorColumna;
          
          end if;
          
          if estrategia then
          
            validarDesvio := false;
          
            if marcadorFila < 1 or marcadorColumna > ancho then
          
              marcadorFila := marcadorFila + 4;
              marcadorColumna := marcadorColumna - 1;
              aleatorioFila := marcadorFila;
              aleatorioColumna := marcadorColumna;
              validarDesvio := true;
          
            end if;
          
          end if;
          
          if estrategia then
          
            if marcadorFila > largo or marcadorColumna > ancho then
          
              estrategia := false;
              usarAleatorio := true;
              aleatorioFila := 0;
              aleatorioColumna := 0;
          
            else
            
                if validarDesvio then
                  
                  while marcadorFila < largo and marcadorColumna > 1 loop --hacemos un desvio en diagonal (izq,abajo) hasta que llegue a la ultima fila
          
                    marcadorFila := marcadorFila + 1;
                    marcadorColumna := marcadorColumna - 1;
          
                  end loop;
                  
                  aleatorioFila := marcadorFila;
                  aleatorioColumna := marcadorColumna;
                  validarDesvio := false;
                  
                end if;
                
            end if;
          
          end if;
        
        end if;
        
        select count(*) into disparosPermitidos from MYBOARD where RESULTADO = 'N';
        exit when disparosPermitidos <= 0;
        
      end loop;--while
      
    end if;--validacion de juego iniciado
    
    exit when juegoIniciado = 1;
    
  end loop;--bucle para esperar que el juego incio
  
  commit; 
  
  DBMS_OUTPUT.PUT_LINE('Disparos terminados');
  PRINTMYBOARD();
  IMPRIMEPROFESOR();
  
END DISPARAR;

/
