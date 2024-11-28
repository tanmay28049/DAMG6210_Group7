USE [CarRentalDatabase];
GO
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'CarRentalSystemMasterKey@DAMG6210';



-- Insert data into Address
INSERT INTO Address (Street, City, State, ZipCode, Country) VALUES
('123 Elm St', 'Springfield', 'IL', '62701', 'USA'),
('456 Maple Ave', 'Greenfield', 'WI', '53220', 'USA'),
('789 Oak Dr', 'Riverdale', 'NY', '10471', 'USA'),
('101 Pine Ln', 'Riverside', 'CA', '92501', 'USA'),
('202 Birch Blvd', 'Lakeland', 'FL', '33801', 'USA'),
('303 Cedar St', 'Madison', 'WI', '53703', 'USA'),
('404 Walnut Rd', 'Bloomington', 'IN', '47401', 'USA'),
('505 Chestnut Ave', 'Cambridge', 'MA', '02138', 'USA'),
('606 Spruce Dr', 'Evanston', 'IL', '60201', 'USA'),
('707 Redwood Blvd', 'Boulder', 'CO', '80302', 'USA');

-- Insert data into Branch
INSERT INTO Branch (BranchName, Location, PhoneNumber, Email, OpeningHours, AddressID) VALUES
('Central Branch', 'Downtown', '555-1234', 'central@carrental.com', '8am - 8pm', 1),
('North Branch', 'Northside', '555-2345', 'north@carrental.com', '8am - 8pm', 2),
('East Branch', 'East End', '555-3456', 'east@carrental.com', '8am - 8pm', 3),
('West Branch', 'Westside', '555-4567', 'west@carrental.com', '8am - 8pm', 4),
('South Branch', 'Southtown', '555-5678', 'south@carrental.com', '8am - 8pm', 5),
('Airport Branch', 'Near Airport', '555-6789', 'airport@carrental.com', '24/7', 6),
('Mall Branch', 'City Mall', '555-7890', 'mall@carrental.com', '10am - 10pm', 7),
('University Branch', 'Campus', '555-8901', 'university@carrental.com', '9am - 9pm', 8),
('Hotel Branch', 'Central Hotel', '555-9012', 'hotel@carrental.com', '24/7', 9),
('Station Branch', 'Train Station', '555-0123', 'station@carrental.com', '8am - 8pm', 10);

-- Insert data into Vehicle
INSERT INTO Vehicle (Vehicle_Type, Vehicle_Brand, Vehicle_Model, Year_of_Manufacturing, Licence_Plate, Fuel_Type, Drive_Type, BranchID) VALUES
('SED', 'Toyota', 'Camry', 2018, 'ABC123', 'Petrol', '2WD', 1),
('SUV', 'Ford', 'Explorer', 2019, 'XYZ789', 'Diesel', '4WD', 2),
('SED', 'Honda', 'Accord', 2020, 'DEF456', 'Petrol', '2WD', 3),
('SUV', 'Jeep', 'Cherokee', 2017, 'GHI101', 'Diesel', 'AWD', 4),
('SED', 'Nissan', 'Altima', 2021, 'JKL303', 'Electric', '2WD', 5),
('SUV', 'Toyota', 'Highlander', 2018, 'MNO505', 'Hybrid', '4WD', 6),
('SED', 'Ford', 'Fusion', 2019, 'PQR707', 'Petrol', '2WD', 7),
('SUV', 'Honda', 'Pilot', 2020, 'STU909', 'Diesel', 'AWD', 8),
('SED', 'Chevrolet', 'Malibu', 2017, 'VWX202', 'Electric', '2WD', 9),
('SUV', 'Hyundai', 'Santa Fe', 2018, 'YZA404', 'Hybrid', '4WD', 10);

-- Insert data into Sedan
INSERT INTO Sedan (Sedan_Vehicle_ID, Transmission_Type, Market_Audience) VALUES
(1, 'Automatic', 'Family'),
(3, 'Manual', 'Business'),
(5, 'Automatic', 'Economy'),
(7, 'Manual', 'Sports'),
(9, 'Automatic', 'Luxury');

-- Insert data into SUV
INSERT INTO SUV (SUV_Vehicle_ID, Seating_Capacity, Ground_Clearance) VALUES
(2, 7, 8.0),
(4, 5, 9.5),
(6, 8, 10.0),
(8, 7, 9.0),
(10, 5, 8.5);

