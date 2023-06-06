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

-- Insert demo data into Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, PhoneNumber, Address)
VALUES
    (NEWID(), 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Street'),
    (NEWID(), 'Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Avenue'),
	(NEWID(), 'Sarah', 'Johnson', 'sarah.johnson@example.com', '5555555555', '123 Road'),
	(NEWID(), 'Michael', 'Williams', 'michael.williams@example.com', '9999999999', '321 Boulevard'),
	(NEWID(), 'Emily', 'Brown', 'emily.brown@example.com', '1111111111', '987 Lane'),
	(NEWID(), 'David', 'Taylor', 'david.taylor@example.com', '4444444444', '654 Court'),
	(NEWID(), 'Olivia', 'Anderson', 'olivia.anderson@example.com', '2222222222', '456 Avenue'),
	(NEWID(), 'James', 'Wilson', 'james.wilson@example.com', '7777777777', '789 Street'),
	(NEWID(), 'Emma', 'Martinez', 'emma.martinez@example.com', '8888888888', '123 Road'),
	(NEWID(), 'Daniel', 'Lee', 'daniel.lee@example.com', '6666666666', '321 Boulevard')

    -- Add more records as needed

-- Insert demo data into Categorys table
INSERT INTO Categorys (CategoryID, CategoryName)
VALUES
    (NEWID(), 'Electronics'),
    (NEWID(), 'Clothing'),
    (NEWID(), 'Books'),
    (NEWID(), 'Home Decor'),
    (NEWID(), 'Sports'),
    (NEWID(), 'Beauty'),
    (NEWID(), 'Toys'),
    (NEWID(), 'Jewelry'),
    (NEWID(), 'Automotive'),
    (NEWID(), 'Fitness');
    -- Add more records as needed

-- Insert demo data into Products table
INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Smartphone', 'A high-end smartphone', 999.99, 10, (SELECT TOP 1 CategoryID FROM Categorys)),
    (NEWID(), 'T-Shirt', 'A plain white t-shirt', 19.99, 20, (SELECT TOP 1 CategoryID FROM Categorys)),
	(NEWID(), 'T-Shirt', 'A plain white t-shirt', 19.99, 20, (SELECT TOP 1 CategoryID FROM Categorys))
    -- Add more records as needed
-- For Books:
INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Fiction Novel', 'Engaging fictional story with captivating characters.', 15.00, 50, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'Self-Help Book', 'Guide to personal development and self-improvement.', 12.00, 40, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'Cookbook', 'Collection of delicious recipes and cooking tips.', 20.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'Biography', 'Inspiring life story of a notable individual.', 18.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'Children''s Book', 'Colorful and entertaining book for young readers.', 10.00, 60, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'Thriller Novel', 'Suspenseful and thrilling story that keeps you guessing.', 16.00, 35, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'Science Fiction Book', 'Imaginative and futuristic story in a sci-fi setting.', 14.00, 45, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'History Book', 'Insightful exploration of historical events and figures.', 22.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'Poetry Collection', 'Beautifully crafted poems that evoke emotions.', 13.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books')),
    (NEWID(), 'Educational Book', 'Informative book covering various educational topics.', 17.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Books'));

--For Electronics:

INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Laptop', 'High-performance laptop with advanced features.', 1200.00, 5, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Smartphone', 'Latest smartphone model with a large display.', 800.00, 8, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Headphones', 'Wireless headphones with noise-cancellation technology.', 150.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Smart TV', 'Ultra HD smart TV with built-in streaming apps.', 1000.00, 3, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Digital Camera', 'Professional-grade digital camera with multiple lenses.', 1500.00, 2, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Gaming Console', 'Popular gaming console with immersive gaming experiences.', 500.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Wireless Speaker', 'Portable wireless speaker with excellent sound quality.', 80.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Tablet', 'Versatile tablet for work and entertainment.', 600.00, 6, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Fitness Tracker', 'Smart fitness tracker for tracking activity and monitoring health.', 100.00, 12, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics')),
    (NEWID(), 'Wireless Earbuds', 'Compact wireless earbuds with long battery life.', 100.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Electronics'));
-- For Clothing:
INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'T-Shirt', 'Casual and comfortable cotton t-shirt.', 20.00, 50, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Jeans', 'Classic denim jeans for everyday wear.', 50.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Dress', 'Elegant dress for special occasions.', 80.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Sweater', 'Warm and cozy sweater for chilly weather.', 60.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Shoes', 'Stylish and comfortable shoes for all-day wear.', 70.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Jacket', 'Trendy jacket for a fashionable look.', 100.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Skirt', 'Versatile skirt for various outfits.', 40.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Blouse', 'Chic blouse for a sophisticated look.', 30.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Shorts', 'Comfortable shorts for casual summer days.', 25.00, 40, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing')),
    (NEWID(), 'Socks', 'Soft and durable socks for everyday wear.', 10.00, 50, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Clothing'));

-- For Books:

-- For Home Decor:

INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Decorative Pillow', 'Stylish and comfortable pillow for your home.', 25.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Wall Art', 'Beautiful artwork to enhance your wall decor.', 50.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Candle Holder', 'Elegant candle holder for a warm ambiance.', 20.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Vase', 'Artistic vase to display flowers or decorative items.', 35.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Table Lamp', 'Functional and stylish lamp for your living space.', 40.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Throw Blanket', 'Cozy and soft blanket for chilly evenings.', 30.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Mirror', 'Decorative mirror for adding depth to your room.', 55.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Clock', 'Modern wall clock for keeping track of time.', 45.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Rug', 'Stylish rug to add comfort and style to your floor.', 60.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor')),
    (NEWID(), 'Curtains', 'Elegant curtains to enhance your window decor.', 35.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Home Decor'));

-- For Sports:

INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Yoga Mat', 'Non-slip and durable mat for yoga and exercise.', 30.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Dumbbell Set', 'Set of adjustable dumbbells for strength training.', 80.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Running Shoes', 'Comfortable shoes for running and outdoor activities.', 70.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Tennis Racket', 'Professional-grade racket for tennis enthusiasts.', 120.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Basketball', 'Official-size basketball for indoor and outdoor play.', 25.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Bicycle', 'Sturdy and reliable bicycle for cycling enthusiasts.', 250.00, 5, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Gym Bag', 'Spacious and durable bag for carrying gym essentials.', 40.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Treadmill', 'High-quality treadmill for indoor cardio workouts.', 1000.00, 2, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Swimming Goggles', 'Comfortable goggles for swimming and water sports.', 20.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports')),
    (NEWID(), 'Golf Clubs Set', 'Complete set of golf clubs for golfing enthusiasts.', 300.00, 5, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Sports'));

-- For Beauty:

INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Face Moisturizer', 'Hydrating moisturizer for smooth and glowing skin.', 25.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Lipstick', 'Long-lasting lipstick for vibrant and colorful lips.', 15.00, 40, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Mascara', 'Volumizing mascara for bold and dramatic lashes.', 18.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Perfume', 'Elegant fragrance for a pleasant and alluring scent.', 50.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Hair Straightener', 'Professional hair straightener for sleek and smooth hair.', 70.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Nail Polish Set', 'Set of vibrant nail polishes for creative nail art.', 30.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Facial Cleanser', 'Gentle facial cleanser for a fresh and clean face.', 20.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Eyeshadow Palette', 'Palette of eyeshadows for versatile eye makeup.', 35.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Hair Dryer', 'Powerful hair dryer for quick and efficient drying.', 40.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty')),
    (NEWID(), 'Face Mask', 'Revitalizing face mask for a pampering skincare routine.', 12.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Beauty'));

-- For Toys:
INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Building Blocks Set', 'Colorful blocks for imaginative building play.', 25.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'Doll', 'Adorable doll for nurturing and pretend play.', 20.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'Remote Control Car', 'Fast and fun remote control car for racing.', 30.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'Puzzle', 'Challenging puzzle for developing problem-solving skills.', 15.00, 35, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'Board Game', 'Entertaining board game for family and friends.', 25.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'Stuffed Animal', 'Soft and cuddly stuffed animal for companionship.', 18.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'Art Set', 'Creative art set for drawing and coloring.', 20.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'Toy Kitchen Set', 'Interactive kitchen set for pretend cooking.', 35.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'Musical Instrument', 'Miniature musical instrument for musical exploration.', 30.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys')),
    (NEWID(), 'RC Drone', 'Remote control drone for aerial adventures.', 50.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Toys'));

--For Jewelry:
INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Necklace', 'Elegant necklace for adding a touch of glamour.', 80.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Bracelet', 'Stylish bracelet for a fashionable look.', 50.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Earrings', 'Sparkling earrings for a sophisticated appearance.', 60.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Ring', 'Beautiful ring for a special occasion or everyday wear.', 70.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Anklet', 'Delicate anklet for a boho-chic look.', 40.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Watch', 'Stylish watch for keeping time with flair.', 90.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Brooch', 'Unique brooch for adding a statement to your outfit.', 45.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Cufflinks', 'Sophisticated cufflinks for a polished look.', 55.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Pendant', 'Charming pendant for showcasing your personal style.', 65.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry')),
    (NEWID(), 'Choker', 'Trendy choker for a fashionable accessory.', 30.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Jewelry'));

-- For Automotive:

INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Car Wax', 'High-quality car wax for a shiny and protected finish.', 25.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Car Floor Mats', 'Durable and easy-to-clean floor mats for your car.', 35.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Car Phone Mount', 'Convenient phone mount for hands-free driving.', 20.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Car Air Freshener', 'Long-lasting car air freshener for a pleasant aroma.', 15.00, 35, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Car Jump Starter', 'Portable jump starter for emergency car battery charging.', 70.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Car Seat Covers', 'Protective seat covers for preserving your car seats.', 40.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Car Wash Kit', 'Complete car wash kit for a thorough cleaning.', 50.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Car Vacuum Cleaner', 'Powerful vacuum cleaner for cleaning your car interior.', 60.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Tire Inflator', 'Portable tire inflator for maintaining proper tire pressure.', 30.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive')),
    (NEWID(), 'Roof Rack', 'Versatile roof rack for additional cargo space.', 90.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Automotive'));

-- For Fitness:

INSERT INTO Products (ProductID, ProductName, Description, Price, Quantity, CategoryID)
VALUES
    (NEWID(), 'Yoga Mat', 'Non-slip and durable mat for yoga and exercise.', 30.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Dumbbell Set', 'Set of adjustable dumbbells for strength training.', 80.00, 15, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Running Shoes', 'Comfortable shoes for running and outdoor activities.', 70.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Treadmill', 'High-quality treadmill for indoor cardio workouts.', 1000.00, 5, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Resistance Bands', 'Versatile bands for resistance training.', 25.00, 25, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Exercise Ball', 'Stability ball for core strengthening and balance.', 35.00, 20, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Fitness Tracker', 'Smart fitness tracker for monitoring your activity.', 120.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Jump Rope', 'Portable jump rope for cardio and endurance workouts.', 15.00, 30, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Exercise Bike', 'Indoor exercise bike for cycling workouts at home.', 500.00, 5, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness')),
    (NEWID(), 'Weight Bench', 'Sturdy weight bench for a variety of strength exercises.', 150.00, 10, (SELECT CategoryID FROM Categorys WHERE CategoryName = 'Fitness'));

-- Insert demo data into Orders table
--INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status)
--VALUES
    -- (NEWID(), (SELECT TOP 1 CustomerID FROM Customers), GETDATE(), 199.99, 1),
    -- (NEWID(), (SELECT TOP 1 CustomerID FROM Customers), GETDATE(), 299.99, 1)
    -- Add more records as needed
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status)
VALUES
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith'), GETDATE(), 150.00, 1),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe'), GETDATE(), 200.00, 1),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Sarah' AND LastName = 'Johnson'), GETDATE(), 75.50, 0),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Michael' AND LastName = 'Williams'), GETDATE(), 350.00, 1),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Emily' AND LastName = 'Brown'), GETDATE(), 95.00, 0),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Daniel' AND LastName = 'Lee'), GETDATE(), 120.00, 1),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'David' AND LastName = 'Taylor'), GETDATE(), 250.00, 1),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Olivia' AND LastName = 'Anderson'), GETDATE(), 180.00, 0),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'James' AND LastName = 'Wilson'), GETDATE(), 90.00, 1),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Emma' AND LastName = 'Martinez'), GETDATE(), 300.00, 0);

