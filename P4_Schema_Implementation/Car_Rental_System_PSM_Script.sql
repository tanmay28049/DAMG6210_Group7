-- 5 STORED PROCEDURES

-- 1. Get Branch Details by City
CREATE PROCEDURE GetBranchDetailsByCity
    @City VARCHAR(50),
    @TotalBranches INT OUTPUT
AS
BEGIN
    SELECT BranchID, BranchName, PhoneNumber, Email
    FROM Branch b
    JOIN Address a ON b.AddressID = a.AddressID
    WHERE a.City = @City;

    SELECT @TotalBranches = COUNT(*)
    FROM Branch b
    JOIN Address a ON b.AddressID = a.AddressID
    WHERE a.City = @City;
END;
GO

-- 2. Add a New Customer
CREATE PROCEDURE AddCustomer
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DOB DATE,
    @Gender CHAR(1),
    @Phone VARCHAR(15),
    @Email VARCHAR(100),
    @AddressID INT,
    @LicenseExpiryDate DATE,
    @DriverLicenseNumber VARCHAR(20)
AS
BEGIN
    DECLARE @PersonID INT;

    INSERT INTO Person (Person_Type, FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Email, AddressID)
    VALUES ('CUS', @FirstName, @LastName, @DOB, @Gender, @Phone, @Email, @AddressID);

    SET @PersonID = SCOPE_IDENTITY();

    INSERT INTO Customer (Customer_PersonID, LicenseExpiryDate, DriverLicenseNumber)
    VALUES (@PersonID, @LicenseExpiryDate, @DriverLicenseNumber);
END;
GO

-- 3. Get Booking Summary
CREATE PROCEDURE GetBookingSummary
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        b.BookingID, 
        b.BookingDate, 
        p.FirstName + ' ' + p.LastName AS CustomerName, 
        v.Vehicle_Model, 
        b.TotalAmount
    FROM Booking b
    JOIN Customer c ON b.CustomerID = c.Customer_PersonID
    JOIN Person p ON c.Customer_PersonID = p.PersonID
    JOIN Vehicle v ON b.Vehicle_ID = v.Vehicle_ID
    WHERE b.BookingDate BETWEEN @StartDate AND @EndDate;
END;
GO

-- 4. Update Vehicle Maintenance Status
CREATE PROCEDURE UpdateMaintenanceStatus
    @MaintenanceID INT,
    @NewStatus VARCHAR(50)
AS
BEGIN
    UPDATE Maintenance
    SET Status = @NewStatus
    WHERE Maintenance_ID = @MaintenanceID;
END;
GO

-- 5. Calculate Total Revenue for a Branch
CREATE PROCEDURE CalculateBranchRevenue
    @BranchID INT,
    @TotalRevenue DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalRevenue = SUM(b.TotalAmount)
    FROM Booking b
    JOIN Vehicle v ON b.Vehicle_ID = v.Vehicle_ID
    WHERE v.BranchID = @BranchID;
END;
GO


-- Executing Stored Procedures
--1
DECLARE @TotalBranches INT;

EXEC GetBranchDetailsByCity 
    @City = 'Springfield', 
    @TotalBranches = @TotalBranches OUTPUT;

SELECT @TotalBranches AS TotalBranchesInCity;

--2
EXEC AddCustomer
    @FirstName = 'Alice',
    @LastName = 'Johnson',
    @DOB = '1995-05-15',
    @Gender = 'F',
    @Phone = '555-1234',
    @Email = 'alice.johnson@gmail.com',
    @AddressID = 1,
    @LicenseExpiryDate = '2025-12-31',
    @DriverLicenseNumber = 'A9876543';

--3
EXEC GetBookingSummary 
    @StartDate = '2023-01-01',
    @EndDate = '2023-12-31';

--4
EXEC UpdateMaintenanceStatus
    @MaintenanceID = 3,
    @NewStatus = 'Completed';

--5
DECLARE @TotalRevenue DECIMAL(10, 2);

