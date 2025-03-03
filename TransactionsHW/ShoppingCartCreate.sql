CREATE DATABASE eCommerce;
GO
USE eCommerce;
GO
CREATE TABLE Customers(
	IDCustomer int NOT NULL,
	CustomerName varchar(255) NOT NULL,
 CONSTRAINT PK_Customers PRIMARY KEY (IDCustomer)
);

CREATE TABLE Orders(
	IDOrder int IDENTITY(1,1) NOT NULL,
	IDCustomer int NOT NULL,
	OrderTotal decimal(15, 2) NOT NULL,
	OrderDate datetime NOT NULL,
 CONSTRAINT PK_Orders PRIMARY KEY(IDOrder)
);

CREATE TABLE OrderDetails(
	IDOrder int NOT NULL,
	ProductSKU char(12) NOT NULL,
	Quantity int NOT NULL,
	Price decimal(15, 2) NOT NULL,
	Subtotal decimal(15, 2) NOT NULL,
 CONSTRAINT PK_OrderDetails PRIMARY KEY(IDOrder, ProductSKU) 
);

CREATE TABLE Products(
	ProductSKU char(12) NOT NULL,
	ProductName varchar(255) NOT NULL,
	ProductDescription varchar(4000) NOT NULL,
	ProductInventory int NULL,
	ProductPrice decimal(15, 2) NOT NULL,
 CONSTRAINT PK_Products PRIMARY KEY (ProductSKU)
);

CREATE TABLE ShoppingCart(
	IDCustomer int NOT NULL,
	ProductSKU char(12) NOT NULL,
	Quantity int NOT NULL,
	Price decimal(15, 2) NOT NULL,
	Subtotal decimal(15, 2) NOT NULL
);

ALTER TABLE OrderDetails ADD CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(IDOrder)
REFERENCES Orders(IDOrder);

ALTER TABLE OrderDetails ADD CONSTRAINT FK_OrderDetails_Products FOREIGN KEY(ProductSKU)
REFERENCES Products (ProductSKU);

ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY(IDCustomer)
REFERENCES Customers (IDCustomer);

ALTER TABLE ShoppingCart ADD CONSTRAINT FK_ShoppingCart_Customers FOREIGN KEY(IDCustomer)
REFERENCES Customers (IDCustomer);

ALTER TABLE ShoppingCart ADD CONSTRAINT FK_ShoppingCart_Products FOREIGN KEY(ProductSKU)
REFERENCES Products (ProductSKU);
