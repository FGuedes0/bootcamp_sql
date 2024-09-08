
SELECT * FROM customers;

SELECT CONTACT_NAME, CITY FROM customers;

SELECT COUNTRY FROM customers;

SELECT DISTINCT COUNTRY FROM customers;

SELECT COUNT (COUNTRY) FROM customers;

SELECT COUNT(DISTINCT COUNTRY) FROM CUSTOMERS;

------------------------------------------------------------------

SELECT * FROM customers WHERE country = 'Mexico';

SELECT * FROM customers WHERE customer_id = 'ANATR';

SELECT * FROM customers WHERE country = 'Germany' AND CITY = 'Berlin';

SELECT * FROM customers WHERE city = 'Berlin' OR city = 'Aachen';

SELECT * FROM customers WHERE country <> 'Germany';

SELECT * FROM customers WHERE country = 'Germany' AND (city = 'Berlin' OR city = 'Aachen');

SELECT * FROM customers WHERE country <> 'Germany' AND country <> 'USA';

------------------------------------------------------------------

SELECT * FROM customers ORDER BY country;

SELECT * FROM customers ORDER BY country DESC;

SELECT * FROM customers ORDER BY country, contact_name;

SELECT * FROM customers ORDER BY country ASC, contact_name DESC;


------------------------------------------------------------------

SELECT * FROM customers WHERE contact_name LIKE 'A%' ORDER BY contact_name ASC;

SELECT * FROM customers WHERE contact_name NOT LIKE 'A%' ORDER BY contact_name ASC;

SELECT * FROM customers WHERE country IN ('Germany', 'France', 'UK');

SELECT * FROM customers WHERE country NOT IN ('Germany', 'France', 'UK');