EXEC CalculateBranchRevenue 
    @BranchID = 1, 
    @TotalRevenue = @TotalRevenue OUTPUT;

SELECT @TotalRevenue AS TotalRevenueForBranch;


-- 5 VIEWS

-- 1. Vehicle Availability View
GO
CREATE VIEW VehicleAvailability AS
SELECT 
    v.Vehicle_ID, v.Vehicle_Brand, v.Vehicle_Model, v.Licence_Plate, 
    CASE WHEN bk.Vehicle_ID IS NULL THEN 'Available' ELSE 'Rented' END AS Status
FROM Vehicle v
LEFT JOIN Booking bk ON v.Vehicle_ID = bk.Vehicle_ID AND bk.BookingStatus = 'Confirmed';

-- 2. Employee Summary
GO
CREATE VIEW EmployeeSummary AS
SELECT 
    e.Employee_PersonID, p.FirstName, p.LastName, e.JobTitle, e.Department, e.Salary
FROM Employee e
JOIN Person p ON e.Employee_PersonID = p.PersonID;

-- 3. Maintenance Overview
GO
CREATE VIEW MaintenanceOverview AS
SELECT 
    m.Maintenance_ID, m.Maintenance_Type, v.Vehicle_Brand, v.Vehicle_Model, m.Maintenance_Date, m.Status
FROM Maintenance m
JOIN Vehicle v ON m.Vehicle_ID = v.Vehicle_ID;

-- 4. Customer Feedback View
GO
CREATE VIEW CustomerFeedback AS
SELECT 
    p.FirstName + ' ' + p.LastName AS CustomerName, 
    f.Rating, 
    f.Comments
FROM Feedback f
JOIN Customer c ON f.CustomerID = c.Customer_PersonID
JOIN Person p ON c.Customer_PersonID = p.PersonID;


-- 5. Revenue by Branch
GO
CREATE VIEW RevenueByBranch AS
SELECT 
    b.BranchName, SUM(bk.TotalAmount) AS TotalRevenue
FROM Branch b
JOIN Vehicle v ON b.BranchID = v.BranchID
JOIN Booking bk ON v.Vehicle_ID = bk.Vehicle_ID
GROUP BY b.BranchName;


-- Using Views
GO
SELECT * FROM VehicleAvailability;
SELECT * FROM EmployeeSummary;
SELECT * FROM MaintenanceOverview;
SELECT * FROM CustomerFeedback;
SELECT * FROM RevenueByBranch;

SELECT 
    TABLE_NAME AS ViewName
FROM INFORMATION_SCHEMA.VIEWS;


-- USER DEFINED FUNCTIONS (UDF)
-- 1. Get Vehicle Utilization Rate
GO
CREATE FUNCTION GetVehicleUtilization(@VehicleID INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @UtilizationRate DECIMAL(5,2);

    SELECT @UtilizationRate = 
        (CAST(COUNT(*) AS DECIMAL(5,2)) / (DATEDIFF(DAY, MIN(BookingDate), MAX(EndDate)) + 1)) * 100
    FROM Booking
    WHERE Vehicle_ID = @VehicleID;

    RETURN @UtilizationRate;
END;

-- 2. Calculate Booking Duration
GO
CREATE FUNCTION CalculateBookingDuration(@BookingID INT)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT DATEDIFF(DAY, StartDate, EndDate)
        FROM Booking
        WHERE BookingID = @BookingID
    );
END;

-- 3. Get Feedback Count for Customer
GO
CREATE FUNCTION GetFeedbackCount(@CustomerID INT)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM Feedback
        WHERE CustomerID = @CustomerID
    );
END;

