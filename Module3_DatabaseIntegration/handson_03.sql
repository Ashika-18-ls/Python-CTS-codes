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
