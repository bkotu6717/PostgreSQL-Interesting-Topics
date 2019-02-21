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