-- Open the Symmetric Key
OPEN SYMMETRIC KEY CarRentalSystemColumnKey  
DECRYPTION BY CERTIFICATE CarRentalSystem;  
-- Insert data into Person
INSERT INTO Person (Person_Type, FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Email, Nationality, AddressID) VALUES
('EMP', 'John', 'Doe',  ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1985-07-12' AS VARCHAR)), 'M', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-1111'), 'john.doe@carrental.com', 'American', 1),
('CUS', 'Jane', 'Smith',  ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1990-11-25' AS VARCHAR)), 'F',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-2222') , 'jane.smith@gmail.com', 'American', 2),
('EMP', 'Mike', 'Brown',  ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1975-03-15' AS VARCHAR)), 'M', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-3333'), 'mike.brown@carrental.com', 'Canadian', 3),
('CUS', 'Emily', 'Davis',  ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1992-06-30' AS VARCHAR)), 'F',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-4444') , 'emily.davis@yahoo.com', 'British', 4),
('EMP', 'Sarah', 'Johnson', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1988-09-22' AS VARCHAR)) , 'F',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-5555') , 'sarah.johnson@carrental.com', 'Australian', 5),
('CUS', 'Chris', 'Lee', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1995-12-01'AS VARCHAR)) , 'M', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-6666'), 'chris.lee@hotmail.com', 'American', 6),
('EMP', 'Anna', 'White',  ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1982-02-18' AS VARCHAR)), 'F', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-7777'), 'anna.white@carrental.com', 'Canadian', 7),
('CUS', 'David', 'Martinez', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1989-05-10' AS VARCHAR)), 'M',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), '555-8888'), 'david.martinez@gmail.com', 'Mexican', 8),
('EMP', 'Mark', 'Wilson', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST( '1980-10-20' AS VARCHAR)), 'M',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-9999') , 'mark.wilson@carrental.com', 'American', 9),
('CUS', 'Sophia', 'Taylor', ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('1993-08-15' AS VARCHAR)), 'F',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'),'555-0000') , 'sophia.taylor@outlook.com', 'American', 10);


-- Insert data into Employee
INSERT INTO Employee (Employee_PersonID, JobTitle, Department, HireDate, Salary, EmployeeStatus, WorkShift, BranchID) VALUES
(1, 'Manager', 'Sales', '2015-05-01',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('60000' AS VARCHAR)), 'Active', 'Morning', 1),
(3, 'Sales Associate', 'Sales', '2016-07-15',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('40000' AS VARCHAR)) , 'Active', 'Afternoon', 2),
(5, 'Technician', 'Maintenance', '2017-03-20',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('45000' AS VARCHAR)) , 'On Leave', 'Night', 3),
(7, 'Receptionist', 'Front Desk', '2018-11-05',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('35000' AS VARCHAR)) , 'Active', 'Morning', 4),
(9, 'Supervisor', 'Sales', '2019-08-10',ENCRYPTBYKEY(KEY_GUID('CarRentalSystemColumnKey'), CAST('50000' AS VARCHAR)) , 'Inactive', 'Afternoon', 5);
-- Close the symmetric key
CLOSE SYMMETRIC KEY CarRentalSystemColumnKey;
CLOSE MASTER KEY;

-- Insert data into Customer with future LicenseExpiryDate values
INSERT INTO Customer (Customer_PersonID, LicenseExpiryDate, MembershipStartDate, MembershipEndDate, PreferredPaymentMethod, DriverLicenseNumber) VALUES
(2, '2025-07-12', '2022-01-01', '2022-12-31', 'Credit Card', 'D1234567'),
(4, '2024-12-25', '2022-01-01', '2022-12-31', 'Debit Card', 'E2345678'),
(6, '2026-12-01', '2022-01-01', '2022-12-31', 'Cash', 'F3456789'),
(8, '2026-05-10', '2022-01-01', '2022-12-31', 'Credit Card', 'G4567890'),
(10, '2025-08-15', '2022-01-01', '2022-12-31', 'Bank Transfer', 'H5678901');

-- Insert data into Insurance
INSERT INTO Insurance (Vehicle_ID, Insurance_Provider, Policy_Number, Start_Date, End_Date) VALUES
(1, 'State Farm', 'INS12345', '2022-01-01', '2023-01-01'),
(2, 'Geico', 'INS23456', '2022-01-01', '2023-01-01'),
(3, 'Progressive', 'INS34567', '2022-01-01', '2023-01-01'),
(4, 'Allstate', 'INS45678', '2022-01-01', '2023-01-01'),
(5, 'Liberty Mutual', 'INS56789', '2022-01-01', '2023-01-01'),
(6, 'Nationwide', 'INS67890', '2022-01-01', '2023-01-01'),
(7, 'Farmers', 'INS78901', '2022-01-01', '2023-01-01'),
(8, 'USAA', 'INS89012', '2022-01-01', '2023-01-01'),
(9, 'Travelers', 'INS90123', '2022-01-01', '2023-01-01'),
(10, 'American Family', 'INS01234', '2022-01-01', '2023-01-01');

