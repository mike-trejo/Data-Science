--Excercise 1: Using Joins
--Question 1
select CPS.name_of_school, CPS.community_area_name, CPS.average_student_attendance
from chicago_public_schools AS CPS left outer join census_data AS CD
on CPS.community_area_number = CD.community_area_number
where CD.hardship_index = 98;

--Question 3
CREATE VIEW VIEW1 
AS SELECT NAME_OF_SCHOOL AS School_Name, SAFETY_ICON AS Safety_Rating, 
FAMILY_INVOLVEMENT_ICON AS Family_Rating, ENVIRONMENT_ICON AS Environment_Rating, 
INSTRUCTION_ICON AS Instruction_Rating, LEADERS_ICON AS Leaders_Rating, 
TEACHERS_ICON AS Teachers_Rating
FROM CHICAGO_PUBLIC_SCHOOLS;

SELECT SCHOOL_NAME, LEADERS_RATING FROM VIEW1;

--
--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE(IN SCID INTEGER, IN SCORE INTEGER)
LANGUAGE SQL
MODIFIES SQL DATA
BEGIN 
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET "Leaders_Score"= SCORE
	WHERE "School_ID" = SCID;
END
@

--#SET TERMINATOR @ 
CREATE PROCEDURE  UPDATE_LEADERS_SCORE(IN SCID INTEGER, IN SCORE INTEGER)
LANGUAGE SQL MODIFIES SQL DATA
DYNAMIC RESULT SETS 1
BEGIN
	UPDATE CHICAGO_PUBLIC_SCHOOLS
	SET "Leaders_Score"= SCORE
	WHERE "School_ID" = SCID;
	--Q3.3 Creating a Stored Procedure: Inside your stored procedure, write a SQL IF statement to update the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID using the following information.
	IF SCORE > 0 AND Score < 20 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET "Leaders_Icon" = 'Very_weak'
		WHERE "School_ID" = SCID;

	ELSEIF in_Leaders_Score < 40 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET "Leaders_Icon" = 'Weak'
		WHERE "School_ID" = SCID;

	ELSEIF in_Leaders_Score < 60 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET "Leaders_Icon" = 'Average'
		WHERE "School_ID" = SCID;

	ELSEIF SCORE < 80 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET "Leaders_Icon" = 'Strong'
		WHERE "School_ID" = SCID;

	ELSEIF SCORE < 100 THEN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET "Leaders_Icon" = 'Very_strong'
		WHERE "School_ID" = SCID;
	ELSE
		ROLLBACK
	END IF;
	COMMIT;
END
@