-- 4. Calculate Total Maintenance Cost
GO
CREATE FUNCTION GetTotalMaintenanceCost(@VehicleID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN (
        SELECT SUM(Cost)
        FROM Maintenance
        WHERE Vehicle_ID = @VehicleID
    );
END;

-- 5. Get Average Feedback Rating
GO
CREATE FUNCTION GetAverageFeedbackRating()
RETURNS DECIMAL(3, 2)
AS
BEGIN
    RETURN (
        SELECT AVG(CAST(Rating AS DECIMAL(3, 2)))
        FROM Feedback
    );
END;

-- Using UDFs
-- Usage: Calculate the utilization rate for Vehicle_ID = 1
GO
SELECT dbo.GetVehicleUtilization(1) AS VehicleUtilizationRate;

-- Usage: Calculate the duration for BookingID = 3
SELECT dbo.CalculateBookingDuration(3) AS BookingDurationDays;

-- Usage: Get the feedback count for CustomerID = 4
SELECT dbo.GetFeedbackCount(4) AS FeedbackCount;

-- Usage: Calculate total maintenance cost for Vehicle_ID = 2
SELECT dbo.GetTotalMaintenanceCost(2) AS TotalMaintenanceCost;

-- Usage: Retrieve the average feedback rating
SELECT dbo.GetAverageFeedbackRating() AS AverageFeedbackRating;



-- 3 TRIGGERS
--1
GO
CREATE TRIGGER trg_LogBookingStatusChange
ON Booking
AFTER UPDATE
AS
BEGIN
    -- Log status changes only
    INSERT INTO BookingLog (BookingID, LogDate, Action)
    SELECT i.BookingID, GETDATE(), 'Status changed to: ' + i.BookingStatus
    FROM Inserted i
    JOIN Deleted d ON i.BookingID = d.BookingID
    WHERE i.BookingStatus <> d.BookingStatus; -- Check if status has changed
END;

--2
GO
CREATE TRIGGER trg_RecordVehicleIssue
ON Booking
AFTER UPDATE
AS
BEGIN
    -- Log vehicle issue when booking status changes to "Completed" or "Cancelled"
    INSERT INTO VehicleIssueLog (VehicleID, BookingID, IssueReported)
    SELECT i.Vehicle_ID, i.BookingID, 'Check for potential issues after booking status update'
    FROM Inserted i
    WHERE i.BookingStatus IN ('Completed', 'Cancelled');
END;

--3
GO
CREATE TRIGGER trg_NotifyDoubleBookingAttempt
ON Booking
FOR INSERT
AS
BEGIN
    -- Log double booking attempts
    INSERT INTO DoubleBookingLog (VehicleID, AttemptedBookingID, ConflictingBookingID, LoggedBy)
    SELECT i.Vehicle_ID, i.BookingID, b.BookingID, SYSTEM_USER
    FROM Inserted i
    JOIN Booking b ON i.Vehicle_ID = b.Vehicle_ID
    WHERE i.StartDate < b.EndDate AND i.EndDate > b.StartDate;
END;


-- Using Triggers
--1 
CREATE TABLE BookingLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT,
    LogDate DATETIME DEFAULT GETDATE(),
    Action NVARCHAR(100),
);

UPDATE Booking
SET BookingStatus = 'Completed'
WHERE BookingID = 1;

SELECT * FROM BookingLog;

--2 
CREATE TABLE VehicleIssueLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    VehicleID INT,
    BookingID INT,
    IssueReported NVARCHAR(100),
    LogDate DATETIME DEFAULT GETDATE()
);

UPDATE Booking
SET BookingStatus = 'Completed'
WHERE BookingID = 1;

SELECT * FROM VehicleIssueLog;

--3
CREATE TABLE DoubleBookingLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    VehicleID INT,
    AttemptedBookingID INT,
    ConflictingBookingID INT,
    LogDate DATETIME DEFAULT GETDATE(),
    LoggedBy NVARCHAR(100)
);

INSERT INTO Booking (BookingDate, StartDate, EndDate, TotalAmount, BookingStatus, EmployeeID, CustomerID, Vehicle_ID, Insurance_ID)
VALUES ('2024-01-10', '2024-01-20', '2024-01-25', 700.00, 'Confirmed', 5, 2, 8, 4);

SELECT * FROM DoubleBookingLog;













