DELIMITER ;;
CREATE DEFINER=`ineqbench_user`@`%` PROCEDURE `getCarOutput`(IN start_age int(2), IN end_age int(2), IN sexIn VARCHAR(25), IN locality VARCHAR(25))
BEGIN
SELECT (
	SELECT REPLACE(FORMAT(SUM(ALL_PEOPLE)*(SELECT  SUM(PERCENT)/100
FROM POP_AGE_PERCENT
WHERE AGE BETWEEN start_age AND end_age),0),',','')
	FROM CAR_AVAILABILITY
	WHERE SEX = sexIn
	AND AGE != 'Total'
	AND (locality = "Dumfries & Galloway" 
		OR DATA_ZONE in (SELECT Datazone FROM GEOGRAPHY_LOOKUP WHERE locality = GEOGRAPHY_LOOKUP.Locality)  )
    ) AS 'totalPopulation',

(SELECT REPLACE(FORMAT((SUM(NO_CAR))*(SELECT  SUM(PERCENT)/100
FROM POP_AGE_PERCENT
WHERE AGE BETWEEN start_age AND end_age),0),',','')
FROM CAR_AVAILABILITY
WHERE SEX = sexIn
AND AGE != 'Total'
AND (locality = "Dumfries & Galloway" 
	OR DATA_ZONE in (SELECT Datazone FROM GEOGRAPHY_LOOKUP WHERE locality = GEOGRAPHY_LOOKUP.Locality)  )
) AS 'totalDeprived';
END ;;
DELIMITER ;