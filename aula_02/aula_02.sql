--Principais comandos de DQL

--SELECT: O comando mais fundamental em DQL, usado para selecionar dados de uma ou mais tabelas.

SELECT * FROM customers;

SELECT contact_name, city FROM customers;

--DISTINCT: Usado com SELECT para retornar apenas valores distintos.

SELECT country FROM customers;

SELECT DISTINCT country FROM customers;

SELECT COUNT(DISTINCT country) FROM customers;

--WHERE: Usado para filtrar.

-- Seleciona todos os clientes do México
SELECT * FROM customers WHERE country = 'Mexico';

-- Seleciona clientes com ID específico
SELECT * FROM customers WHERE customer_id = 'ANATR';

-- Utiliza AND para múltiplos critérios
SELECT * FROM customers WHERE country = 'Germany' AND city ='Berlin';

-- Utiliza OR para mais de uma cidade
SELECT * FROM customers WHERE city ='Berlin' OR city ='Aachen';

-- Utiliza NOT para excluir a Alemanha
SELECT * FROM customers WHERE country <>'Germany';

-- Combina AND, OR e NOT
SELECT * FROM customers WHERE country ='Germany' AND (city='Berlin' OR city='Aachen');

-- Exclui clientes da Alemanha e EUA
SELECT * FROM customers WHERE country NOT IN ('Germany', 'USA');--<> 'Germany' AND country <> 'USA';

-- Seleciona todos os produtos com preço menor que 20
SELECT * FROM products
WHERE unit_price <20;

-- Seleciona todos os produtos com preço maior que 100
SELECT * FROM products
WHERE unit_price > 100;

-- Seleciona todos os produtos com preço menor ou igual a 50
SELECT * FROM products
WHERE unit_price <=50;

-- Seleciona todos os produtos com quantidade em estoque maior ou igual a 10
SELECT * FROM products
WHERE units_in_stocke >=10;

-- Seleciona todos os produtos cujo preço não é 30
SELECT * FROM products
WHERE unit_price <> 30;

-- Seleciona todos os produtos com preço entre 50 e 100 (exclusive)
SELECT * FROM products
WHERE unit_price >= 50 AND unit_price < 100;

-- Seleciona todos os produtos com preço fora do intervalo 20 a 40
SELECT * FROM products
WHERE unit_price < 20 OR unit_price > 40;

--Is null and is not null: Usado em conjunto com o where para criar regras mais complexas de filtro nos registros.
SELECT * FROM customers
WHERE contact_name IS NULL;

SELECT * FROM customers
WHERE contact_name IS NOT NULL;

--LIKE
select * from customers
where contact_name LIKE 'A%';

SELECT * FROM customers
WHERE LOWER(contact_name) LIKE 'a%';

SELECT * FROM customers
WHERE UPPER(contact_name) LIKE 'A%';

-- Nome do cliente terminando com "a"
SELECT * FROM customers
WHERE contact_name LIKE '%a';

-- Nome do cliente que possui "or" em qualquer posição:
SELECT * FROM customers
WHERE contact_name LIKE '%or%';

-- Nome do cliente com "r" na segunda posição:
SELECT * FROM customers
WHERE contact_name LIKE '_r%';

-- Nome do cliente que começa com "A" e tem pelo menos 3 caracteres de comprimento:
SELECT * FROM customers
WHERE contact_name LIKE 'A_%_%';

-- Nome do cliente que começa com "A" e termina com "o":
SELECT * FROM customers
WHERE contact_name LIKE 'A%o';

-- Nome do cliente que NÃO começa com "A":
SELECT * FROM customers
WHERE contact_name NOT LIKE 'A%';

-- Usando o curinga [charlist] (SQL server):
SELECT * FROM customers
WHERE city LIKE '[BSP]%';

-- Usando o curinga similar To (Postgres)
SELECT * FROM customers
WHERE city similar TO '(B|S|P)%';

-- Usando  o MySQL (coitado, tem nada)
SELECT * FROM customers
WHERE (city LIKE 'B%' OR city LIKE 'S%' OR city LIKE 'P%');

-- Operador IN

-- Localizado na "Alemanha", "França", ou "Reino Unido":
SELECT * FROM customers
WHERE country IN ('Germany', 'France', 'UK');

-- NÃO localizado na "Alemanha", "França" ou "Reino Unido":
SELECT * FROM customers
WHERE country NOT IN ('Germany', 'France', 'UK');

-- Só para dar um gostinho de uma subqueyr... Seleciona todos os clientes que são dos mesmos países que os fornecedores:
SELECT * FROM customers
WHERE country IN (SELECT country FROM suppliers);

-- Exemplo com BETWEEN
SELECT * FROM products
WHERE unit_price BETWEEN 10 AND 20;

-- Exemplo com NOT BETWEEN
SELECT * FROM products
WHERE unit_price NOT BETWEEN 10 AND 20;

-- Seleciona todos os produtos com preço ENTRE 10 e 20. Adicionalmente, não mostra produtos com CategoryID de 1, 2 ou 3:
SELECT * FROM products
WHERE (unit_price BETWEEN 10 AND 20) AND category_id NOT IN (1,2.3);

--selects todos os produtos entre 'Carnarvon Tigers' e 'Mozzarella di Giovanni':
SELECT * FROM products
WHERE product_name BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY product_name;

--Selecione todas as ordens BETWEEN '04-July-1996' e '09-July-1996':
select * from orders
where order_date between '07/04/1996' and '07/09/1996';

-- selecionando datas - SQL SERVER

-- Usando CONVERT
SELECT CONVERT(VARCHAR, order_date, 120) FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- Usando FORMAT
SELECT FORMAT(order_date, 'yyyy-MM-dd') FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- selecionando datas - MySQL
SELECT DATE_FORMAT(order_date, '%Y-%m-%d') FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- selecionando datas - Oracle
SELECT TO_CHAR(order_date, 'YYYY-MM-DD') FROM orders
WHERE order_date BETWEEN TO_DATE('1996-04-07', 'YYYY-MM-DD') AND TO_DATE('1996-09-07', 'YYYY-MM-DD');

-- selecionando datas - SQLite
SELECT strftime('%Y-%m-%d', order_date) FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- Funções agregadoras:

-- Exemplo de MIN()
SELECT MIN(unit_price) AS preco_minimo
FROM products;

-- Exemplo de MAX()
SELECT MAX(unit_price) AS preco_maximo
FROM products;

-- Exemplo de COUNT()
SELECT COUNT(*) AS total_de_produtos
FROM products;

-- Exemplo de AVG()
SELECT AVG(unit_price) AS preco_medio
FROM products;

-- Exemplo de SUM()
SELECT SUM(quantity) AS quantidade_total_de_order_details
FROM order_details;

/*Práticas Recomendadas

    Precisão de dados: Ao usar AVG() e SUM(), esteja ciente do tipo de dados da coluna para evitar imprecisões, especialmente com dados flutuantes.
    NULLs: Lembre-se de que a maioria das funções agregadas ignora valores NULL, exceto COUNT(*), que conta todas as linhas, incluindo aquelas com valores NULL.
    Performance: Em tabelas muito grandes, operações agregadas podem ser custosas em termos de desempenho. Considere usar índices adequados ou realizar pré-agregações quando aplicável.
    Clareza: Ao usar GROUP BY, assegure-se de que todas as colunas não agregadas na sua cláusula SELECT estejam incluídas na cláusula GROUP BY.
*/

-- Calcula o menor preço unitário de produtos em cada categoria
SELECT category_id, MIN(unit_price) AS preco_minimo
FROM products
GROUP BY category_id
ORDER BY category_id ASC;
