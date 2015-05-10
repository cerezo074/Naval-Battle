--------------------------------------------------------
-- Archivo creado  - domingo-mayo-10-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function RANDOMINRANGE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SYSTEM"."RANDOMINRANGE" (a IN int,b IN int) 
return number
is
begin
return trunc(abs(( GREATEST(a,b) - LEAST(a,b) + 1 ) * abs(dbms_random.value)) + LEAST(a,b));
end;

/
