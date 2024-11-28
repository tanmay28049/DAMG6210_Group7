-- Non-clustered index on BookingDate
CREATE NONCLUSTERED INDEX idx_Booking_BookingDate ON Booking (BookingDate);

-- Non-clustered index on Vehicle_Brand
CREATE NONCLUSTERED INDEX idx_Vehicle_Brand ON Vehicle (Vehicle_Brand);

-- Non-clustered index on Maintenance_Date
CREATE NONCLUSTERED INDEX idx_Maintenance_Date ON Maintenance (Maintenance_Date);

-- Non-clustered index on Feedback Rating
CREATE NONCLUSTERED INDEX idx_Feedback_Rating ON Feedback (Rating);

-- Non-clustered index on Customer Driver License
CREATE NONCLUSTERED INDEX idx_Customer_License ON Customer (DriverLicenseNumber);


-- Usage to reduce search time
--1
SELECT *
FROM Booking
WHERE BookingDate BETWEEN '2023-01-01' AND '2023-03-11';

SELECT BookingID, BookingDate, TotalAmount
FROM Booking
ORDER BY BookingDate DESC;

--2
SELECT Vehicle_ID, Vehicle_Brand, Vehicle_Model, Year_of_Manufacturing
FROM Vehicle
WHERE Vehicle_Brand = 'Toyota';

SELECT Vehicle_ID, Vehicle_Brand, Vehicle_Model
FROM Vehicle
WHERE Vehicle_Brand = 'Ford' AND Year_of_Manufacturing >= 2017;

--3
SELECT Maintenance_ID, Maintenance_Type, Cost, Status
FROM Maintenance
WHERE Maintenance_Date BETWEEN '2023-01-01' AND '2024-12-31';

SELECT TOP 10 Maintenance_ID, Vehicle_ID, Maintenance_Date
FROM Maintenance
ORDER BY Maintenance_Date DESC;

--4
SELECT FeedbackID, CustomerID, Rating, Comments
FROM Feedback
WHERE Rating >= 4;

SELECT AVG(Rating) AS AverageRating
FROM Feedback
WHERE BookingID = 5;

--5
SELECT Customer_PersonID, DriverLicenseNumber, PreferredPaymentMethod
FROM Customer
WHERE DriverLicenseNumber = 'D1234567';

SELECT DriverLicenseNumber
FROM Customer
WHERE DriverLicenseNumber LIKE 'D%';