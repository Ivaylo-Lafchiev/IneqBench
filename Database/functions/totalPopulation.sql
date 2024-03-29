DROP FUNCTION IF EXISTS totalPopulation;
CREATE DEFINER=`root`@`localhost` FUNCTION `totalPopulation`(start_age int(2),
								end_age int(2),
								sexIn VARCHAR(25),
								locality VARCHAR(25)) RETURNS int(11)
/* this function is used to get the total population of a locality given start age, end age, and sex
to be used by the procedures to get the totalPopulation field for the result
*/
BEGIN
DECLARE RESULT INT;

SET RESULT = (SELECT REPLACE(FORMAT(POPULATION*(SELECT PERCENT/100
				   FROM POP_GENDER_PERCENT
                   WHERE GENDER = sexIn)*
                   (SELECT SUM(PERCENT)/100
                    FROM POP_AGE_PERCENT
					WHERE AGE BETWEEN start_age AND end_age),0),',','')
FROM LOCALITY_POPULATION
WHERE AREA = locality);
RETURN result;
END
