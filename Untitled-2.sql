SELECT *
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID
LEFT JOIN OrderProducts AS OP ON O.OrderID = OP.OrderID
LEFT JOIN Products AS P ON OP.ProductID = P.ProductID
LEFT JOIN Payments AS PM ON O.OrderID = PM.OrderID
LEFT JOIN Shippings AS S ON O.OrderID = S.OrderID
LEFT JOIN Feedbacks AS F ON O.OrderID = F.OrderID
LEFT JOIN Invoices AS I ON O.OrderID = I.OrderID
WHERE C.FirstName = 'Jane';