-- Insert data into Maintenance
INSERT INTO Maintenance (Maintenance_Type, Maintenance_Date, Cost, Description, Status, Vehicle_ID) VALUES
('S', '2022-06-15', 120.00, 'Oil Change', 'Completed', 1),
('R', '2022-07-10', 350.00, 'Transmission Repair', 'Pending', 2),
('C', '2022-08-05', 80.00, 'Interior Cleaning', 'In Progress', 3),
('S', '2022-09-01', 150.00, 'Brake Replacement', 'Completed', 4),
('R', '2022-10-20', 200.00, 'Suspension Repair', 'Pending', 5),
('C', '2022-11-12', 90.00, 'Exterior Cleaning', 'Completed', 6),
('S', '2022-12-18', 130.00, 'Battery Replacement', 'In Progress', 7),
('R', '2023-01-08', 400.00, 'Engine Repair', 'Pending', 8),
('C', '2023-02-02', 75.00, 'Vacuuming', 'Completed', 9),
('S', '2023-03-11', 100.00, 'Tire Rotation', 'In Progress', 10);

-- Insert data into Booking
INSERT INTO Booking (BookingDate, StartDate, EndDate, TotalAmount, BookingStatus, EmployeeID, CustomerID, Vehicle_ID, Insurance_ID) VALUES
('2023-01-01', '2023-01-05', '2023-01-10', 500.00, 'Confirmed', 1, 2, 1, 1),
('2023-01-02', '2023-01-07', '2023-01-12', 750.00, 'Pending', 3, 4, 2, 2),
('2023-01-03', '2023-01-06', '2023-01-11', 600.00, 'Cancelled', 5, 6, 3, 3),
('2023-01-04', '2023-01-08', '2023-01-13', 800.00, 'Completed', 7, 8, 4, 4),
('2023-01-05', '2023-01-09', '2023-01-14', 550.00, 'Confirmed', 9, 10, 5, 5),
('2023-01-06', '2023-01-10', '2023-01-15', 650.00, 'Pending', 1, 2, 6, 6),
('2023-01-07', '2023-01-11', '2023-01-16', 720.00, 'Completed', 3, 4, 7, 7),
('2023-01-08', '2023-01-12', '2023-01-17', 460.00, 'Cancelled', 5, 6, 8, 8),
('2023-01-09', '2023-01-13', '2023-01-18', 570.00, 'Confirmed', 7, 8, 9, 9),
('2023-01-10', '2023-01-14', '2023-01-19', 620.00, 'Pending', 9, 10, 10, 10);

-- Insert data into Feedback
INSERT INTO Feedback (FeedbackDate, Rating, Comments, CustomerID, BookingID) VALUES
('2023-01-11', 5, 'Excellent service!', 2, 1),
('2023-01-12', 4, 'Good experience overall.', 4, 2),
('2023-01-13', 3, 'Average, could be better.', 6, 3),
('2023-01-14', 5, 'Loved the car and service.', 8, 4),
('2023-01-15', 2, 'Had some issues.', 10, 5),
('2023-01-16', 4, 'Smooth process and friendly staff.', 2, 6),
('2023-01-17', 5, 'Highly recommend!', 4, 7),
('2023-01-18', 3, 'Okay experience.', 6, 8),
('2023-01-19', 4, 'Satisfied with the rental.', 8, 9),
('2023-01-20', 1, 'Bad experience.', 10, 10);

-- Insert data into Vehicle Issue
INSERT INTO Vehicle_Issue (Vehicle_ID, Employee_ID, Cost_of_Repair, Issue_Description, Issue_Date) VALUES
(1, 1, 250.00, 'Engine overheating', '2022-12-01'),
(2, 3, 300.00, 'Brake issue', '2022-12-02'),
(3, 5, 150.00, 'Oil leak', '2022-12-03'),
(4, 7, 100.00, 'Battery replacement', '2022-12-04'),
(5, 9, 200.00, 'Transmission issue', '2022-12-05'),
(6, 1, 220.00, 'Suspension problem', '2022-12-06'),
(7, 3, 180.00, 'Alternator issue', '2022-12-07'),
(8, 5, 250.00, 'Cooling system issue', '2022-12-08'),
(9, 7, 130.00, 'Air conditioning repair', '2022-12-09'),
(10, 9, 270.00, 'Wheel alignment', '2022-12-10');

