-- Task 2: Queries explaination

-- Query 1:

-- Create Customers table
CREATE TABLE Customers (
    CUSTOMER_ID SERIAL PRIMARY KEY,
    NAME VARCHAR(100),
    EMAIL_ID VARCHAR(100) UNIQUE,
    CONTACT_NO VARCHAR(15),
    ADDRESS TEXT
);


-- Query 2:

-- Create Suppliers table
CREATE TABLE Suppliers (
    SUPPLIER_ID SERIAL PRIMARY KEY,
    CONTACT_NUMBER VARCHAR(15),
    SUPPLIER_NAME VARCHAR(100)
);


-- Query 3:

-- Create Products table
CREATE TABLE Products (
    PRODUCT_ID SERIAL PRIMARY KEY,
    NAME_OF_PRODUCT VARCHAR(100),
    PRODUCT_DESCRIPTION TEXT,
    PRICE_OF_PRODUCT DECIMAL(10, 2),
    STOCK_QUANTITY INT,
    SUPPLIER_ID INT REFERENCES Suppliers(SUPPLIER_ID)
);



-- Query 4: 

-- Create Orders table
CREATE TABLE Orders (
    ORDER_ID SERIAL PRIMARY KEY,
    CUSTOMER_ID INT REFERENCES Customers(CUSTOMER_ID),
    ORDER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TOTAL_AMOUNT DECIMAL(10, 2),
    SHIPPING_LOCATION TEXT,
    PAYMENT_MODE VARCHAR(50)
);


-- Query 5:

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    ORDER_DETAIL_ID SERIAL PRIMARY KEY,
    ORDER_ID INT REFERENCES Orders(ORDER_ID),
    PRODUCT_ID INT REFERENCES Products(PRODUCT_ID),
    QUANTITY INT,
    ORDER_PRICE DECIMAL(10, 2)
);


-- Query 6:

-- Insert sample data into Customers
INSERT INTO Customers (NAME, EMAIL_ID, CONTACT_NO, ADDRESS) VALUES
('John Doe', 'john@example.com', '1234567890', '123 Elm St'),
('Jane Smith', 'jane@example.com', '0987654321', '456 Oak St'),
('Alice Johnson', 'alice@example.com', '5555555555', '789 Pine St'),
('Bob Brown', 'bob@example.com', '4444444444', '321 Maple St'),
('Charlie Black', 'charlie@example.com', '2222222222', '654 Cedar St');


-- Query 7:

-- Insert sample data into Suppliers
INSERT INTO Suppliers (CONTACT_NUMBER, SUPPLIER_NAME) VALUES
('1112223333', 'Supplier A'),
('4445556666', 'Supplier B'),
('7778889999', 'Supplier C');



-- Query 8:

-- Insert sample data into Products
INSERT INTO Products (NAME_OF_PRODUCT, PRODUCT_DESCRIPTION, PRICE_OF_PRODUCT, STOCK_QUANTITY, SUPPLIER_ID) VALUES
('Product A', 'Description A', 10.00, 100, 1),
('Product B', 'Description B', 20.00, 50, 2),
('Product C', 'Description C', 15.00, 75, 1),
('Product D', 'Description D', 25.00, 30, 3),
('Product E', 'Description E', 30.00, 20, 2);



-- Query 9:

-- Insert sample data into Orders
INSERT INTO Orders (CUSTOMER_ID, TOTAL_AMOUNT, SHIPPING_LOCATION, PAYMENT_MODE) VALUES
(1, 100.00, 'Location A', 'Credit Card'),
(2, 50.00, 'Location B', 'PayPal'),
(1, 75.00, 'Location C', 'Debit Card'),
(3, 200.00, 'Location D', 'Credit Card'),
(4, 150.00, 'Location E', 'Cash');


-- Query 10:

-- Insert sample data into OrderDetails
INSERT INTO OrderDetails (ORDER_ID, PRODUCT_ID, QUANTITY, ORDER_PRICE) VALUES
(1, 1, 2, 10.00),
(1, 2, 1, 20.00),
(2, 3, 3, 15.00),
(3, 4, 1, 25.00),
(4, 5, 2, 30.00);




-- Query 11:

-- Retrieve Orders for a Specific Customer (CustomerID = 1 in this case)
SELECT 
    c.NAME AS CustomerName, 
    p.NAME_OF_PRODUCT AS ProductName, 
    o.ORDER_DATE, 
    od.QUANTITY
FROM 
    Orders o
JOIN 
    Customers c ON o.CUSTOMER_ID = c.CUSTOMER_ID
JOIN 
    OrderDetails od ON o.ORDER_ID = od.ORDER_ID
JOIN 
    Products p ON od.PRODUCT_ID = p.PRODUCT_ID
WHERE 
    c.CUSTOMER_ID = 1; -- Change this ID for different customers



-- Query 12:

-- Find the Most Purchased Product
SELECT 
    p.NAME_OF_PRODUCT AS ProductName, 
    SUM(od.QUANTITY) AS TotalPurchased
FROM 
    OrderDetails od
JOIN 
    Products p ON od.PRODUCT_ID = p.PRODUCT_ID
GROUP BY 
    p.NAME_OF_PRODUCT
ORDER BY 
    TotalPurchased DESC
LIMIT 1;




-- Query 13:

-- Update the Stock Quantity of a Product (ProductID = 1 in this case)
UPDATE Products
SET STOCK_QUANTITY = STOCK_QUANTITY - 1
WHERE PRODUCT_ID = 1; -- Change this ID for different products



-- Query 14:

-- Delete a Customer's Record (CustomerID = 5 in this case)
DELETE FROM Customers
WHERE CUSTOMER_ID = 5; -- Change this ID for different customers


