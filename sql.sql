SELECT * FROM Customers;
SELECT * FROM Categorys;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Customers;
SELECT * FROM OrderProducts;
SELECT * FROM Payments;
SELECT * FROM Shippings;
SELECT * FROM Feedbacks;
SELECT * FROM Invoices;

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

-- select category data
select CategoryName, ProductName, Description, OrderID
from Categorys
INNER JOIN Products 
ON Categorys.CategoryID = Products.CategoryID
FULL JOIN OrderProducts
ON Products.ProductID = OrderProducts.OrderProductID
WHERE CategoryName IS NOT NULL

-- select user payments data
SELECT C.*
FROM Payments AS P
INNER JOIN Orders AS O ON P.OrderID = O.OrderID
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
INNER JOIN OrderProducts AS OP ON O.OrderID = OP.OrderID
INNER JOIN Products AS PR ON OP.ProductID = PR.ProductID

-- select data of user 
SELECT C.CustomerID, C.FirstName, C.LastName, C.Email, C.PhoneNumber, C.Address,
       O.OrderID, O.OrderDate, O.TotalAmount, O.Status,
       OP.OrderProductID, OP.ProductID,
       P.ProductName, P.Description, P.Price, P.Quantity,
       PM.PaymentID, PM.PaymentDate, PM.PaymentMethod,
       S.ShippingID, S.ShippingDate, S.ShippingAddress,
       F.FeedbackID, F.Rating, F.Comments,
       I.InvoiceID, I.InvoiceDate, I.Amount
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID
LEFT JOIN OrderProducts AS OP ON O.OrderID = OP.OrderID
LEFT JOIN Products AS P ON OP.ProductID = P.ProductID
LEFT JOIN Payments AS PM ON O.OrderID = PM.OrderID
LEFT JOIN Shippings AS S ON O.OrderID = S.OrderID
LEFT JOIN Feedbacks AS F ON O.OrderID = F.OrderID
LEFT JOIN Invoices AS I ON O.OrderID = I.OrderID
WHERE C.FirstName = 'Jane';