-- Insert data into Billing
INSERT INTO Billing (BillingDate, Amount, PaymentMethod, PaymentStatus, BookingID) VALUES
('2023-01-20', 500.00, 'Credit Card', 'Paid', 1),
('2023-01-21', 750.00, 'Debit Card', 'Pending', 2),
('2023-01-22', 600.00, 'Cash', 'Paid', 3),
('2023-01-23', 800.00, 'Bank Transfer', 'Overdue', 4),
('2023-01-24', 550.00, 'Credit Card', 'Paid', 5),
('2023-01-25', 650.00, 'Debit Card', 'Pending', 6),
('2023-01-26', 720.00, 'Cash', 'Paid', 7),
('2023-01-27', 460.00, 'Bank Transfer', 'Overdue', 8),
('2023-01-28', 570.00, 'Credit Card', 'Paid', 9),
('2023-01-29', 620.00, 'Debit Card', 'Pending', 10);

-- Insert data into Service
INSERT INTO Service (Service_Maintenance_ID, Service_Type, Frequency, Next_Service_Due) VALUES
(1, 'Oil Change', 3, '2023-04-01'),
(2, 'Brake Check', 6, '2023-07-01'),
(3, 'Tire Rotation', 12, '2023-12-01'),
(4, 'Battery Check', 6, '2023-07-01'),
(5, 'Coolant Replacement', 24, '2024-12-01'),
(6, 'Transmission Fluid Change', 24, '2024-12-01'),
(7, 'Air Filter Replacement', 12, '2023-12-01'),
(8, 'Cabin Filter Replacement', 12, '2023-12-01'),
(9, 'Spark Plug Replacement', 60, '2025-12-01'),
(10, 'Timing Belt Replacement', 100, '2027-12-01');

-- Insert data into Repair
INSERT INTO Repair (Repair_Maintenance_ID, Repair_Type, Issue_Description) VALUES
(2, 'Brake Repair', 'Brake pads replacement'),
(4, 'Battery Replacement', 'Battery malfunctioned'),
(5, 'Transmission Repair', 'Gear shifting issue'),
(6, 'Suspension Repair', 'Shock absorber replacement'),
(7, 'Alternator Repair', 'Battery not charging properly'),
(8, 'Cooling System Repair', 'Radiator leakage'),
(9, 'Air Conditioning Repair', 'Blower motor issue'),
(1, 'Engine Repair', 'Fix oil leakage'),
(3, 'Tire Repair', 'Wheel alignment'),
(10, 'Wheel Repair', 'Bent rim');

-- Insert data into Cleaning
INSERT INTO Cleaning (Cleaning_Maintenance_ID, Cleaning_Type, Cleaning_Staff_Assigned) VALUES
(3, 'Interior Cleaning', 'Alex Johnson'),
(6, 'Exterior Cleaning', 'Maria Davis'),
(1, 'Full Cleaning', 'Chris Brown'),
(8, 'Basic Cleaning', 'Jennifer Wilson'),
(9, 'Deep Cleaning', 'Steve Taylor'),
(10, 'Steam Cleaning', 'Emily White'),
(2, 'Seat Cleaning', 'Mark Brown'),
(5, 'Dashboard Cleaning', 'Anna Johnson'),
(7, 'Carpet Cleaning', 'David Clark'),
(4, 'Engine Bay Cleaning', 'Sophia King');


/*Query to the encrypted data*/
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'CarRentalSystemMasterKey@DAMG6210';
-- Open the Symmetric Key
OPEN SYMMETRIC KEY CarRentalSystemColumnKey  
DECRYPTION BY CERTIFICATE CarRentalSystem;  
 -- Decrypt the data
   SELECT 
    PersonID,
    Person_Type,
    FirstName,
    LastName,
    CAST(CAST(DECRYPTBYKEY(DateOfBirth) AS VARCHAR(50)) AS DATE) AS DateOfBirth,    -- Decrypt PhoneNumber and convert it to VARCHAR
    CAST(DECRYPTBYKEY(PhoneNumber) AS VARCHAR(50)) AS PhoneNumber,  
    Email,
    Nationality,
    AddressID
FROM Person;

SELECT 
    Employee_PersonID,
    JobTitle,
    Department,
    HireDate,
    CAST(CAST(DECRYPTBYKEY(Salary) AS VARCHAR(50)) AS DECIMAL(10, 2)) AS Salary,    
    EmployeeStatus,
    WorkShift,
    BranchID
FROM Employee;

CLOSE SYMMETRIC KEY CarRentalSystemColumnKey;
CLOSE MASTER KEY;




