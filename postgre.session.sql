SELECT *
FROM users

SELECT *
FROM shopping_cart

SELECT *
FROM products

SELECT *
FROM orders


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



--INSERT INTO TABLES =========================

-- Insert first two entries into users table
INSERT INTO users VALUES (501335, 'Stanzey10', 'stan2332', 'Stanley', 'Clark', 'sclark10@gmail.com', '9055553333','24 lesley dr, Toronto Ontario, l7e 2v2 Canada');
INSERT INTO users VALUES (440162, 'MsBentley', 'msbet4242', 'Betty', 'Simpson', 'betlovesbently@gmail.com', '9052896888','109 marine rd, London Ontario, b9h 6f6 Canada');

-- Insert the shopping_cart with cart_id = 1 into the shopping_cart table
INSERT INTO shopping_cart (1, 'Best Earpod, Head Warmer, Swoop Wristband');

-- Insert user_id and the rest entries into the users table
INSERT INTO users VALUES (311289,'Melanin','mehak20','Melani','Smith','mssmith21@gmail.com','9056123884','11 birley dr, Mississauga Ontario, e7e 5v5 CA');
INSERT INTO users VALUES (922012,'Yolo','mynameyolo','Yummy','Black','yummy_reahme@gmail.com','9059821122','13 portsmouth rd, Cambridge Ontario, r2h 7f7 CA');
INSERT INTO users VALUES (641233,'Beehives','beezule','Bishark','Reid','Reshark606@gmail.com','9054269821','78 alexis way, Hamilton Ontario, j7s 1v1 CA');

-- Insert the rest values into shopping_cart with cart_id = 2, 3, 4, 5 into the shopping_cart table
INSERT INTO shopping_cart VALUES(2, 'Chair, Bag, Shirt, Boots, gloves');
INSERT INTO shopping_cart VALUES(3, 'Shoe, Ring, Sweet, Frame, Cup, Knife');
INSERT INTO shopping_cart VALUES(4, 'Spoon, Book, Key, Plate');
INSERT INTO shopping_cart VALUES(5, 'Phone, Glasses');

-- Insert into the products table
INSERT INTO products VALUES(101,'Best Earpod','White Cordless Earpod','$50');
INSERT INTO products VALUES(102,'Phone','Portable Toy Phone','$10');
INSERT INTO products VALUES(103,'Head Warmer','Winter Wonder','$7');
INSERT INTO products VALUES(104,'Glasses','Foldable Glasses','$20');
INSERT INTO products VALUES(105,'Swoop Wristband','Activity Wristband','$5');
INSERT INTO products VALUES(106,'Chair','Foldable Chair','$100');
INSERT INTO products VALUES(107,'Shoe','Black Shoe','$40');
INSERT INTO products VALUES(108,'Book','Flat Book','$3');
INSERT INTO products VALUES(109,'Spoon','Iron Spoon','$4');
INSERT INTO products VALUES(100,'Ring','Gold Ring','$20');
INSERT INTO products VALUES(111,'Bag','Red Back Bag','$30');
INSERT INTO products VALUES(112,'Shirt','White shirt','$9');
INSERT INTO products VALUES(113,'Sweet','Lemon Sweet','$2');
INSERT INTO products VALUES(114,'Key','Universal Key','$60');
INSERT INTO products VALUES(115,'Plate','Ceramic Plate Set','$50');
INSERT INTO products VALUES(116,'Frame','Wall Frame','$10');
INSERT INTO products VALUES(117,'Boots','Ski Boots','$150');
INSERT INTO products VALUES(118,'Cup','Pink Rubber Cup','$3');
INSERT INTO products VALUES(119,'Gloves','Winter Gloves','$7');
INSERT INTO products VALUES(120,'Knife','Bread Knife','$1');

ALTER TABLE products ALTER COLUMN product_name TYPE character varying(200);
ALTER TABLE products ALTER COLUMN product_description TYPE character varying(200);
ALTER TABLE products ALTER COLUMN product_price TYPE character varying(200);

-- Add order_details to orders table
ALTER TABLE orders ADD COLUMN order_details VARCHAR(20);

-- Insert order_id and the rest entries into the orders table
INSERT INTO orders VALUES(22,'24/10/2024','10:00','Best Earpod, Head Warmer, Swoop Wristband',1,641233);
INSERT INTO orders VALUES(34,'12/01/2025','06:00','Chair, Bag, Shirt, Boots, gloves',2,501335);
INSERT INTO orders VALUES(46,'14/02/2025','08:00','Shoe, Ring, Sweet, Frame, Cup, Knife',3,440162);
INSERT INTO orders VALUES(65,'19/03/2025','11:00','Spoon, Book, Key, Plate',4,922012);
INSERT INTO orders VALUES(98,'13/03/2025','09:00','Phone, Glasses',5,311289);

-- Add cart_id into orders table
ALTER TABLE orders ADD COLUMN cart_id INT;

--Add user_id into orders table
ALTER TABLE orders ADD COLUMN user_id INT;

ALTER TABLE orders ALTER COLUMN order_date TYPE character varying(200);
ALTER TABLE orders ALTER COLUMN order_time TYPE character varying(200);
ALTER TABLE orders ALTER COLUMN order_details TYPE character varying(200);

