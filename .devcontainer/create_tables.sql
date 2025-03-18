-- DROP TABLES

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS shoppingCart CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS orders CASCADE;

-- CREATE TABLES ========================================

-- Create users table 
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(500),
	password VARCHAR(500),
	first_name VARCHAR(500),
	last_name VARCHAR(500),
    email VARCHAR(500),
    phone VARCHAR(50),
    address VARCHAR (500)
);

-- Create shopping cart table
CREATE TABLE shopping_cart (
	cart_id INT PRIMARY KEY,
	cart_details VARCHAR(50),
);

-- Add foreign key to shopping cart table
ALTER TABLE shopping_cart
ADD FOREIGN KEY (user_id)
REFERENCES orders (user_id)
ON DELETE SET NULL;

-- Create product table
CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(20),
	product_description VARCHAR(20),
	product_price VARCHAR(20)
);

-- Add foreign key to product table
ALTER TABLE products
ADD FOREIGN KEY (order_item_id)
REFERENCES order_items (order_item_id)
ON DELETE SET NULL;

-- Create orders table
CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	order_date VARCHAR(20),
	order_time VARCHAR(20), 
);

-- Add foreign key to orders table
ALTER TABLE orders
ADD FOREIGN KEY (user_id)
REFERENCES shopping_cart (user_id)
ON DELETE SET NULL;