

-- Self Join is used to Join the table with itlsef

CREATE TABLE employee (
 employee_id INT PRIMARY KEY,
 first_name VARCHAR (255) NOT NULL,
 last_name VARCHAR (255) NOT NULL,
 manager_id INT,
 FOREIGN KEY (manager_id) 
 REFERENCES employee (employee_id) 
 ON DELETE CASCADE
);
INSERT INTO employee (
 employee_id,
 first_name,
 last_name,
 manager_id
)
VALUES
 (1, 'Windy', 'Hays', NULL),
 (2, 'Ava', 'Christensen', 1),
 (3, 'Hassan', 'Conner', 1),
 (4, 'Anna', 'Reeves', 2),
 (5, 'Sau', 'Norman', 2),
 (6, 'Kelsie', 'Hays', 3),
 (7, 'Tory', 'Goff', 3),
 (8, 'Salley', 'Lester', 3);




 -- To find who reports to whom, you use the following query:

SELECT e.first_name || ' ' || e.last_name employee_name, m.first_name|| ' ' || m.last_name  manager FROM employee e INNER JOIN employee m ON e.manager_id = m.employee_id;

  employee_name  |     manager     
-----------------+-----------------
 Ava Christensen | Windy Hays
 Hassan Conner   | Windy Hays
 Anna Reeves     | Ava Christensen
 Sau Norman      | Ava Christensen
 Kelsie Hays     | Hassan Conner
 Tory Goff       | Hassan Conner
 Salley Lester   | Hassan Conner


 -- To find who reports to whom along with top manager, you use the following query:

SELECT e.first_name || ' ' || e.last_name employee_name, m.first_name|| ' ' || m.last_name  manager FROM employee e LEFT JOIN employee m ON e.manager_id = m.employee_id;

 employee_name  |     manager     
-----------------+-----------------
 Windy Hays      | 
 Ava Christensen | Windy Hays
 Hassan Conner   | Windy Hays
 Anna Reeves     | Ava Christensen
 Sau Norman      | Ava Christensen
 Kelsie Hays     | Hassan Conner
 Tory Goff       | Hassan Conner
 Salley Lester   | Hassan Conner


-- Find the number of employees each manager is managing
select m.manager_id,m.first_name, m.last_name, count(e.employee_id) from employee e inner join employee m on e.manager_id = m.employee_id group by m.manager_id, m.first_name, m.last_name;

manager_id | first_name |  last_name  | count 
------------+------------+-------------+-------
            | Windy      | Hays        |     2
          1 | Ava        | Christensen |     2
          1 | Hassan     | Conner      |     3


-- Find the number of managers each employee is reporting

 select e.employee_id, e.first_name, e.last_name, count(m.manager_id) from employee e inner join employee m on e.manager_id = m.employee_id and group by e.employee_id, e.first_name, e.last_name;
 
 employee_id | first_name |  last_name  | count 
-------------+------------+-------------+-------
           8 | Salley     | Lester      |     1
           3 | Hassan     | Conner      |     0
           4 | Anna       | Reeves      |     1
           6 | Kelsie     | Hays        |     1
           2 | Ava        | Christensen |     0
           5 | Sau        | Norman      |     1
           7 | Tory       | Goff        |     1



-- Select employees who are only employees but not managers

SELECT * FROM employee WHERE employee_id NOT IN (SELECT manager_id FROM employee WHERE manager_id IS NOT NULL);
 
 employee_id | first_name | last_name | manager_id 
-------------+------------+-----------+------------
           4 | Anna       | Reeves    |          2
           5 | Sau        | Norman    |          2
           6 | Kelsie     | Hays      |          3
           7 | Tory       | Goff      |          3
           8 | Salley     | Lester    |          3

-- Select employees who are managers and not employees

SELECT * FROM employee WHERE manager_id IS NULL;

 employee_id | first_name | last_name | manager_id 
-------------+------------+-----------+------------
           1 | Windy      | Hays      |           


-- Select all managers

select * from employee where employee_id in (select manager_id from employee where manager_id is not null);
 
 employee_id | first_name |  last_name  | manager_id 
-------------+------------+-------------+------------
           1 | Windy      | Hays        |           
           2 | Ava        | Christensen |          1
           3 | Hassan     | Conner      |          1
