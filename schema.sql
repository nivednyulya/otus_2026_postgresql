CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    email       TEXT UNIQUE NOT NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    title      TEXT NOT NULL,
    price      NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    order_id    SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    created_at  TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE order_items (
    order_id   INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    qty        INT NOT NULL CHECK (qty > 0),
    PRIMARY KEY (order_id, product_id)
);

-- Название товара не должно быть пустым или состоять только из пробелов:
	ALTER TABLE products 
	ADD CONSTRAINT check_title_not_empty 
	CHECK (length(trim(title)) > 0);

-- Название товара должно быть уникальным
	ALTER TABLE public.products 
	ADD CONSTRAINT unique_products_title UNIQUE (title);

--индекс
CREATE INDEX idx_big_orders_customer_id ON big_orders (customer_id);