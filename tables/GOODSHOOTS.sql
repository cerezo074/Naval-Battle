--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table GOODSHOOTS
--------------------------------------------------------

  CREATE TABLE "GOODSHOOTS" 
   (	"FILA" NUMBER DEFAULT 0, 
	"COLUMNA" NUMBER DEFAULT 0, 
	"LASTINDEX" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Index GOODSHOOTS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GOODSHOOTS_PK" ON "GOODSHOOTS" ("FILA", "COLUMNA") 
  ;
--------------------------------------------------------
--  Constraints for Table GOODSHOOTS
--------------------------------------------------------

  ALTER TABLE "GOODSHOOTS" MODIFY ("LASTINDEX" NOT NULL ENABLE);
  ALTER TABLE "GOODSHOOTS" ADD CONSTRAINT "GOODSHOOTS_PK" PRIMARY KEY ("FILA", "COLUMNA") ENABLE;
  ALTER TABLE "GOODSHOOTS" MODIFY ("COLUMNA" NOT NULL ENABLE);
  ALTER TABLE "GOODSHOOTS" MODIFY ("FILA" NOT NULL ENABLE);
