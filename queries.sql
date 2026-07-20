INSERT INTO customers (name, email) VALUES
    ('Иван Петров', 'ivan@example.com'),
    ('Мария Сидорова', 'maria@example.com'),
    ('Пётр Кузнецов', 'petr@example.com'),
	('Анна Иванова', 'anna@example.com');

INSERT INTO products (title, price) VALUES
    ('Ноутбук', 89999.00),
    ('Мышь', 1499.00),
    ('Монитор', 24999.00),
	('Клавиатура', 3000.00);

INSERT INTO orders (customer_id, created_at) VALUES 
	(1, '2026-03-05 10:00'),
	(1, '2026-04-06 13:00'),
	(2, '2026-04-10 16:00'),
	(3, '2026-06-01 09:30'),
	(4, '2026-05-01 10:00');

INSERT INTO order_items (order_id, product_id, qty) VALUES
    (1, 1, 2), (1, 2, 1), (2, 3, 1), (4, 3, 3), (3, 1, 2), (5, 4, 6);

INSERT INTO big_orders (customer_id)
SELECT (random() * 10000)::int
FROM generate_series(1, 100000);

--товары дороже 2000
SELECT product_id, title, price FROM products
WHERE price > 2000;

--заказы, сделанные после 26-04-07 00:00:00 (включительно)
SELECT customer_id, created_at FROM orders
WHERE created_at >= '2026-04-07 00:00:00'::timestamp
ORDER BY created_at;

--заказы клиента c именем Иван Петров, упорядоченные по дате заказа
SELECT o.customer_id, c.name, c.email, o.created_at FROM orders o
JOIN customers c ON o.customer_id = c.customer_id 
WHERE c.name = 'Иван Петров'
ORDER BY o.created_at;

--заказы с суммой, сгрупированные по id заказа и имени пользователя, упорядоченные по id заквза
SELECT o.order_id, c.name, SUM(p.price * oi.qty) AS total
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY o.order_id, c.name
ORDER BY o.order_id;

--бонусное задание C
INSERT INTO big_orders (customer_id)
SELECT (random() * 10000)::int
FROM generate_series(1, 100000);

EXPLAIN SELECT * FROM big_orders WHERE customer_id = 100;







