-- tao database
CREATE DATABASE companydb;
USE companydb;

-- bang department
CREATE TABLE department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- bang employee
CREATE TABLE employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    gender INT DEFAULT 1,
    birth_date DATE,
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    ON UPDATE CASCADE
);

-- bang project
CREATE TABLE project (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(150) NOT NULL,
    emp_id INT,
    start_date DATE DEFAULT (CURRENT_DATE),
    end_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

ALTER TABLE employee
ADD COLUMN email VARCHAR(100) UNIQUE;

ALTER TABLE project
MODIFY COLUMN project_name VARCHAR(200);

ALTER TABLE project
ADD CONSTRAINT chk_date
CHECK (end_date >= start_date);


INSERT INTO department (dept_id, dept_name, location) 
VALUES
(1, 'IT', 'Ha Noi'),
(2, 'HR', 'HCM'),
(3, 'Marketing', 'Da Nang');

INSERT INTO employee (emp_id, emp_name, gender, birth_date, salary, dept_id, email) 
VALUES
(1, 'Nguyen Van A', 1, '1990-01-15', 1500, 1, 'a@gmail.com'),
(2, 'Tran Thi B', 0, '1995-05-20', 1200, 1, 'b@gmail.com'),
(3, 'Le Minh C', 1, '1988-10-10', 2000, 2, 'c@gmail.com'),
(4, 'Pham Thi D', 0, '1992-12-05', 1800, 3, 'd@gmail.com');


INSERT INTO project (project_id, project_name, emp_id, start_date, end_date) 
VALUES
(101, 'Website Redesign', 1, '2024-01-01', '2024-06-01'),
(102, 'Recruitment System', 3, '2024-02-01', '2024-08-01'),
(103, 'Marketing Campaign', 4, '2024-03-01', NULL);

UPDATE employee
SET salary = salary + 200
WHERE dept_id = 1;

UPDATE project
SET end_date = '2024-12-31'
WHERE end_date IS NULL;

DELETE FROM projet 
WHERE start_date < '2024-02-01';
-- 1
SELECT emp_name, email,
CASE
    WHEN gender = 1 THEN 'Nam'
    ELSE 'Nu'
END AS gender_name
FROM employee;

-- 3
SELECT e.emp_name, e.salary, d.dept_name
FROM employee e
INNER JOIN department d
ON e.dept_id = d.dept_id;

-- 5
SELECT dept_id, COUNT(*) AS total_emp
FROM employee
GROUP BY dept_id
HAVING COUNT(*) >= 2;
-- 6
SELECT *
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

-- 7
SELECT *
FROM employee
WHERE emp_id IN (
    SELECT emp_id FROM project
);
-- 8
SELECT *
FROM employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE dept_id = e.dept_id
);




 SET SQL_SAFE_UPDATES = 0;



