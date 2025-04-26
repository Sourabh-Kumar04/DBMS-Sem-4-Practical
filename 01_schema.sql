-- schema.sql

-- Drop tables if they already exist
DROP TABLE IF EXISTS ENROLLMENT;
DROP TABLE IF EXISTS STUDENT;
DROP TABLE IF EXISTS SOCIETY;

-- Create STUDENT table
CREATE TABLE STUDENT (
    RollNo CHAR(6) PRIMARY KEY,
    StudentName VARCHAR(20),
    Course VARCHAR(10),
    DOB DATE
);

-- Create SOCIETY table
CREATE TABLE SOCIETY (
    SocID CHAR(6) PRIMARY KEY,
    SocName VARCHAR(20),
    MentorName VARCHAR(15),
    TotalSeats UNSIGNED INT
);

-- Create ENROLLMENT table
CREATE TABLE ENROLLMENT (
    RollNo CHAR(6),
    SID CHAR(6),
    DateOfEnrollment DATE,
    FOREIGN KEY (RollNo) REFERENCES STUDENT(RollNo),
    FOREIGN KEY (SID) REFERENCES SOCIETY(SocID)
);
