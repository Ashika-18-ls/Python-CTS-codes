CREATE DATABASE college_db;

USE college_db;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    hod_name VARCHAR(100),
    budget DECIMAL(12,2)
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    department_id INT,
    enrollment_year INT,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

CREATE TABLE courses (
	course_id INT AUTO_INCREMENT PRIMARY KEY, 
	course_name VARCHAR(150) NOT NULL,
	course_code VARCHAR(20) UNIQUE,
	credits INT,
	department_id INT,
    
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

CREATE TABLE enrollments (
	enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
	student_id INT, 
	course_id INT,
	enrollment_date DATE,
	grade CHAR(2),
    
    FOREIGN KEY (student_id)
    REFERENCES students(student_id),
    
    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
);

CREATE TABLE professors(
	professor_id INT AUTO_INCREMENT PRIMARY KEY,
	prof_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE,
	department_id INT,
	salary DECIMAL(10,2),
    
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

SHOW TABLES;

DESCRIBE departments;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE professors;
  
  -- ==========================
-- NORMALIZATION ANALYSIS
-- ==========================

-- 1NF:
-- All columns contain atomic values.
-- Example violation: storing multiple phone numbers
-- in a single column such as '9876543210,9876543211'.

-- 2NF:
-- Every non-key attribute is fully dependent on
-- the primary key.
-- In enrollments, enrollment_date and grade depend
-- on the enrollment record, not partially on student_id
-- or course_id alone.

-- 3NF:
-- No transitive dependencies exist.
-- Department information is stored separately in
-- departments table and referenced through department_id.

-- If dept_name were stored directly in students table,
-- it would create redundancy and violate 3NF.

-- Enrollments table satisfies 3NF because grade and
-- enrollment_date depend directly on enrollment_id.

ALTER TABLE students ADD phone_number VARCHAR(15);

ALTER TABLE courses ADD max_seats INT DEFAULT 60;

ALTER TABLE enrollments 
ADD CONSTRAINT chk_grade
CHECK (grade IN ('A','B','C','D','F') OR grade IS NULL);

ALTER TABLE departments RENAME COLUMN hod_name TO head_of_dept;

ALTER TABLE students DROP COLUMN phone_number;

DESCRIBE departments;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE professors;

-- HANDS-ON 2 Task 1: Insert, Update and Delete Data

-- departments
INSERT INTO departments (dept_name, head_of_dept, budget) VALUES
  ('Computer Science', 'Dr. Ramesh Kumar', 850000.00),
  ('Electronics', 'Dr. Priya Nair', 620000.00),
  ('Mechanical', 'Dr. Suresh Iyer', 540000.00),
  ('Civil', 'Dr. Ananya Sharma', 430000.00);
  
-- students
INSERT INTO students (first_name, last_name, email, date_of_birth, department_id, 
enrollment_year) VALUES
  ('Arjun',  'Mehta',    'arjun.mehta@college.edu',    '2003-04-12', 1, 2022),
  ('Priya',  'Suresh',   'priya.suresh@college.edu',   '2003-07-25', 1, 2022),
  ('Rohan',  'Verma',    'rohan.verma@college.edu',    '2002-11-08', 2, 2021),
  ('Sneha',  'Patel',    'sneha.patel@college.edu',    '2004-01-30', 3, 2023),
  ('Vikram', 'Das',      'vikram.das@college.edu',     '2003-09-14', 1, 2022),
  ('Kavya',  'Menon',    'kavya.menon@college.edu',    '2002-05-17', 2, 2021),
  ('Aditya', 'Singh',    'aditya.singh@college.edu',   '2004-03-22', 4, 2023),
  ('Deepika','Rao',      'deepika.rao@college.edu',    '2003-08-09', 1, 2022);
  
-- courses
INSERT INTO courses (course_name, course_code, credits, department_id) VALUES
  ('Data Structures & Algorithms', 'CS101', 4, 1),
  ('Database Management Systems',  'CS102', 3, 1),
  ('Object Oriented Programming',  'CS103', 4, 1),
  ('Circuit Theory',               'EC101', 3, 2),
  ('Thermodynamics',               'ME101', 3, 3);
  
-- enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade) VALUES
  (1, 1, '2022-07-01', 'A'), (1, 2, '2022-07-01', 'B'),
  (2, 1, '2022-07-01', 'B'), (2, 3, '2022-07-01', 'A'),
  (3, 4, '2021-07-01', 'A'), (4, 5, '2023-07-01', NULL),
  (5, 1, '2022-07-01', 'C'), (5, 2, '2022-07-01', 'A'),
  (6, 4, '2021-07-01', 'B'), (7, 5, '2023-07-01', NULL),
  (8, 1, '2022-07-01', 'A'), (8, 3, '2022-07-01', 'B');
  
-- professors
INSERT INTO professors (prof_name, email, department_id, salary) VALUES
  ('Dr. Anand Krishnan',  'anand.k@college.edu',   1, 95000.00),
  ('Dr. Meena Pillai',    'meena.p@college.edu',   1, 88000.00),
  ('Dr. Sunil Rajan',     'sunil.r@college.edu',   2, 82000.00),
  ('Dr. Latha Gopal',     'latha.g@college.edu',   3, 79000.00),
  ('Dr. Kartik Bose',     'kartik.b@college.edu',  4, 76000.00);
  
-- my student values
INSERT INTO students (first_name, last_name, email, date_of_birth, department_id, 
enrollment_year) VALUES
	('Ashika',  'Lawrence',    'ashika.lawrence@college.edu',    '2004-04-18', 2, 2023),
	('Dhanu',  'Shaji',   'dhanu.shaji@college.edu',   '2003-11-11', 4, 2022);

-- enrollments update    
UPDATE enrollments SET grade = 'B' WHERE student_id = 5 AND course_id = 1;

-- delete enrollments
DELETE FROM enrollments WHERE grade IS NULL;

SET SQL_SAFE_UPDATES = 0;

SELECT *
FROM enrollments
WHERE grade IS NULL;

SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_enrollments FROM enrollments;

-- HANDS-ON 2 Task 2: Single-Table Queries and Filtering

SELECT * FROM students 
WHERE enrollment_year = 2022 
ORDER BY last_name ASC;

SELECT * FROM courses
WHERE credits > 3 
ORDER BY credits DESC;

SELECT * FROM professors
WHERE salary BETWEEN 80000 AND 95000;

SELECT * FROM students
WHERE email LIKE '%@college.edu';

SELECT COUNT(*) AS total_no_of_students, enrollment_year
FROM students GROUP BY enrollment_year;

-- HANDS-ON 2 Task 3: Multi-Table Joins

SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name, d.dept_name
FROM students s
JOIN departments d ON s.department_id = d.department_id;

SELECT e.enrollment_id, s.first_name, s.last_name, c.course_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) AS student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

