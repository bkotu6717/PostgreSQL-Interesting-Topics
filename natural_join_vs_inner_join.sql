
CREATE TABLE categories (
 category_id serial PRIMARY KEY,
 category_name VARCHAR (255) NOT NULL
);
 
CREATE TABLE products (
 product_id serial PRIMARY KEY,
 product_name VARCHAR (255) NOT NULL,
 category_id INT NOT NULL,
 FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

INSERT INTO categories (category_name)
VALUES
 ('Smart Phone'),
 ('Laptop'),
 ('Tablet');
 
INSERT INTO products (product_name, category_id)
VALUES
 ('iPhone', 1),
 ('Samsung Galaxy', 1),
 ('HP Elite', 2),
 ('Lenovo Thinkpad', 2),
 ('iPad', 3),
 ('Kindle Fire', 3);
 
 SELECT * FROM categories;
 SELECT * FROM products;
 
 -- Make sure that there is only one common column between both the tables
 -- Natural Join knows does't need to have matching column specified with ON clause
 -- Natural Join displays all columns from both tables without duplication
 -- Make sure that both tables don't have more than one common column, because
 -- Natural join may not use proper column for joining
 SELECT * FROM categories NATURAL JOIN products;

--  category_id | category_name | product_id |  product_name   
-- -------------+---------------+------------+-----------------
--            1 | Smart Phone   |          2 | Samsung Galaxy
--            1 | Smart Phone   |          1 | iPhone
--            2 | Laptop        |          4 | Lenovo Thinkpad
--            2 | Laptop        |          3 | HP Elite
--            3 | Tablet        |          6 | Kindle Fire
--            3 | Tablet        |          5 | iPad
-- (6 rows)


 -- Inner Join requires join condition to be specified in condition
 -- Natural join displays all the columns from both the tables
 SELECT * FROM categories c inner join products p on c.category_id = p.category_id; 
 
--  category_id | category_name | product_id |  product_name   | category_id 
-- -------------+---------------+------------+-----------------+-------------
--            1 | Smart Phone   |          2 | Samsung Galaxy  |           1
--            1 | Smart Phone   |          1 | iPhone          |           1
--            2 | Laptop        |          4 | Lenovo Thinkpad |           2
--            2 | Laptop        |          3 | HP Elite        |           2
--            3 | Tablet        |          6 | Kindle Fire     |           3
--            3 | Tablet        |          5 | iPad            |           3
-- (6 rows)
