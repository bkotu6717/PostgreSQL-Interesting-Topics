--  Sample employee database for PostgreSQL
--  See changelog table for details
--  Created from MySQL Employee Sample Database (http://dev.mysql.com/doc/employee/en/index.html)
--  Created by Bhaskar K
--  DISCLAIMER
--  To the best of our knowledge, this data is fabricated, and
--  it does not correspond to real people. 
--  Any similarity to existing people is purely coincidental.
-- 
DROP DATABASE IF EXISTS employee_test_db;
CREATE DATABASE employee_test_db;
\c employee_test_db;

CREATE TYPE gender AS ENUM('M', 'F');
CREATE TABLE employees (
  emp_id      INT             NOT NULL,
  birth_date  DATE            NOT NULL,
  first_name  VARCHAR(14)     NOT NULL,
  last_name   VARCHAR(16)     NOT NULL,
  gender      gender    NULL,    
  hire_date   DATE            NOT NULL,
  PRIMARY KEY (emp_id)
);

-- Sample employee data
INSERT INTO employees (emp_id,birth_date,first_name,last_name,gender,hire_date)
VALUES('10001','1953-09-02', 'Georgi','Facello','M','1986-06-26'),
('10002', '1964-06-02','Bezalel','Simmel','F','1985-11-21'),
('10003','1959-12-03', 'Parto',     'Bamford' ,'M'     ,'1986-08-28'),
('10004','1954-05-01', 'Chirstian', 'Koblick' ,'M'     ,'1986-12-01'),
('10005','1955-01-21','Kyoichi'   ,'Maliniak' ,'M'     ,'1989-09-12'),
('10006','1953-04-20','Anneke'    ,'Preusig'  ,'F'     ,'1989-06-02'),
('10007','1957-05-23','Tzvetan'   ,'Zielinski','F'     ,'1989-02-10'),
('10008','1958-02-19','Saniya'   ,'Kalloufi' ,'M'     ,'1994-09-15'),
('10009','1952-04-19','Sumant'    ,'Peac'     ,'F'     ,'1985-02-18'),
('10010','1963-06-01','Duangkaew' ,'Piveteau' ,'F'     ,'1989-08-24');
-- Sample manager data
INSERT INTO employees (emp_id,birth_date,first_name,last_name,gender,hire_date)
VALUES('110303','1956-06-08','Krassimir ','Wegerle','F','1985-01-01'),
('110344','1961-09-07','Rosine','Cools','F','1985-11-22'),
('110085','1959-10-28','Ebru','Alpin','M','1985-01-01'),
('110228','1958-12-02','Karsten','Sigstam','F','1985-08-04'),
('110022','1956-09-12','Margareta','Markovitch','M','1985-01-01'),
('110386','1953-10-04','Shem','Kieras','M','1988-10-14'),
('110183','1953-06-24','Shirish','Ossenbruggen','F','1985-01-01'),
('110420','1963-07-27','Oscar','Ghazalie','M','1992-02-05'),
('110114','1957-03-28','Isamu','Legleitner','F','1985-01-14'),
('110039','1963-06-21','Vishwani','Minakawa','M','1986-04-12');


CREATE TABLE departments (
  dept_id    CHAR(4)         NOT NULL,
  dept_name   VARCHAR(40)     NOT NULL,
  PRIMARY KEY (dept_id),
  UNIQUE     (dept_name)
);
INSERT INTO departments(dept_id, dept_name)
VALUES('d001','Marketing'),
 ('d002','Finance'),
 ('d003','Human Resources'),
 ('d004','Production'),
 ('d005','Development'),
 ('d006','Quality Management'),
 ('d007','Sales'),
 ('d008','Research'),
 ('d009','Customer Service');

CREATE TABLE dept_manager (
  dept_id      CHAR(4)         NOT NULL,
  emp_id       INT             NOT NULL,
  from_date    DATE            NOT NULL,
  to_date      DATE            NOT NULL,
  FOREIGN KEY (emp_id)  REFERENCES employees (emp_id)    ON DELETE CASCADE,
  FOREIGN KEY (dept_id) REFERENCES departments (dept_id) ON DELETE CASCADE,
  PRIMARY KEY (emp_id,dept_id)
); 
 INSERT INTO dept_manager(dept_id, emp_id, from_date, to_date)
 VALUES('d001','110022 ','1985-01-01 ','1991-10-01'),
 ('d001','110039 ','1991-10-01 ','9999-01-01'),
 ('d002','110085 ','1985-01-01 ','1989-12-17'),
 ('d002','110114 ','1989-12-17 ','9999-01-01'),
 ('d003','110183 ','1985-01-01 ','1992-03-21'),
 ('d003','110228 ','1992-03-21 ','9999-01-01'),
 ('d004','110303 ','1985-01-01 ','1988-09-09'),
 ('d004','110344 ','1988-09-09 ','1992-08-02'),
 ('d004','110386 ','1992-08-02 ','1996-08-30'),
 ('d004','110420 ','1996-08-30 ','9999-01-01');


CREATE INDEX dept_manager_dept_id_idx ON dept_manager(dept_id);

CREATE TABLE dept_emp (
  emp_id      INT             NOT NULL,
  dept_id     CHAR(4)         NOT NULL,
  from_date   DATE            NOT NULL,
  to_date     DATE            NOT NULL,
  FOREIGN KEY (emp_id)  REFERENCES employees   (emp_id)  ON DELETE CASCADE,
  FOREIGN KEY (dept_id) REFERENCES departments (dept_id) ON DELETE CASCADE,
  PRIMARY KEY (emp_id,dept_id)
);

INSERT INTO dept_emp (emp_id,dept_id,from_date, to_date)
VALUES('10004','d004','1986-12-01','9999-01-01'),
('10007','d008','1989-02-10','9999-01-01'),
('10010','d004','1996-11-24','2000-06-26'),
('10010','d006','2000-06-26','9999-01-01'),
('10001','d005','1986-06-26','9999-01-01'),
('10006','d005','1990-08-05','9999-01-01'),
('10003','d004','1995-12-03','9999-01-01'),
('10008','d005','1998-03-11','2000-07-31'),
('10009','d006','1985-02-18','9999-01-01'),
('10005','d003','1989-09-12','9999-01-01'),
('10002','d007','1996-08-03','9999-01-01');

CREATE INDEX dept_emp_dept_id_idx ON dept_emp(dept_id);

CREATE TABLE titles (
  emp_id      INT             NOT NULL,
  title       VARCHAR(50)     NOT NULL,
  from_date   DATE            NOT NULL,
  to_date     DATE,
  FOREIGN KEY (emp_id) REFERENCES employees (emp_id) ON DELETE CASCADE,
  PRIMARY KEY (emp_id,title, from_date)
);

-- Insert employees data
INSERT INTO titles(emp_id,title,from_date,to_date)
VALUES('10004','Engineer','1986-12-01','1995-12-01'),
('10004','Senior Engineer','1995-12-01','9999-01-01'),
('10007','Senior Staff','1996-02-11','9999-01-01'),
('10007','Staff','1989-02-10','1996-02-11'),
('10010','Engineer','1996-11-24','9999-01-01'),
('10001','Senior Engineer','1986-06-26','9999-01-01'),
('10006','Senior Engineer','1990-08-05','9999-01-01'),
('10003','Senior Engineer','1995-12-03','9999-01-01'),
('10008','Assistant Engineer','1998-03-11','2000-07-31'),
('10009','Assistant Engineer','1985-02-18','1990-02-18'),
('10009','Engineer','1990-02-18','1995-02-18'),
('10009','Senior Engineer','1995-02-18','9999-01-01'),
('10005','Senior Staff','1996-09-12','9999-01-01'),
('10005','Staff','1989-09-12','1996-09-12'),
('10002','Staff','1996-08-03','9999-01-01');

-- Insert managers data
INSERT INTO titles(emp_id,title,from_date,to_date)
VALUES('110303','Manager         ','1985-01-01','1988-09-09'),
('110303','Technique Leader','1988-09-09','9999-01-01'),
('110344','Manager         ','1988-09-09','1992-08-02'),
('110344','Senior Engineer ','1985-11-22','1988-09-09'),
('110344','Technique Leader','1992-08-02','9999-01-01'),
('110085','Manager         ','1985-01-01','1989-12-17'),
('110085','Senior Staff    ','1989-12-17','9999-01-01'),
('110228','Manager         ','1992-03-21','9999-01-01'),
('110228','Senior Staff    ','1985-08-04','1992-03-21'),
('110022','Manager         ','1985-01-01','1991-10-01'),
('110022','Senior Staff    ','1991-10-01','9999-01-01'),
('110386','Manager         ','1992-08-02','1996-08-30'),
('110386','Technique Leader','1988-10-14','1992-08-02'),
('110386','Technique Leader','1996-08-30','9999-01-01'),
('110183','Manager         ','1985-01-01','1992-03-21'),
('110183','Staff           ','1992-03-21','9999-01-01'),
('110420','Manager         ','1996-08-30','9999-01-01'),
('110420','Senior Engineer ','1992-02-05','1996-08-30'),
('110114','Manager         ','1989-12-17','9999-01-01'),
('110114','Senior Staff    ','1985-01-14','1989-12-17'),
('110039','Manager         ','1991-10-01','9999-01-01'),
('110039','Senior Staff    ','1986-04-12','1991-10-01');

CREATE TABLE salaries (
  emp_id      INT             NOT NULL,
  salary      INT             NOT NULL,
  from_date   DATE            NOT NULL,
  to_date     DATE            NOT NULL,
  FOREIGN KEY (emp_id) REFERENCES employees (emp_id) ON DELETE CASCADE,
  PRIMARY KEY (emp_id, from_date)
);

INSERT INTO salaries(emp_id, salary, from_date, to_date)
VALUES('10001','60117','986-06-26','987-06-26'),
('10002','65828','996-08-03','997-08-03'),
('10003','40006','995-12-03','996-12-02'),
('10004','40054','986-12-01','987-12-01'),
('10005','78228','989-09-12','990-09-12'),
('10006','40000','990-08-05','991-08-05'),
('10007','56724','989-02-10','990-02-10'),
('10008','46671','998-03-11','999-03-11'),
('10009','60929','985-02-18','986-02-18'),
('10010','72488','996-11-24','997-11-24'),
('110022','71166','985-01-01','986-01-01'),
('110039','69941','986-04-12','987-04-12'),
('110085','60026','985-01-01','986-01-01'),
('110114','52070','985-01-14','986-01-14'),
('110183','48291','985-01-01','986-01-01'),
('110228','40000','985-08-04','986-08-04'),
('110303','42093','985-01-01','986-01-01'),
('110344','50365','985-11-22','986-11-22'),
('110386','40000','988-10-14','989-10-14'),
('110420','40000','992-02-05','993-02-04');