SELECT c.course_name, COUNT(e.student_id) AS no_of_students_enrolled
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

SELECT d.dept_name, p.prof_name, p.salary
FROM departments d
LEFT JOIN professors p ON d.department_id=p.department_id;

-- HANDS-ON 2 Task 4: Aggregations and Grouping

SELECT c.course_name, COUNT(e.course_id) AS enrollment_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT d.dept_name, ROUND(AVG(p.salary),2) AS avg_salary
FROM professors p
JOIN departments d ON p.department_id = d.department_id
GROUP BY p.department_id;

SELECT * FROM departments WHERE budget > 600000;

SELECT e.grade, COUNT(e.grade) AS grade_count
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_code = 'CS101'
GROUP BY e.grade;

SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM departments d
JOIN students s ON d.department_id=s.department_id
GROUP BY d.dept_name
HAVING COUNT(s.student_id) > 2;

-- HANDS-ON 3 Task 1: Subqueries

SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS total_courses FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) >
(
    SELECT AVG(course_count)
    FROM
    (
        SELECT COUNT(*) AS course_count
        FROM enrollments
        GROUP BY student_id
    ) AS avg_table
);

SELECT c.course_id, c.course_name FROM courses c
WHERE NOT EXISTS (
    SELECT * FROM enrollments e
    WHERE e.course_id = c.course_id AND e.grade <> 'A'
);

