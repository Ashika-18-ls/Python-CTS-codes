CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    hod_name VARCHAR(100),
    budget DECIMAL(12,2)
);

CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    department_id INT REFERENCES departments(department_id),
    enrollment_year INT
);

CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    course_code VARCHAR(20) UNIQUE,
    credits INT,
    department_id INT REFERENCES departments(department_id)
);

CREATE TABLE enrollments(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date DATE,
    grade CHAR(2)
);

CREATE TABLE professors(
    professor_id SERIAL PRIMARY KEY,
    prof_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT REFERENCES departments(department_id),
    salary DECIMAL(10,2)
);

SELECT * FROM departments;

ALTER TABLE departments
RENAME COLUMN hod_name TO head_of_dept;

ALTER TABLE courses
ADD COLUMN max_seats INT DEFAULT 60;

ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (grade IN ('A','B','C','D','F') OR grade IS NULL);

EXPLAIN
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM enrollments e
JOIN students s
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;

-- The execution plan shows whether PostgreSQL performs
-- a Sequential Scan (Seq Scan) or an Index Scan.
-- Before indexes are created, PostgreSQL generally performs
-- Seq Scan on the tables because no suitable indexes exist.

EXPLAIN ANALYZE
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM enrollments e
JOIN students s
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;

-- Estimated Cost : 12.16..42.13
-- Actual Time : 0.023..0.024 ms
-- Rows Returned : 9
-- Scan Type : Seq Scan

CREATE INDEX idx_students_enrollment_year
ON students(enrollment_year);

CREATE UNIQUE INDEX idx_enrollment_student_course
ON enrollments(student_id, course_id);

CREATE INDEX idx_course_code
ON courses(course_code);

EXPLAIN ANALYZE
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM enrollments e
JOIN students s
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;

-- After creating indexes,
-- PostgreSQL now uses Index Scan instead of Seq Scan
-- on students.enrollment_year.

-- Query execution cost is reduced.

CREATE INDEX idx_null_grade
ON enrollments(student_id)
WHERE grade IS NULL;

SELECT *
FROM pg_indexes
WHERE tablename='enrollments';