-- Insert demo data into OrderProducts table
-- INSERT INTO OrderProducts (OrderProductID, ProductID, OrderID)
-- VALUES
    --(NEWID(), (SELECT TOP 1 ProductID FROM Products), (SELECT TOP 1 OrderID FROM Orders)),
    -- (NEWID(), (SELECT TOP 1 ProductID FROM Products), (SELECT TOP 1 OrderID FROM Orders))
    -- Add more records as needed
INSERT INTO OrderProducts (OrderProductID, ProductID, OrderID)
VALUES
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Car Jump Starter'), (SELECT OrderID FROM Orders WHERE OrderID = 'FC81E9D9-0DD2-460F-ABB5-09F712F60F97')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Car Jump Starter'), (SELECT OrderID FROM Orders WHERE OrderID = 'FC81E9D9-0DD2-460F-ABB5-09F712F60F97')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Car Jump Starter'), (SELECT OrderID FROM Orders WHERE OrderID = 'FC81E9D9-0DD2-460F-ABB5-09F712F60F97')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Nail Polish Set'), (SELECT OrderID FROM Orders WHERE OrderID = '70BB8907-9634-46E2-941A-1B62AB929B3A')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Decorative Pillow'), (SELECT OrderID FROM Orders WHERE OrderID = 'AE1D148D-3DC2-4C53-8B3D-795813AF420B')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Self-Help Book'), (SELECT OrderID FROM Orders WHERE OrderID = 'AE1D148D-3DC2-4C53-8B3D-795813AF420B')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Car Air Freshener'), (SELECT OrderID FROM Orders WHERE OrderID = '3EC99497-90EA-4284-8E28-7C5360F4C06C')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Smartphone'), (SELECT OrderID FROM Orders WHERE OrderID = '6EE53CA7-F95D-4245-9FB3-7E83230BD70E')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Smartphone'), (SELECT OrderID FROM Orders WHERE OrderID = '581369EE-C82B-4F32-974B-848930A39998')),
    (NEWID(), (SELECT ProductID FROM Products WHERE ProductName = 'Smartphone'), (SELECT OrderID FROM Orders WHERE OrderID = '0BD1E6E0-0E97-40C6-8420-C9A0A975FB86'));