SELECT p.* FROM professors p
WHERE salary =
(
    SELECT MAX(p2.salary) FROM professors p2
    WHERE p2.department_id = p.department_id
);

SELECT dept_name, avg_salary
FROM
(
    SELECT d.department_id, d.dept_name, AVG(p.salary) AS avg_salary
    FROM departments d
    JOIN professors p ON d.department_id = p.department_id
    GROUP BY d.department_id, d.dept_name
) AS dept_avg
WHERE avg_salary > 85000;

-- HANDS-ON 3 Task 2: Creating and Using Views

CREATE VIEW vw_student_enrollment_summary AS
SELECT s.student_id, CONCAT(s.first_name,' ',s.last_name) AS student_name, d.dept_name, COUNT(e.course_id) AS total_courses,
    ROUND(
    AVG(
        CASE
            WHEN grade='A' THEN 4
            WHEN grade='B' THEN 3
            WHEN grade='C' THEN 2
            WHEN grade='D' THEN 1
            WHEN grade='F' THEN 0
        END
    ),2) AS GPA
FROM students s
LEFT JOIN departments d ON s.department_id=d.department_id
LEFT JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id, student_name, d.dept_name;

SELECT * FROM vw_student_enrollment_summary;

CREATE VIEW vw_course_stats AS
SELECT c.course_name, c.course_code, COUNT(e.student_id) AS total_enrollments,
ROUND(
	AVG(
		CASE
			WHEN grade='A' THEN 4
			WHEN grade='B' THEN 3
			WHEN grade='C' THEN 2
			WHEN grade='D' THEN 1
			WHEN grade='F' THEN 0
		END
),2) AS avg_gpa
FROM courses c
LEFT JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name,c.course_code;

SELECT * FROM vw_student_enrollment_summary
WHERE GPA > 3;

UPDATE vw_student_enrollment_summary
SET student_name='ABC'
WHERE student_id=1;

-- ERROR: Error Code: 1288. The target table vw_student_enrollment_summary of the UPDATE is not updatable

DROP VIEW vw_course_stats;
DROP VIEW vw_student_enrollment_summary;

CREATE VIEW vw_student_enrollment_summary AS
SELECT student_id, first_name, last_name, department_id FROM students
WHERE department_id=1
WITH CHECK OPTION;

-- HANDS-ON 3 Task 3: Stored Procedures & Transactions

DELIMITER $$

CREATE PROCEDURE sp_enroll_student
	(
	IN p_student_id INT,
	IN p_course_id INT,
	IN p_date DATE
	)

BEGIN
IF EXISTS
(
	SELECT *
	FROM enrollments
	WHERE student_id=p_student_id
	AND course_id=p_course_id
)

THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Duplicate enrollment not allowed';
ELSE
INSERT INTO enrollments
(student_id,course_id,enrollment_date)
VALUES
(p_student_id,p_course_id,p_date);
END IF;
END $$
DELIMITER ;

CALL sp_enroll_student(2,2,'2026-06-01');


CREATE TABLE department_transfer_log
(
log_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
old_department INT,
new_department INT,
transfer_date DATETIME
);

START TRANSACTION;
UPDATE students
SET department_id=99
WHERE student_id=1;
INSERT INTO department_transfer_log
(student_id,old_department,new_department,transfer_date)
VALUES
(1,1,99,NOW());
ROLLBACK;

START TRANSACTION;
INSERT INTO enrollments
(student_id,course_id,enrollment_date)
VALUES
(3,2,CURDATE());
SAVEPOINT first_insert;
INSERT INTO enrollments
(student_id,course_id,enrollment_date)
VALUES
(3,4,CURDATE());

ROLLBACK TO first_insert;
COMMIT;
