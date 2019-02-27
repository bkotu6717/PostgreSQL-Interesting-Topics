-- 1. SELECT CATEGORYID, CATEGORYNAME AND RESPSECTIVE PRODUCTS COUNT
SELECT c.categoryid, c.categoryname, COUNT(*) FROM products p
INNER JOIN categories c ON p.categoryid = c.categoryid
GROUP BY c.categoryid, c.categoryname
ORDER BY c.categoryid;

 categoryid |  categoryname  | count 
------------+----------------+-------
          1 | Beverages      |    12
          2 | Condiments     |    12
          3 | Confections    |    13
          4 | Dairy Products |    10
          5 | Grains/Cereals |     7
          6 | Meat/Poultry   |     6
          7 | Produce        |     5
          8 | Seafood        |    12
(8 rows)

-- 2. SELECT CATEGORYID, CATEGORYNAME AND CATEGORY WITH MAX PRODUCTS COUNT
SELECT c.categoryid, c.categoryname, COUNT(*) FROM products p
INNER JOIN categories c ON p.categoryid = c.categoryid
GROUP BY c.categoryid, c.categoryname
ORDER BY COUNT(*) DESC LIMIT 1;

 categoryid | categoryname | count 
------------+--------------+-------
          3 | Confections  |    13
(1 row)

-- 3. SELECT CATEGORYID, CATEGORYNAME AND CATEGORY WITH MIN PRODUCTS COUNT
SELECT c.categoryid, c.categoryname, COUNT(*) FROM products p
INNER JOIN categories c ON p.categoryid = c.categoryid
GROUP BY c.categoryid, c.categoryname
ORDER BY COUNT(*) ASC LIMIT 1;

 categoryid | categoryname | count 
------------+--------------+-------
          7 | Produce      |     5
(1 row)

-- 4. SELECT CATEGORY, PRODUCT, SUPPLIER ORDER BY CATEGORYNAME
SELECT c.categoryname, p.productname, s.suppliername FROM products p
INNER JOIN categories c ON c.categoryid = p.categoryid
INNER JOIN suppliers s ON s.supplierid = p.supplierid
ORDER BY c.categoryname;

 categoryname |        productname        |        suppliername        
--------------+---------------------------+----------------------------
 Beverages    | Côte de Blaye             | Aux joyeux ecclésiastiques
 Beverages    | Ipoh Coffee               | Leka Trading
 Beverages    | Sasquatch Ale             | Bigfoot Breweries
 Beverages    | Steeleye Stout            | Bigfoot Breweries
 Beverages    | Chais                     | Exotic Liquid
 Beverages    | Chartreuse verte          | Aux joyeux ecclésiastiques
 Beverages    | Chang                     | Exotic Liquid
 Beverages    | Guaraná Fantástica        | Refrescos Americanas LTDA
 Beverages    | Outback Lager             | Pavlova, Ltd.
 Beverages    | Laughing Lumberjack Lager | Bigfoot Breweries
(10 rows)

-- 5.SELECT SUPPLIERS WITH THEIR COUNT OF PRODUCTS
-- OR
-- HOW MANY PRODUCTS ARE SUPPLIED BY EACH SUPPLIER
SELECT s.suppliername, COUNT(*) FROM products p
INNER JOIN suppliers s ON p.supplierid = s.supplierid
GROUP BY s.suppliername
ORDER BY COUNT(*);

              suppliername              | count 
----------------------------------------+-------
 Refrescos Americanas LTDA              |     1
 Escargots Nouveaux                     |     1
 Nord-Ost-Fisch Handelsgesellschaft mbH |     1
 Zaanse Snoepfabriek                    |     2
 Ma Maison                              |     2
 Aux joyeux ecclésiastiques             |     2
 New England Seafood Cannery            |     2
 Forêts d'érables                       |     2
 Gai pâturage                           |     2
 Lyngbysild                             |     2
 PB Knäckebröd AB                       |     2
 Cooperativa de Quesos 'Las Cabras'     |     2
 Pasta Buttini s.r.l.                   |     2
 Leka Trading                           |     3
 Norske Meierier                        |     3
 Grandma Kelly's Homestead              |     3
 Heli Süßwaren GmbH & Co. KG            |     3
 Karkki Oy                              |     3
 Formaggi Fortini s.r.l.                |     3
 Bigfoot Breweries                      |     3
 Exotic Liquid                          |     3
 Svensk Sjöföda AB                      |     3
 Tokyo Traders                          |     3
 Mayumi's                               |     3
 G'day, Mate                            |     3
 New Orleans Cajun Delights             |     4
 Specialty Biscuits, Ltd.               |     4
 Pavlova, Ltd.                          |     5
 Plutzer Lebensmittelgroßmärkte AG      |     5
