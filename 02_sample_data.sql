-- sample_data.sql

-- Insert students
INSERT INTO STUDENT VALUES ('S001', 'Aman Singh', 'CS', '2002-05-12');
INSERT INTO STUDENT VALUES ('S002', 'Bhavya Jain', 'Chemistry', '2003-07-22');
INSERT INTO STUDENT VALUES ('S003', 'Arjun Gupta', 'Physics', '2001-09-14');
INSERT INTO STUDENT VALUES ('S004', 'Divya Kapoor', 'CS', '2002-11-03');

-- Insert societies
INSERT INTO SOCIETY VALUES ('SC001', 'Debating', 'Mr. Sharma', 50);
INSERT INTO SOCIETY VALUES ('SC002', 'Sashakt', 'Ms. Mehta', 30);
INSERT INTO SOCIETY VALUES ('SC003', 'Dancing', 'Mr. Verma', 40);

-- Insert enrollments
INSERT INTO ENROLLMENT VALUES ('S001', 'SC001', '2023-01-10');
INSERT INTO ENROLLMENT VALUES ('S002', 'SC002', '2023-01-11');
INSERT INTO ENROLLMENT VALUES ('S003', 'SC001', '2023-01-12');