-- Insert demo data into Payments table
-- INSERT INTO Payments (PaymentID, OrderID, PaymentDate, PaymentMethod, CustomerID)
--VALUES
    --(NEWID(), (SELECT TOP 1 OrderID FROM Orders), GETDATE(), 'Credit Card', (SELECT TOP 1 CustomerID FROM Customers)),
    -- (NEWID(), (SELECT TOP 1 OrderID FROM Orders), GETDATE(), 'PayPal', (SELECT TOP 1 CustomerID FROM Customers))
    -- Add more records as needed
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, PaymentMethod, CustomerID)
VALUES
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '150'), '2023-06-01', 'Credit Card', (SELECT CustomerID FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '150'), '2023-06-01', 'PayPal', (SELECT CustomerID FROM Customers WHERE FirstName = 'Sarah' AND LastName = 'Johnson')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '350'), '2023-06-02', 'Cash', (SELECT CustomerID FROM Customers WHERE FirstName = 'Michael' AND LastName = 'Williams')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '250'), '2023-06-02', 'Credit Card', (SELECT CustomerID FROM Customers WHERE FirstName = 'Emily' AND LastName = 'Brown')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '180'), '2023-06-03', 'PayPal', (SELECT CustomerID FROM Customers WHERE FirstName = 'Daniel' AND LastName = 'Lee')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '120'), '2023-06-03', 'Cash', (SELECT CustomerID FROM Customers WHERE FirstName = 'David' AND LastName = 'Taylor')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '300'), '2023-06-04', 'Credit Card', (SELECT CustomerID FROM Customers WHERE FirstName = 'Olivia' AND LastName = 'Anderson')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '300'), '2023-06-04', 'Cash', (SELECT CustomerID FROM Customers WHERE FirstName = 'James' AND LastName = 'Wilson')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '120'), '2023-06-05', 'PayPal', (SELECT CustomerID FROM Customers WHERE FirstName = 'Emma' AND LastName = 'Martinez'));
-- Insert demo data into Shippings table
-- INSERT INTO Shippings (ShippingID, OrderID, ShippingDate, ShippingAddress, CustomerID)
-- VALUES
--     (NEWID(), (SELECT TOP 1 OrderID FROM Orders), GETDATE(), '123 Street', (SELECT TOP 1 CustomerID FROM Customers)),
--     (NEWID(), (SELECT TOP 1 OrderID FROM Orders), GETDATE(), '456 Avenue', (SELECT TOP 1 CustomerID FROM Customers))
    -- Add more records as needed