(29 rows)

-- 6. FIND HOW MANY PRODUCTS ARE SUPPLIED BY EACH SUPPLIER IN EACH CATEGORY
SELECT s.suppliername, c.categoryname, COUNT(*) FROM products p
INNER JOIN suppliers s ON s.supplierid = p.supplierid
INNER JOIN categories c ON c.categoryid = p.categoryid
GROUP BY s.suppliername, c.categoryname
ORDER BY COUNT(*);

              suppliername              |  categoryname  | count 
----------------------------------------+----------------+-------
 Mayumi's                               | Produce        |     1
 Tokyo Traders                          | Produce        |     1
 G'day, Mate                            | Produce        |     1
 Plutzer Lebensmittelgroßmärkte AG      | Meat/Poultry   |     1
 Grandma Kelly's Homestead              | Produce        |     1
 Pavlova, Ltd.                          | Meat/Poultry   |     1
 Leka Trading                           | Condiments     |     1
 Refrescos Americanas LTDA              | Beverages      |     1
 G'day, Mate                            | Grains/Cereals |     1
 Plutzer Lebensmittelgroßmärkte AG      | Condiments     |     1
 Plutzer Lebensmittelgroßmärkte AG      | Grains/Cereals |     1
 Tokyo Traders                          | Seafood        |     1
 Mayumi's                               | Seafood        |     1
 Plutzer Lebensmittelgroßmärkte AG      | Beverages      |     1
 Nord-Ost-Fisch Handelsgesellschaft mbH | Seafood        |     1
 Leka Trading                           | Grains/Cereals |     1
 Mayumi's                               | Condiments     |     1
 Leka Trading                           | Beverages      |     1
 Forêts d'érables                       | Condiments     |     1
 G'day, Mate                            | Meat/Poultry   |     1
 Pavlova, Ltd.                          | Beverages      |     1
 Tokyo Traders                          | Meat/Poultry   |     1
 Karkki Oy                              | Beverages      |     1
 Forêts d'érables                       | Confections    |     1
 Escargots Nouveaux                     | Seafood        |     1
 Pavlova, Ltd.                          | Confections    |     1
 Plutzer Lebensmittelgroßmärkte AG      | Produce        |     1
 Exotic Liquid                          | Condiments     |     1
 Pavlova, Ltd.                          | Condiments     |     1
 Pavlova, Ltd.                          | Seafood        |     1
 Gai pâturage                           | Dairy Products |     2
 Ma Maison                              | Meat/Poultry   |     2
 Grandma Kelly's Homestead              | Condiments     |     2
 Karkki Oy                              | Confections    |     2
 PB Knäckebröd AB                       | Grains/Cereals |     2
 New England Seafood Cannery            | Seafood        |     2
 Pasta Buttini s.r.l.                   | Grains/Cereals |     2
 Cooperativa de Quesos 'Las Cabras'     | Dairy Products |     2
 Aux joyeux ecclésiastiques             | Beverages      |     2
 Lyngbysild                             | Seafood        |     2
 Exotic Liquid                          | Beverages      |     2
 Zaanse Snoepfabriek                    | Confections    |     2
 Formaggi Fortini s.r.l.                | Dairy Products |     3
 Svensk Sjöföda AB                      | Seafood        |     3
 Bigfoot Breweries                      | Beverages      |     3
 Heli Süßwaren GmbH & Co. KG            | Confections    |     3
 Norske Meierier                        | Dairy Products |     3
 Specialty Biscuits, Ltd.               | Confections    |     4
 New Orleans Cajun Delights             | Condiments     |     4
(49 rows)

-- 7. SELECT CUSTOMERS AND THEIR ORDERS COUNT ORDER BY DESC
SELECT c.customername, COUNT(*) FROM customers c
INNER JOIN orders o ON o.customerid = c.customerid
GROUP BY c.customername
ORDER BY COUNT(*) DESC;

            customername            | count 
