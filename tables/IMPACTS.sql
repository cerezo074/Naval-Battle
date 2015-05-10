--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table IMPACTS
--------------------------------------------------------

  CREATE TABLE "IMPACTS" 
   (	"SHIPID" NUMBER(*,0), 
	"AGGRESSOR" VARCHAR2(50), 
	"TIMEIMPACT" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Index IMPACTS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "IMPACTS_PK" ON "IMPACTS" ("TIMEIMPACT") 
  ;
--------------------------------------------------------
--  Constraints for Table IMPACTS
--------------------------------------------------------

  ALTER TABLE "IMPACTS" ADD CONSTRAINT "IMPACTS_PK" PRIMARY KEY ("TIMEIMPACT") ENABLE;
  ALTER TABLE "IMPACTS" MODIFY ("TIMEIMPACT" NOT NULL ENABLE);
