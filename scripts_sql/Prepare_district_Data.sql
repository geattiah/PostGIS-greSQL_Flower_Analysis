--BASIC SCRIPT TO PREPARE DISTRICT/STATE DATE
--Author : Gifty E. A. Attiah
--30th March, 2020

--View the germany states data
SELECT * FROM germany_states;

--View the germany districts data
SELECT * FROM germany_district;

--View the germany districts data
SELECT * FROM flower_data;

--Create a table based on Schlewig Holstein state
CREATE TABLE sh
AS
SELECT * FROM germany_states
WHERE gen = 'Schleswig-Holstein';

--View the sh output data
SELECT * FROM sh;

--Rename the name gen to state
ALTER TABLE sh
RENAME COLUMN gen TO State;

--Create a table with districts within Schlewig holstein
CREATE TABLE sh_districts
AS
SELECT sh.state, g.geom, g.gid, g.gen, 
      st_union(ST_INTERSECTION(sh.geom, g.geom))
FROM sh, germany_district AS g
WHERE ST_Intersects(sh.geom, g.geom)
GROUP BY sh.state,g.gid, g.gen, g.geom;

--View the sh_districts output dats
SELECT * FROM sh_districts;

--END