------------------------------------+-------
 Ernst Handel                       |    10
 Rattlesnake Canyon Grocery         |     7
 Wartian Herkku                     |     7
 QUICK-Stop                         |     7
 Hungry Owl All-Night Grocers       |     6
 Split Rail Beer & Ale              |     6
 La maison d'Asie                   |     5
 Mère Paillarde                     |     5
 LILA-Supermercado                  |     5
 Tortuga Restaurante                |     4
 Bottom-Dollar Marketse             |     4
 Save-a-lot Markets                 |     4
 Folk och fä HB                     |     4
 Old World Delicatessen             |     4
 Die Wandernde Kuh                  |     4
 Blondel père et fils               |     4
 Que Delícia                        |     4
 Frankenversand                     |     4
 Berglunds snabbköp                 |     3
 Island Trading                     |     3
 Magazzini Alimentari Riuniti       |     3
 Piccolo und mehr                   |     3
 Lehmanns Marktstand                |     3
 Hungry Coyote Import Store         |     3
 Romero y tomillo                   |     3
 Bon app'                           |     3
 Familia Arquibaldo                 |     3
 Reggiani Caseifici                 |     3
 Seven Seas Imports                 |     3
 Princesa Isabel Vinhoss            |     3
 Pericles Comidas clásicas          |     2
 Drachenblut Delikatessend          |     2
 Richter Supermarkt                 |     2
 Eastern Connection                 |     2
 Around the Horn                    |     2
 Queen Cozinha                      |     2
 HILARIÓN-Abastos                   |     2
 Simons bistro                      |     2
 Tradição Hipermercados             |     2
 Furia Bacalhau e Frutos do Mar     |     2
 Galería del gastrónomo             |     2
 White Clover Markets               |     2
 Lonesome Pine Restaurant           |     2
 Königlich Essen                    |     2
 Chop-suey Chinese                  |     2
 Ricardo Adocicados                 |     2
 Wellington Importadora             |     2
 Vaffeljernet                       |     2
 Vins et alcools Chevalier          |     2
 Suprêmes délices                   |     2
 Victuailles en stock               |     2
 Hanari Carnes                      |     2
 Consolidated Holdings              |     1
 Ana Trujillo Emparedados y helados |     1
 Santé Gourmet                      |     1
 Bólido Comidas preparadas          |     1
 The Big Cheese                     |     1
 LINO-Delicateses                   |     1
 Ottilies Käseladen                 |     1
 Toms Spezialitäten                 |     1
 Antonio Moreno Taquería            |     1
 Wilman Kala                        |     1
 Godos Cocina Típica                |     1
 Centro comercial Moctezuma         |     1
 Franchi S.p.A.                     |     1
 Comércio Mineiro                   |     1
 Océano Atlántico Ltda.             |     1
 Du monde entier                    |     1
 Wolski                             |     1
 Morgenstern Gesundkost             |     1
 B's Beverages                      |     1
 Gourmet Lanchonetes                |     1
 GROSELLA-Restaurante               |     1
 Folies gourmandes                  |     1
(74 rows)


-- 8. SELECT EMPLOYEE AND THEIR ORDERS COUNT ORDER BY DESC
SELECT e.employeeid, e.firstname, e.lastname, COUNT(*) FROM employees e
INNER JOIN orders o ON o.employeeid = e.employeeid
GROUP BY e.employeeid, e.firstname, e.lastname
ORDER BY COUNT(*) DESC;

 employeeid | firstname | lastname  | count 
------------+-----------+-----------+-------
          4 | Margaret  | Peacock   |    40
          3 | Janet     | Leverling |    31
          1 | Nancy     | Davolio   |    29
          8 | Laura     | Callahan  |    27
          2 | Andrew    | Fuller    |    20
          6 | Michael   | Suyama    |    18
          7 | Robert    | King      |    14
          5 | Steven    | Buchanan  |    11
          9 | Anne      | Dodsworth |     6
(9 rows)


-- 9. SELECT WHICH ORDER IS 
-- ORDERED BY WHICH CUSTOMER
-- SERVED BY WHICH EMPLOYEE
-- SHIPPED BY WHICH SHIPPER
-- OREDR ID FOR FIRST 10 ORDERS

 SELECT c.customername, e.firstname||' '||e.lastname as employeename, s.shippername, o.orderid FROM orders o
 INNER JOIN customers c ON c.customerid = o.customerid
 INNER JOIN employees e ON o.employeeid = e.employeeid
 INNER JOIN shippers s ON s.shipperid = o.shipperid
 LIMIT 10;


      customername      |   employeename   |   shippername    | orderid 
------------------------+------------------+------------------+---------
 Wilman Kala            | Steven Buchanan  | Federal Shipping |   10248
 Tradição Hipermercados | Michael Suyama   | Speedy Express   |   10249
 Hanari Carnes          | Margaret Peacock | United Package   |   10250
 Victuailles en stock   | Janet Leverling  | Speedy Express   |   10251
 Suprêmes délices       | Margaret Peacock | United Package   |   10252
 Hanari Carnes          | Janet Leverling  | United Package   |   10253
 Chop-suey Chinese      | Steven Buchanan  | United Package   |   10254
 Richter Supermarkt     | Anne Dodsworth   | Federal Shipping |   10255
 Wellington Importadora | Janet Leverling  | United Package   |   10256
 HILARIÓN-Abastos       | Margaret Peacock | Federal Shipping |   10257
(10 rows)

