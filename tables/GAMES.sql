--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table GAMES
--------------------------------------------------------

  CREATE TABLE "GAMES" 
   (	"ID" NUMBER, 
	"SHIPS" NUMBER DEFAULT 0, 
	"HEIGHT" NUMBER DEFAULT 0, 
	"WIDTH" NUMBER DEFAULT 0, 
	"BALLS" NUMBER DEFAULT 0
   ) ;
--------------------------------------------------------
--  DDL for Index GAMES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAMES_PK" ON "GAMES" ("ID") 
  ;
--------------------------------------------------------
--  Constraints for Table GAMES
--------------------------------------------------------

  ALTER TABLE "GAMES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "GAMES" MODIFY ("SHIPS" NOT NULL ENABLE);
  ALTER TABLE "GAMES" MODIFY ("HEIGHT" NOT NULL ENABLE);
  ALTER TABLE "GAMES" MODIFY ("WIDTH" NOT NULL ENABLE);
  ALTER TABLE "GAMES" MODIFY ("BALLS" NOT NULL ENABLE);
  ALTER TABLE "GAMES" ADD CONSTRAINT "GAMES_PK" PRIMARY KEY ("ID") ENABLE;
