-- admin_commands.sql

-- Create user
CREATE USER 'studentuser'@'localhost' IDENTIFIED BY 'password123';

-- Create role
CREATE ROLE 'society_admin';

-- Grant privileges to role
GRANT ALL PRIVILEGES ON *.* TO 'society_admin';

-- Grant role to user
GRANT 'society_admin' TO 'studentuser';

-- Revoke privileges from role
REVOKE ALL PRIVILEGES ON *.* FROM 'society_admin';

-- Create an index
CREATE INDEX idx_rollno ON STUDENT(RollNo);
