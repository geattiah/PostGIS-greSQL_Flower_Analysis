--Simple script to prepare attributes
--Author: Gifty Attiah
--Date: 30/03/2020

--Reading the table
SELECT * FROM flower_data;

--ADDING COLUMN TO DATA
--Add Date column to the data
ALTER TABLE flower_data
ADD COLUMN Date CHARACTER VARYING(10),
--Add Code column to the data
ADD COLUMN Code CHARACTER VARYING(3);

--RENAMING COLUMNS IN THE DATA
--Renaming the column Flower to Flo_color
ALTER TABLE flower_data 
RENAME COLUMN Flower TO Flo_color,
--Renaming the column F_shape to Flo_shape
RENAME COLUMN F_shape TO Flo_shape,
--Renaming the column F_count to Flo_count
RENAME COLUMN F_count TO Flo_count,
--Renaming the column Developed to Matured
RENAME COLUMN Developed TO Matured;

--Update date by concatenating the year, month and day
UPDATE flower_data SET date = CONCAT_WS('/', year, month, day);

--Update Codes for the data by subseting parts of the flower colour
UPDATE flower_data SET code = UPPER(CONCAT(SUBSTRING(flo_color,1,2),RIGHT(flo_color,1)));

--Drop Key value becuase it is not needed any more
ALTER TABLE flower_data 
DROP COLUMN key

--END
