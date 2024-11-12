-- Create the new database
-- If the database exists, drop it
IF EXISTS (SELECT name
FROM sys.databases
WHERE name = N'CarRentalDatabase')
    DROP DATABASE CarRentalDatabase;
GO

CREATE DATABASE [CarRentalDatabase];
GO
USE [CarRentalDatabase];
GO

-- Drop tables if exists
IF OBJECT_ID('Cleaning', 'U') IS NOT NULL
    DROP TABLE Cleaning;
IF OBJECT_ID('Repair', 'U') IS NOT NULL
    DROP TABLE Repair;
IF OBJECT_ID('Service', 'U') IS NOT NULL
    DROP TABLE Service;
IF OBJECT_ID('Billing', 'U') IS NOT NULL
    DROP TABLE Billing;
IF OBJECT_ID('Maintenance', 'U') IS NOT NULL
    DROP TABLE Maintenance;
IF OBJECT_ID('Vehicle_Issue', 'U') IS NOT NULL
    DROP TABLE Vehicle_Issue;
IF OBJECT_ID('Feedback', 'U') IS NOT NULL
    DROP TABLE Feedback;
IF OBJECT_ID('Booking', 'U') IS NOT NULL
    DROP TABLE Booking;
IF OBJECT_ID('Customer', 'U') IS NOT NULL
    DROP TABLE Customer;
IF OBJECT_ID('Insurance', 'U') IS NOT NULL
    DROP TABLE Insurance;
IF OBJECT_ID('Employee', 'U') IS NOT NULL
    DROP TABLE Employee;
IF OBJECT_ID('Person', 'U') IS NOT NULL
    DROP TABLE Person;
IF OBJECT_ID('SUV', 'U') IS NOT NULL
    DROP TABLE SUV;
IF OBJECT_ID('Sedan', 'U') IS NOT NULL
    DROP TABLE Sedan;
IF OBJECT_ID('Vehicle', 'U') IS NOT NULL
    DROP TABLE Vehicle;
IF OBJECT_ID('Branch', 'U') IS NOT NULL
    DROP TABLE Branch;
IF OBJECT_ID('Address', 'U') IS NOT NULL
    DROP TABLE Address;

-- Create Address table
CREATE TABLE Address
(
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50),
    ZipCode VARCHAR(10) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

