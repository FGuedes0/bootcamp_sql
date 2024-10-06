-- 1. Cria um relatório para todos os pedidos de 1996 e seus clientes (152 linhas)


SELECT 
* FROM ORDERS 
--COUNT(*) FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1996;


-- 2. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem funcionários (5 linhas)
SELECT e.city as cidade,
    COUNT(DISTINCT e.employee_id) AS QT_FUNCIONARIOS,
    COUNT(DISTINCT c.customer_id) AS QT_CLIENTES
FROM employees AS e
LEFT JOIN customers AS c
ON e.city = c.city
GROUP BY e.city
ORDER BY cidade ASC;


-- 3. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem clientes (69 linhas)

SELECT c.city as cidade,
    COUNT(DISTINCT c.customer_id) AS QT_FUNCIONARIOS,
    COUNT(DISTINCT e.employee_id ) AS QT_CLIENTES
FROM employees AS e
RIGHT JOIN customers AS c
ON e.city = c.city
GROUP BY c.city
ORDER BY cidade ASC;


-- 4.Cria um relatório que mostra o número de funcionários e clientes de cada cidade (71 linhas)
SELECT 
    COALESCE(c.city, e.city) as cidade,
    COUNT(DISTINCT c.customer_id) AS QT_CLIENTES,
    COUNT(DISTINCT e.employee_id) AS QT_FUNCIONARIOS
FROM customers AS c
FULL JOIN employees AS e
ON c.city = e.city 
GROUP BY c.city, e.city
ORDER BY cidade;


-- 5. Cria um relatório que mostra a quantidade total de produtos encomendados.
-- Mostra apenas registros para produtos para os quais a quantidade encomendada é menor que 200 (5 linhas)

SELECT 
    o.product_id, 
    p.product_name, 
    SUM(o.quantity) as quantidade_total
FROM order_details AS o
INNER JOIN products AS p
ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_name
HAVING SUM(o.QUANTITY) < 200
ORDER BY quantidade_total DESC;

-- 6. Cria um relatório que mostra o total de pedidos por cliente desde 31 de dezembro de 1996.
-- O relatório deve retornar apenas linhas para as quais o total de pedidos é maior que 15 (5 linhas)

SELECT 
    o.customer_id, 
    c.company_name, 
    c.contact_name, COUNT(o.order_id) AS total_pedidos
FROM orders AS o
LEFT JOIN customers AS c
ON c.customer_id = o.customer_id
WHERE o.order_date >= '1996-12-31'
GROUP BY o.customer_id, c.contact_name, c.company_name
HAVING COUNT(o.order_id) > 15
ORDER BY total_pedidos;