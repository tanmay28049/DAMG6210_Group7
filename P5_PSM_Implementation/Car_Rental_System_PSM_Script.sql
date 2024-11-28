-- 4 STORED PROCEDURES

-- 1. Get Branch Details by City
CREATE PROCEDURE GetBranchDetailsByCity
    @City VARCHAR(50),
    @TotalBranches INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT BranchID, BranchName, PhoneNumber, Email
        FROM Branch b
        JOIN Address a ON b.AddressID = a.AddressID
        WHERE a.City = @City;

        SELECT @TotalBranches = COUNT(*)
        FROM Branch b
        JOIN Address a ON b.AddressID = a.AddressID
        WHERE a.City = @City;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO

-- 2. Get Booking Summary
CREATE PROCEDURE GetBookingSummary
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

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

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO


-- 3. Update Vehicle Maintenance Status
CREATE PROCEDURE UpdateMaintenanceStatus
    @MaintenanceID INT,
    @NewStatus VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Maintenance
        SET Status = @NewStatus
        WHERE Maintenance_ID = @MaintenanceID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO


-- 4. Calculate Total Revenue for a Branch
CREATE PROCEDURE CalculateBranchRevenue
    @BranchID INT,
    @TotalRevenue DECIMAL(10, 2) OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT @TotalRevenue = SUM(b.TotalAmount)
        FROM Booking b
        JOIN Vehicle v ON b.Vehicle_ID = v.Vehicle_ID
        WHERE v.BranchID = @BranchID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
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
EXEC GetBookingSummary 
    @StartDate = '2023-01-01',
    @EndDate = '2023-12-31';

--3
EXEC UpdateMaintenanceStatus
    @MaintenanceID = 3,
    @NewStatus = 'Completed';

--4
DECLARE @TotalRevenue DECIMAL(10, 2);

EXEC CalculateBranchRevenue 
    @BranchID = 1, 
    @TotalRevenue = @TotalRevenue OUTPUT;

SELECT @TotalRevenue AS TotalRevenueForBranch;


-- 8 VIEWS

-- 1. Vehicle Availability View
GO
CREATE VIEW VehicleAvailability AS
SELECT 
    v.Vehicle_ID, 
    v.Vehicle_Brand, 
    v.Vehicle_Model, 
    v.Licence_Plate, 
    b.BranchName AS Branch, 
    CASE 
        WHEN bk.Vehicle_ID IS NULL THEN 'Available' 
        ELSE 'Rented' 
    END AS Status
FROM Vehicle v
LEFT JOIN Booking bk 
    ON v.Vehicle_ID = bk.Vehicle_ID AND bk.BookingStatus = 'Confirmed'
JOIN Branch b 
    ON v.BranchID = b.BranchID;
GO

-- 2. Maintenance Overview
GO
CREATE VIEW MaintenanceOverview AS
SELECT 
    m.Maintenance_ID, 
    m.Maintenance_Type, 
    v.Vehicle_Brand, 
    v.Vehicle_Model, 
    v.Licence_Plate, 
    m.Maintenance_Date, 
    m.Cost AS MaintenanceCost, 
    m.Status
FROM Maintenance m
JOIN Vehicle v 
    ON m.Vehicle_ID = v.Vehicle_ID;
GO


-- 3. Customer Feedback View
GO
CREATE VIEW CustomerFeedback AS
SELECT 
    p.FirstName + ' ' + p.LastName AS CustomerName, 
    b.BranchName AS Branch, 
    f.Rating, 
    f.Comments, 
    bk.BookingDate
FROM Feedback f
JOIN Booking bk 
    ON f.BookingID = bk.BookingID
JOIN Customer c 
    ON f.CustomerID = c.Customer_PersonID
JOIN Person p 
    ON c.Customer_PersonID = p.PersonID
JOIN Vehicle v 
    ON bk.Vehicle_ID = v.Vehicle_ID
JOIN Branch b 
    ON v.BranchID = b.BranchID;
GO



-- 4. Revenue by Branch
GO
CREATE VIEW RevenueByBranch AS
SELECT 
    b.BranchName, 
    COUNT(bk.BookingID) AS TotalBookings, 
    SUM(bk.TotalAmount) AS TotalRevenue, 
    AVG(bk.TotalAmount) AS AverageRevenuePerBooking
FROM Branch b
JOIN Vehicle v 
    ON b.BranchID = v.BranchID
JOIN Booking bk 
    ON v.Vehicle_ID = bk.Vehicle_ID
WHERE bk.BookingStatus = 'Completed'
GROUP BY b.BranchName;
GO

-- 5 TopCustomersByRevenue
CREATE VIEW TopCustomersByRevenue AS
SELECT 
    p.FirstName + ' ' + p.LastName AS CustomerName, 
    COUNT(bk.BookingID) AS TotalBookings, 
    SUM(bk.TotalAmount) AS TotalRevenue
FROM Customer c
JOIN Person p 
    ON c.Customer_PersonID = p.PersonID
JOIN Booking bk 
    ON c.Customer_PersonID = bk.CustomerID
GROUP BY p.FirstName, p.LastName
GO

-- 6 MaintenanceCostsByVehicle
CREATE VIEW MaintenanceCostsByVehicle AS
SELECT 
    v.Vehicle_Brand, 
    v.Vehicle_Model, 
    v.Licence_Plate, 
    SUM(m.Cost) AS TotalMaintenanceCost, 
    COUNT(m.Maintenance_ID) AS TotalMaintenanceTasks
FROM Maintenance m
JOIN Vehicle v 
    ON m.Vehicle_ID = v.Vehicle_ID
GROUP BY v.Vehicle_Brand, v.Vehicle_Model, v.Licence_Plate
GO

-- 7 BookingTrends
CREATE VIEW BookingTrends AS
SELECT 
    YEAR(BookingDate) AS Year, 
    MONTH(BookingDate) AS Month, 
    COUNT(*) AS TotalBookings, 
    SUM(TotalAmount) AS TotalRevenue
FROM Booking
WHERE BookingStatus = 'Completed'
GROUP BY YEAR(BookingDate), MONTH(BookingDate)
GO

-- Using Views
GO
SELECT * FROM VehicleAvailability ORDER BY Status;
SELECT * FROM MaintenanceOverview ORDER BY Maintenance_Date DESC;;
SELECT * FROM CustomerFeedback ORDER BY Rating DESC;
SELECT * FROM RevenueByBranch ORDER BY TotalRevenue DESC;
SELECT * FROM TopCustomersByRevenue ORDER BY TotalRevenue DESC;
SELECT * FROM MaintenanceCostsByVehicle ORDER BY TotalMaintenanceCost DESC;
SELECT * FROM BookingTrends ORDER BY Year, Month;

/*Query to display all the Views*/
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
CREATE TABLE BookingLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT,
    LogDate DATETIME DEFAULT GETDATE(),
    Action NVARCHAR(100),
);
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
 
INSERT INTO Booking (BookingDate, StartDate, EndDate, TotalAmount, BookingStatus, EmployeeID, CustomerID, Vehicle_ID, Insurance_ID)
VALUES ('2024-01-10', '2024-01-20', '2024-01-25', 700.00, 'Confirmed', 5, 2, 8, 4);


SELECT * FROM DoubleBookingLog;