-- Create Branch table
CREATE TABLE Branch
(
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BranchName VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    OpeningHours VARCHAR(30),
    AddressID INT NOT NULL,
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Create Vehicle table
CREATE TABLE Vehicle
(
    Vehicle_ID INT PRIMARY KEY IDENTITY(1,1),
    Vehicle_Type CHAR(3) CHECK (Vehicle_Type IN ('SED', 'SUV')),
    Vehicle_Brand VARCHAR(100) NOT NULL,
    Vehicle_Model VARCHAR(100) NOT NULL,
    Year_of_Manufacturing INT NOT NULL,
    Licence_Plate VARCHAR(20) UNIQUE NOT NULL,
    Fuel_Type VARCHAR(20) CHECK (Fuel_Type IN ('Petrol', 'Diesel', 'Electric', 'Hybrid')),
    Drive_Type VARCHAR(20) CHECK (Drive_Type IN ('2WD', '4WD', 'AWD')),
    BranchID INT NOT NULL,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

-- Create Sedan table
CREATE TABLE Sedan
(
    Sedan_Vehicle_ID INT PRIMARY KEY,
    Transmission_Type VARCHAR(50) NOT NULL,
    Market_Audience VARCHAR(50),
    FOREIGN KEY (Sedan_Vehicle_ID) REFERENCES Vehicle(Vehicle_ID)
);

-- Create SUV table
CREATE TABLE SUV
(
    SUV_Vehicle_ID INT PRIMARY KEY,
    Seating_Capacity INT NOT NULL,
    Ground_Clearance DECIMAL(5, 2),
    FOREIGN KEY (SUV_Vehicle_ID) REFERENCES Vehicle(Vehicle_ID)
);

-- Create Person table
CREATE TABLE Person
(
    PersonID INT PRIMARY KEY IDENTITY(1,1),
    Person_Type CHAR(3) CHECK (Person_Type IN ('EMP', 'CUS')),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Nationality VARCHAR(50),
    AddressID INT NOT NULL,
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Create Employee table
CREATE TABLE Employee
(
    Employee_PersonID INT PRIMARY KEY,
    JobTitle VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    EmployeeStatus VARCHAR(20) CHECK (EmployeeStatus IN ('Active', 'Inactive', 'On Leave')),
    WorkShift VARCHAR(20),
    BranchID INT NOT NULL,
    FOREIGN KEY (Employee_PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

-- Create Customer table
CREATE TABLE Customer
(
    Customer_PersonID INT PRIMARY KEY,
    LicenseExpiryDate DATE NOT NULL CHECK (LicenseExpiryDate >= GETDATE()),
    MembershipStartDate DATE,
    MembershipEndDate DATE,
    PreferredPaymentMethod VARCHAR(50),
    DriverLicenseNumber VARCHAR(20) UNIQUE,
    FOREIGN KEY (Customer_PersonID) REFERENCES Person(PersonID)
);

-- Create Insurance table
CREATE TABLE Insurance
(
    Insurance_ID INT PRIMARY KEY IDENTITY(1,1),
    Vehicle_ID INT NOT NULL,
    Insurance_Provider VARCHAR(100) NOT NULL,
    Policy_Number VARCHAR(50) UNIQUE NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID)
);

-- Create Maintenance table
CREATE TABLE Maintenance
(
    Maintenance_ID INT PRIMARY KEY IDENTITY(1,1),
    Maintenance_Type CHAR(1) CHECK (Maintenance_Type IN ('S', 'R', 'C')),
    Maintenance_Date DATE NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    Description VARCHAR(255),
    Status VARCHAR(50) CHECK (Status IN ('Pending', 'Completed', 'In Progress')),
    Vehicle_ID INT NOT NULL,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID)
);

-- Create Booking table
CREATE TABLE Booking
(
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    BookingDate DATE NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    BookingStatus VARCHAR(20) CHECK (BookingStatus IN ('Pending', 'Confirmed', 'Cancelled', 'Completed')),
    EmployeeID INT NOT NULL,
    CustomerID INT NOT NULL,
    Vehicle_ID INT NOT NULL,
    Insurance_ID INT NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(Employee_PersonID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(Customer_PersonID),
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID),
    FOREIGN KEY (Insurance_ID) REFERENCES Insurance(Insurance_ID)
);

-- Create Feedback table
CREATE TABLE Feedback
(
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    FeedbackDate DATE NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR(255),
    CustomerID INT NOT NULL,
    BookingID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(Customer_PersonID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

-- Create Vehicle Issue table
CREATE TABLE Vehicle_Issue
(
    Vehicle_Issue_ID INT PRIMARY KEY IDENTITY(1,1),
    Vehicle_ID INT NOT NULL,
    Employee_ID INT NOT NULL,
    Cost_of_Repair DECIMAL(10, 2) NOT NULL,
    Issue_Description VARCHAR(255),
    Issue_Date DATE NOT NULL,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_PersonID)
);

-- Create Billing table
CREATE TABLE Billing
(
    BillingID INT PRIMARY KEY IDENTITY(1,1),
    BillingDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'Cash', 'Bank Transfer')),
    PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Paid', 'Pending', 'Overdue')),
    BookingID INT NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

-- Create Service table
CREATE TABLE Service
(
    Service_Maintenance_ID INT PRIMARY KEY,
    Service_Type VARCHAR(100) NOT NULL,
    Frequency INT NOT NULL,
    Next_Service_Due DATE,
    FOREIGN KEY (Service_Maintenance_ID) REFERENCES Maintenance(Maintenance_ID)
);

-- Create Repair table 
CREATE TABLE Repair
(
    Repair_Maintenance_ID INT PRIMARY KEY,
    Repair_Type VARCHAR(100) NOT NULL,
    Issue_Description VARCHAR(255),
    FOREIGN KEY (Repair_Maintenance_ID) REFERENCES Maintenance(Maintenance_ID)
);

-- Create Cleaning table 
CREATE TABLE Cleaning
(
    Cleaning_Maintenance_ID INT PRIMARY KEY,
    Cleaning_Type VARCHAR(100) NOT NULL,
    Cleaning_Staff_Assigned VARCHAR(100),
    FOREIGN KEY (Cleaning_Maintenance_ID) REFERENCES Maintenance(Maintenance_ID)
);