INSERT INTO Shippings (ShippingID, OrderID, ShippingDate, ShippingAddress, CustomerID)
VALUES
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '180'), '2023-06-06', '123 Street, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '200'), '2023-06-06', '456 Avenue, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '75'), '2023-06-07', '789 Road, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '300'), '2023-06-08', '321 Lane, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '150'), '2023-06-06', '654 Street, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '350'), '2023-06-08', '987 Avenue, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '300'), '2023-06-06', '159 Road, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '95'), '2023-06-06', '753 Lane, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '250'), '2023-06-07', '246 Street, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE TotalAmount = '90'), '2023-06-08', '864 Avenue, City, Country', (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith'));

-- SELECT * FROM Shippings
-- Insert demo data into Feedbacks table
-- INSERT INTO Feedbacks (FeedbackID, CustomerID, Rating, Comments, OrderID)
-- VALUES
--     (NEWID(), (SELECT TOP 1 CustomerID FROM Customers), 5, 'Great service!', (SELECT TOP 1 OrderID FROM Orders)),
--     (NEWID(), (SELECT TOP 1 CustomerID FROM Customers), 4, 'Product quality could be better.', (SELECT TOP 1 OrderID FROM Orders))
    -- Add more records as needed
INSERT INTO Feedbacks (FeedbackID, CustomerID, Rating, Comments, OrderID)
VALUES
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Michael' AND LastName = 'Williams'), 4, 'Great product!', (SELECT OrderID FROM Orders WHERE TotalAmount = '200')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'James' AND LastName = 'Wilson'), 3, 'Average quality.', (SELECT OrderID FROM Orders WHERE TotalAmount = '180')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Daniel' AND LastName = 'Lee'), 5, 'Excellent service!', (SELECT OrderID FROM Orders WHERE TotalAmount = '120')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'David' AND LastName = 'Taylor'), 2, 'Disappointed with the product.', (SELECT OrderID FROM Orders WHERE TotalAmount = '200')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Emma' AND LastName = 'Martinez'), 4, 'Good value for money.', (SELECT OrderID FROM Orders WHERE TotalAmount = '300')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Olivia' AND LastName = 'Anderson'), 5, 'Highly recommend!', (SELECT OrderID FROM Orders WHERE TotalAmount = '300')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith'), 3, 'Could be better.', (SELECT OrderID FROM Orders WHERE TotalAmount = '150')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Emily' AND LastName = 'Brown'), 5, 'Amazing product!', (SELECT OrderID FROM Orders WHERE TotalAmount = '350')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith'), 4, 'Satisfied with the purchase.', (SELECT OrderID FROM Orders WHERE TotalAmount = '95')),
    (NEWID(), (SELECT CustomerID FROM Customers WHERE FirstName = 'Sarah' AND LastName = 'Johnson'), 5, 'Top-notch customer service.', (SELECT OrderID FROM Orders WHERE TotalAmount = '250'));

