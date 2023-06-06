USE master; -- Set the context to the master database
drop database CRM2
-- Create the CRM2 database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'CRM2')
    CREATE DATABASE CRM2;

USE CRM2; -- Set the context to the CRM2 database

-- Create the Customer table
CREATE TABLE Customers (
	CustomerID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(50) NULL,
	LastName NVARCHAR(50) NULL,
	Email NVARCHAR(100) NULL,
	PhoneNumber NVARCHAR(20) NULL,
	Address NVARCHAR(100) NULL,
);

-- Create the Category table
CREATE TABLE Categorys (
	CategoryID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
	CategoryName NVARCHAR(50) NULL,
);

-- Create the Product table
CREATE TABLE Products (
	ProductID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
	ProductName NVARCHAR(50) NULL,
	Description NVARCHAR(MAX) NULL,
	Price DECIMAL(10, 2) NULL,
	Quantity INT NULL,
	CategoryID UNIQUEIDENTIFIER NOT NULL,
	FOREIGN KEY (CategoryID) REFERENCES Categorys (CategoryID)
);

-- Create the Order table
CREATE TABLE Orders (
	OrderID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
	CustomerID UNIQUEIDENTIFIER NOT NULL,
	OrderDate DATE NOT NULL,
	TotalAmount DECIMAL(8, 2) NOT NULL,
	Status BIT NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
);

-- Create the OrderProduct table
CREATE TABLE OrderProducts (
	OrderProductID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
	ProductID UNIQUEIDENTIFIER NOT NULL,
	OrderID UNIQUEIDENTIFIER NOT NULL,
	FOREIGN KEY (ProductID) REFERENCES Products (ProductID),
	FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
);

-- Create the Payment table
CREATE TABLE Payments (
	PaymentID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
	OrderID UNIQUEIDENTIFIER NULL,
	PaymentDate DATE NULL,
	PaymentMethod NVARCHAR(50) NULL,
	CustomerID UNIQUEIDENTIFIER NOT NULL,
	FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
);

-- Create the Shipping table
CREATE TABLE Shippings (
	ShippingID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
	OrderID UNIQUEIDENTIFIER NULL,
	ShippingDate DATE NULL,
	ShippingAddress NVARCHAR(100) NULL,
	CustomerID UNIQUEIDENTIFIER NOT NULL,
	FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
);

-- Create the Feedback table
CREATE TABLE Feedbacks (
	FeedbackID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL ,
	CustomerID UNIQUEIDENTIFIER NOT NULL,
	Rating INT NULL,
	Comments NVARCHAR(MAX) NULL,
	OrderID UNIQUEIDENTIFIER NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
	FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
);

-- Create the Invoice table
CREATE TABLE Invoices (
	InvoiceID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
	OrderID UNIQUEIDENTIFIER NULL,
	InvoiceDate DATE NULL,
	Amount DECIMAL(10, 2) NULL,
	CustomerID UNIQUEIDENTIFIER NOT NULL,
	FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
);