CREATE TABLE basket(
    id SERIAL PRIMARY KEY,
    fruit VARCHAR(50) NOT NULL
);

INSERT INTO basket(fruit) values('apple');
INSERT INTO basket(fruit) values('apple');
 
INSERT INTO basket(fruit) values('orange');
INSERT INTO basket(fruit) values('orange');
INSERT INTO basket(fruit) values('orange');
 
INSERT INTO basket(fruit) values('banana');

SELECT * FROM basket;
SELECT COUNT(*) FROM basket;

SELECT fruit, COUNT(fruit) FROM basket
GROUP BY fruit
HAVING COUNT(fruit) > 1;


-- Using Self Join with Sub Query
DELETE FROM basket WHERE id IN (SELECT a.id FROM basket a 
INNER JOIN basket b on a.fruit = b.fruit AND a.id < b.id);

-- Using Syntax DELETE USING
DELETE FROM basket a
USING basket b
WHERE a.id < b.id AND a.fruit = b.fruit;

-- LEVEL 2
CREATE TABLE employee(
 id SERIAL PRIMARY KEY,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 designation VARCHAR(50) NOT NULL,
 department VARCHAR(50) NOT NULL
);

INSERT INTO employee(first_name, last_name, designation, department) VALUES('Maria', 'Green', 'Intern', 'STP/RMP');
INSERT INTO employee(first_name, last_name, designation, department) VALUES('Maria', 'Green', 'RH', 'STP/RMP');
INSERT INTO employee(first_name, last_name, designation, department) VALUES('Maria', 'Green', 'DRH', 'STP/RMP');

INSERT INTO employee(first_name, last_name, designation, department) VALUES('Olivier', 'Le Blanc', 'PDG', 'RTM');

INSERT INTO employee(first_name, last_name, designation, department) VALUES('Paul', 'Jones', 'Developer', 'RTM/FMP');
INSERT INTO employee(first_name, last_name, designation, department) VALUES('Paul', 'Jones', 'Project Chief', 'RTM/BSO');

SELECT first_name, last_name, COUNT(*) FROM employee group by first_name, last_name 
HAVING COUNT(*) > 1;

SELECT * FROM employee;

-- DISTINCT ROWS ALONG WITH ID 
SELECT DISTINCT ON(first_name, last_name) * FROM employee;

-- DELETES ROWS WHICH ARE DUPLICATES
DELETE FROM employee WHERE id NOT IN (
SELECT id FROM(
	SELECT DISTINCT ON (f.first_name, f.last_name) * FROM employee f
) e);

-- COMBINE AND SLECT DUPLICATE ROWS INTO SINGLE ROW
SELECT
  first_name,
  last_name,
  string_agg(designation, ' / ') AS designations,
  string_agg(department, ' / ') AS departments
FROM employee
GROUP BY
  first_name,
  last_name;
  
 
 first_name | last_name |             designations              |              departments              
------------+-----------+---------------------------------------+---------------------------------------
 Olivier    | Le Blanc  | PDG / PDG                             | RTM / RTM
 Paul       | Jones     | Developer / Developer / Project Chief | RTM/FMP / RTM/FMP / RTM/BSO
 Maria      | Green     | Intern / Intern / RH / DRH            | STP/RMP / STP/RMP / STP/RMP / STP/RMP
(3 rows)

