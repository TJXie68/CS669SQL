CREATE TABLE Pizza (
pizza_id DECIMAL(12) NOT NULL PRIMARY KEY,
name VARCHAR(12) NOT NULL,
date_available DATE NOT NULL,
price DECIMAL(4,2) NOT NULL
);

CREATE TABLE Topping(
topping_id DECIMAL(12) NOT NULL,
topping_name VARCHAR(64) NOT NULL,
pizza_id DECIMAL(12) NULL
);

ALTER TABLE Topping
ADD CONSTRAINT topping_pk
PRIMARY KEY (topping_id);

ALTER TABLE Topping
ADD CONSTRAINT topping_pizza_fk
FOREIGN KEY (pizza_id)
REFERENCES Pizza(pizza_id);

INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (1, 'Plain', '2024-10-04', 7.99);
INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (2, 'Hawaiian', '2024-10-03', 11.99);
INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (3, 'Cheese', '2024-10-02', 9.99);
INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (4, 'Veggie', '2024-10-01', 9.99);

INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (101, 'Cheese', 3);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (102, 'Pineapple', 2);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (103, 'Vegetable', 4);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (104, 'Beaf', 3);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (105, 'Ham', 2);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (106, 'Seafood', NULL);

SELECT * 
FROM Pizza;
SELECT *
FROM Topping;

INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (107, 'Pepperoni', 5);

SELECT name, topping_name
FROM Topping
Join Pizza ON Pizza.pizza_id = Topping.pizza_id;

SELECT name, topping_name, date_available
FROM Topping
RIGHT JOIN Pizza ON Pizza.pizza_id = Topping.pizza_id;
ORDER BY date_avaliable ASC;

SELECT name, topping_name, date_available
FROM Pizza
LEFT JOIN Topping ON Pizza.pizza_id = Topping.pizza_id;

SELECT name, topping_name
FROM Pizza
RIGHT JOIN Topping ON Pizza.pizza_id = Topping.pizza_id
ORDER BY topping_name DESC;

SELECT name, topping_name
FROM Topping
LEFT JOIN Pizza ON Pizza.pizza_id = Topping.pizza_id
ORDER BY topping_name DESC;

SELECT name, topping_name
FROM Pizza
LEFT JOIN Topping ON Pizza.pizza_id = Topping.pizza_id
UNION
SELECT name, topping_name
FROM Pizza
RIGHT JOIN Topping ON Pizza.pizza_id = Topping.pizza_id
ORDER BY topping_name DESC;

SELECT name, topping_name
FROM Pizza
LEFT JOIN Topping ON Pizza.pizza_id = Topping.pizza_id
UNION
SELECT name, topping_name
FROM Pizza
RIGHT JOIN Topping ON Pizza.pizza_id = Topping.pizza_id
ORDER BY name DESC;

SELECT name, CONCAT('$', FORMAT(price, 2)) as price
FROM Pizza;

SELECT name, CONCAT('$', FORMAT(price * 0.8, 2)) as price
FROM Pizza;

SELECT topping_name, name, CONCAT('$', FORMAT(price, 2)) as price
FROM Topping
LEFT JOIN Pizza ON Pizza.pizza_id = Topping.pizza_id
UNION
SELECT topping_name, name, CONCAT('$', FORMAT(price, 2)) as price
FROM Topping
RIGHT JOIN Pizza ON Pizza.pizza_id = Topping.pizza_id
ORDER BY topping_name;