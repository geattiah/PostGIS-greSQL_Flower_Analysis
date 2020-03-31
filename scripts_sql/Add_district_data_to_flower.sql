--Basic scripts to add district information to data
--Author: Gifty E. A. Attiah
--Date : 31st March, 2020

--View all data in sh_districts
SELECT * FROM sh_districts;

--View all data in flower_data
SELECT * FROM flower_data;

--Create table intesecting the flower data with the sh districts
CREATE TABLE flower_1
as
SELECT DISTINCT ON(f.gid) f.*, s.gen, s.state
FROM flower_data AS f
JOIN  sh_districts AS s
ON  ST_INTERSECTS(f.geom,s.geom);

--View result data in flower_1
SELECT * FROM flower_1;

--Create table containing the flower data with the sh districts which do not intersect
CREATE TABLE flower_2
AS
SELECT  f.*, s.gen, s.state
FROM flower_data AS f LEFT JOIN  
sh_districts AS s
ON  ST_INTERSECTS(f.geom,s.geom)
where s.gid IS NULL;

--View result data in flower_2
SELECT * FROM flower_2;

--Join the two tables together 
CREATE TABLE flower_dataset
AS
SELECT * FROM flower_1
UNION
SELECT * FROM flower_2;

--View result data in flower_dataset
SELECT * FROM flower_dataset;

--Delete interim tables
DROP TABLE flower_1;
DROP TABLE flower_2;

--Change the name of the column gen to district
ALTER TABLE flower_dataset
RENAME COLUMN gen TO district;

--Update null values in district to outside
UPDATE flower_dataset
SET district = 'Outside'
WHERE
   district IS NULL;

--Update null values in state to none
UPDATE flower_dataset
SET state = 'None'
WHERE
   state IS NULL;
   

--View result data in flower_dataset
SELECT * FROM flower_dataset;  
--END   
