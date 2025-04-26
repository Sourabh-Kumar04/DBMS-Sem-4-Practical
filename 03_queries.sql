-- queries.sql

-- 1. Names of students enrolled in any society
SELECT DISTINCT StudentName
FROM STUDENT
JOIN ENROLLMENT ON STUDENT.RollNo = ENROLLMENT.RollNo;

-- 2. All society names
SELECT SocName FROM SOCIETY;

-- 3. Students' names starting with 'A'
SELECT StudentName FROM STUDENT
WHERE StudentName LIKE 'A%';

-- 4. Students studying in 'computer science' or 'chemistry'
SELECT * FROM STUDENT
WHERE Course IN ('computer science', 'chemistry');

-- 5. Students whose roll number neither starts with 'X' nor 'Z' and ends with '9'
SELECT StudentName FROM STUDENT
WHERE RollNo NOT LIKE 'X%' AND RollNo NOT LIKE 'Z%' AND RollNo LIKE '%9';

-- 6. Societies with more than N total seats (assuming N = 35)
SELECT * FROM SOCIETY
WHERE TotalSeats > 35;

-- 7. Update mentor name
UPDATE SOCIETY
SET MentorName = 'New Mentor'
WHERE SocName = 'Debating';

-- 8. Societies with more than 5 students enrolled
SELECT SocName 
FROM SOCIETY
JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
GROUP BY SocName
HAVING COUNT(*) > 5;

-- 9. Youngest student in 'NSS'
SELECT StudentName
FROM STUDENT
JOIN ENROLLMENT ON STUDENT.RollNo = ENROLLMENT.RollNo
WHERE ENROLLMENT.SID = 'NSS'
ORDER BY DOB DESC
LIMIT 1;

-- 10. Most popular society
SELECT SocName 
FROM SOCIETY
JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
GROUP BY SocName
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 11. Two least popular societies
SELECT SocName
FROM SOCIETY
JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
GROUP BY SocName
ORDER BY COUNT(*) ASC
LIMIT 2;

-- 12. Students not enrolled in any society
SELECT StudentName
FROM STUDENT
WHERE RollNo NOT IN (SELECT RollNo FROM ENROLLMENT);

-- 13. Students enrolled in at least two societies
SELECT StudentName
FROM STUDENT
JOIN ENROLLMENT ON STUDENT.RollNo = ENROLLMENT.RollNo
GROUP BY STUDENT.RollNo
HAVING COUNT(SID) >= 2;

-- 14. Societies with maximum enrollment
SELECT SocName
FROM SOCIETY
JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
GROUP BY SocName
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 15. Students enrolled in society and society names
SELECT StudentName, SocName
FROM STUDENT
JOIN ENROLLMENT ON STUDENT.RollNo = ENROLLMENT.RollNo
JOIN SOCIETY ON SOCIETY.SocID = ENROLLMENT.SID;

-- 16. Students enrolled in Debating, Dancing, Sashakt
SELECT DISTINCT StudentName
FROM STUDENT
JOIN ENROLLMENT ON STUDENT.RollNo = ENROLLMENT.RollNo
WHERE SID IN ('SC001', 'SC002', 'SC003');

-- 17. Societies whose mentor name has 'Gupta'
SELECT SocName
FROM SOCIETY
WHERE MentorName LIKE '%Gupta%';

-- 18. Societies with <=10% enrollment
SELECT SocName
FROM SOCIETY
LEFT JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
GROUP BY SocName, TotalSeats
HAVING COUNT(ENROLLMENT.RollNo) <= 0.1 * TotalSeats;

-- 19. Vacant seats in each society
SELECT SocName, TotalSeats - COUNT(ENROLLMENT.RollNo) AS VacantSeats
FROM SOCIETY
LEFT JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
GROUP BY SocName, TotalSeats;

-- 20. Increase total seats by 10%
UPDATE SOCIETY
SET TotalSeats = TotalSeats * 1.1;

-- 21. Add enrollment fee paid column
ALTER TABLE ENROLLMENT
ADD COLUMN EnrollmentFeePaid ENUM('yes', 'no');

-- 22. Update enrollment dates
UPDATE ENROLLMENT
SET DateOfEnrollment = CASE 
    WHEN SID = 's1' THEN '2018-01-15'
    WHEN SID = 's2' THEN '2018-01-15'
    WHEN SID = 's3' THEN '2018-01-02'
END;

-- 23. Create a view for society enrollment
CREATE VIEW SocietyEnrollment AS
SELECT SocName, COUNT(ENROLLMENT.RollNo) AS TotalStudents
FROM SOCIETY
LEFT JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
GROUP BY SocName;

-- 24. Students enrolled in all societies
SELECT StudentName
FROM STUDENT
WHERE NOT EXISTS (
    SELECT *
    FROM SOCIETY
    WHERE NOT EXISTS (
        SELECT *
        FROM ENROLLMENT
        WHERE ENROLLMENT.RollNo = STUDENT.RollNo AND ENROLLMENT.SID = SOCIETY.SocID
    )
);

-- 25. Count societies with >5 students
SELECT COUNT(*)
FROM (
    SELECT SocID
    FROM ENROLLMENT
    GROUP BY SID
    HAVING COUNT(*) > 5
) AS t;

-- 26. Add mobile number column
ALTER TABLE STUDENT
ADD COLUMN MobileNo VARCHAR(15) DEFAULT '9999999999';

-- 27. Students with age >20
SELECT COUNT(*)
FROM STUDENT
WHERE TIMESTAMPDIFF(YEAR, DOB, CURDATE()) > 20;

-- 28. Students born in 2001 and enrolled
SELECT StudentName
FROM STUDENT
JOIN ENROLLMENT ON STUDENT.RollNo = ENROLLMENT.RollNo
WHERE YEAR(DOB) = 2001;

-- 29. Count societies starting with 'S' and ending with 't' and have at least 5 students
SELECT COUNT(*)
FROM SOCIETY
JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
WHERE SocName LIKE 'S%t'
GROUP BY SOCIETY.SocID
HAVING COUNT(ENROLLMENT.RollNo) >= 5;

-- 30. Society info with total and unfilled seats
SELECT SocName, MentorName, TotalSeats, COUNT(ENROLLMENT.RollNo) AS TotalEnrolled, 
       (TotalSeats - COUNT(ENROLLMENT.RollNo)) AS UnfilledSeats
FROM SOCIETY
LEFT JOIN ENROLLMENT ON SOCIETY.SocID = ENROLLMENT.SID
GROUP BY SocName, MentorName, TotalSeats;
