--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table MYBOARD
--------------------------------------------------------

  CREATE TABLE "MYBOARD" 
   (	"COLUMNA" NUMBER DEFAULT 0, 
	"FILA" NUMBER DEFAULT 0, 
	"RESULTADO" VARCHAR2(1) DEFAULT 'N', 
	"CANTIDAD" NUMBER DEFAULT 0
   ) ;
--------------------------------------------------------
--  DDL for Index MYBOARD_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MYBOARD_PK" ON "MYBOARD" ("COLUMNA", "FILA") 
  ;
--------------------------------------------------------
--  Constraints for Table MYBOARD
--------------------------------------------------------

  ALTER TABLE "MYBOARD" ADD CONSTRAINT "MYBOARD_PK" PRIMARY KEY ("COLUMNA", "FILA") ENABLE;
  ALTER TABLE "MYBOARD" MODIFY ("RESULTADO" NOT NULL ENABLE);
  ALTER TABLE "MYBOARD" MODIFY ("FILA" NOT NULL ENABLE);
  ALTER TABLE "MYBOARD" MODIFY ("COLUMNA" NOT NULL ENABLE);