-- Insert demo data into Invoices table
-- INSERT INTO Invoices (InvoiceID, OrderID, InvoiceDate, Amount, CustomerID)
-- VALUES
--     (NEWID(), (SELECT TOP 1 OrderID FROM Orders), GETDATE(), 199.99, (SELECT TOP 1 CustomerID FROM Customers)),
--     (NEWID(), (SELECT TOP 1 OrderID FROM Orders), GETDATE(), 299.99, (SELECT TOP 1 CustomerID FROM Customers))
    -- Add more records as needed
INSERT INTO Invoices (InvoiceID, OrderID, InvoiceDate, Amount, CustomerID)
VALUES
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-01'), '2023-06-05', 250.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-01'), '2023-06-06', 150.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-02'), '2023-06-07', 180.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-02'), '2023-06-08', 120.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-03'), '2023-06-09', 300.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-03'), '2023-06-10', 220.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-04'), '2023-06-11', 190.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-04'), '2023-06-12', 210.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-05'), '2023-06-13', 280.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith')),
    (NEWID(), (SELECT OrderID FROM Orders WHERE OrderDate = '2023-06-05'), '2023-06-14', 150.00, (SELECT CustomerID FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Smith'));


-- Inner Join between Orders and Customers:

SELECT *
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
-- Inner Join between OrderProducts, Orders, and Products:
SELECT *
FROM OrderProducts
INNER JOIN Orders ON OrderProducts.OrderID = Orders.OrderID
INNER JOIN Products ON OrderProducts.ProductID = Products.ProductID;
-- Inner Join between Payments, Orders, and Customers:

SELECT *
FROM Payments
INNER JOIN Orders ON Payments.OrderID = Orders.OrderID
INNER JOIN Customers ON Payments.CustomerID = Customers.CustomerID;
-- Inner Join between Shippings, Orders, and Customers:

SELECT *
FROM Shippings
INNER JOIN Orders ON Shippings.OrderID = Orders.OrderID
INNER JOIN Customers ON Shippings.CustomerID = Customers.CustomerID;
-- Inner Join between Feedbacks, Orders, and Customers:

SELECT *
FROM Feedbacks
INNER JOIN Orders ON Feedbacks.OrderID = Orders.OrderID
INNER JOIN Customers ON Feedbacks.CustomerID = Customers.CustomerID;
-- Inner Join between Invoices, Orders, and Customers:

SELECT *
FROM Invoices
INNER JOIN Orders ON Invoices.OrderID = Orders.OrderID
INNER JOIN Customers ON Invoices.CustomerID = Customers.CustomerID;


-- Left Join between Orders and Customers:
SELECT *
FROM Orders
LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
-- Right Join between Orders and Customers:

SELECT *
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
-- Left Join between OrderProducts, Orders, and Products:

SELECT *
FROM OrderProducts
LEFT JOIN Orders ON OrderProducts.OrderID = Orders.OrderID
LEFT JOIN Products ON OrderProducts.ProductID = Products.ProductID;
-- Right Join between OrderProducts, Orders, and Products:

SELECT *
FROM OrderProducts
RIGHT JOIN Orders ON OrderProducts.OrderID = Orders.OrderID
RIGHT JOIN Products ON OrderProducts.ProductID = Products.ProductID;
-- Left Join between Payments, Orders, and Customers:

SELECT *
FROM Payments
LEFT JOIN Orders ON Payments.OrderID = Orders.OrderID
LEFT JOIN Customers ON Payments.CustomerID = Customers.CustomerID;
-- Right Join between Payments, Orders, and Customers:

SELECT *
FROM Payments
RIGHT JOIN Orders ON Payments.OrderID = Orders.OrderID
RIGHT JOIN Customers ON Payments.CustomerID = Customers.CustomerID;

-- full JOint

SELECT *
FROM Orders
FULL JOIN Customers ON Orders.CustomerID = Customers.CustomerID
FULL JOIN OrderProducts ON Orders.OrderID = OrderProducts.OrderID
FULL JOIN Products ON OrderProducts.ProductID = Products.ProductID
FULL JOIN Payments ON Orders.OrderID = Payments.OrderID
FULL JOIN Shippings ON Orders.OrderID = Shippings.OrderID
FULL JOIN Feedbacks ON Orders.OrderID = Feedbacks.OrderID
FULL JOIN Invoices ON Orders.OrderID = Invoices.OrderID;
