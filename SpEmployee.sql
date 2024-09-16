create database HRSystem;

use HRSystem

DROP Table Employees

CREATE TABLE SignIn (
    Id INT PRIMARY KEY IDENTITY(1,1),  -- Auto-incrementing ID column
    UserName NVARCHAR(100) NOT NULL,       -- Name column with a max length of 100 characters
    Password NVARCHAR(100) NOT NULL    -- Password column with a max length of 100 characters
);

insert into signin values('malik45','m123');
select * from signin;

CREATE TABLE Employees (
    EmpId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Department NVARCHAR(100),
    Position NVARCHAR(100),
    HireDate DATE,
    DateOfBirth DATE,
    EmployeeType NVARCHAR(50),
    Gender NVARCHAR(10),
    Salary DECIMAL(18,2),
    CNIC VARCHAR(14) ,  -- Ensures CNIC is 13-14 digits
    PhoneNumber VARCHAR(11)   -- Ensures PhoneNumber is exactly 11 digits
);

-- Inserting records into Employees table
INSERT INTO Employees (FullName, Email, Department, Position, HireDate, DateOfBirth, EmployeeType, Gender, Salary, CNIC, PhoneNumber)
VALUES
('Ahmed Khan', 'ahmed.khan@example.com', 'IT', 'Software Engineer', '2023-01-10', '1990-05-15', 'Full-Time', 'Male', 75000.00, '12345678901234', '03012345678'),

('Fatima Ali', 'fatima.ali@example.com', 'HR', 'HR Manager', '2022-03-25', '1988-08-22', 'Full-Time', 'Female', 80000.00, '12345678901234', '03123456789'),

('Omar Farooq', 'omar.farooq@example.com', 'Finance', 'Accountant', '2021-07-12', '1992-11-02', 'Part-Time', 'Male', 60000.00, '12345678901234', '03234567890'),

('Aisha Siddiqui', 'aisha.siddiqui@example.com', 'Marketing', 'Marketing Specialist', '2020-09-01', '1995-03-17', 'Full-Time', 'Female', 72000.00, '12345678901234', '03345678901'),

('Ali Rehman', 'ali.rehman@example.com', 'IT', 'System Analyst', '2023-05-15', '1991-04-25', 'Contract', 'Male', 68000.00, '12345678901234', '03456789012'),

('Zainab Tariq', 'zainab.tariq@example.com', 'Sales', 'Sales Executive', '2022-11-10', '1994-07-30', 'Full-Time', 'Female', 69000.00, '12345678901234', '03567890123'),

('Hassan Sheikh', 'hassan.sheikh@example.com', 'Operations', 'Operations Manager', '2021-12-01', '1989-10-12', 'Full-Time', 'Male', 85000.00, '12345678901234', '03678901234'),

('Maryam Khan', 'maryam.khan@example.com', 'Customer Support', 'Customer Support Representative', '2023-03-20', '1993-09-08', 'Part-Time', 'Female', 62000.00, '12345678901234', '03789012345'),

('Bilal Ahmed', 'bilal.ahmed@example.com', 'Legal', 'Legal Advisor', '2022-01-18', '1987-12-05', 'Full-Time', 'Male', 80000.00, '12345678901234', '03890123456'),

('Sara Qureshi', 'sara.qureshi@example.com', 'Training', 'Training Coordinator', '2021-06-14', '1996-02-20', 'Full-Time', 'Female', 70000.00, '12345678901234', '03901234567');

---------Employee SPS--------------
CREATE PROCEDURE GetAllEmployees
AS
BEGIN
    SELECT * FROM Employees;
END;


CREATE PROCEDURE InsertEmployee
    @FullName NVARCHAR(100),
    @Email NVARCHAR(100),
    @Department NVARCHAR(100),
    @Position NVARCHAR(100),
    @HireDate DATE,
    @DateOfBirth DATE,
    @EmployeeType NVARCHAR(50),
    @Gender NVARCHAR(10),
    @Salary DECIMAL(18,2),
    @CNIC VARCHAR(14),
    @PhoneNumber VARCHAR(11)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Employees (FullName, Email, Department, Position, HireDate, DateOfBirth, EmployeeType, Gender, Salary, CNIC, PhoneNumber)
    VALUES (@FullName, @Email, @Department, @Position, @HireDate, @DateOfBirth, @EmployeeType, @Gender, @Salary, @CNIC, @PhoneNumber);

    -- Return the newly inserted EmpId
    SELECT SCOPE_IDENTITY() AS EmpId;
END;


CREATE PROCEDURE GetEmployeeById
    @EmpId INT
AS
BEGIN
    -- Retrieve the employee details by EmpId
    SELECT * 
    FROM Employees
    WHERE EmpId = @EmpId;
END;

DROP PROCEDURE InsertEmployee;

---------------NEW TBS-----------
-- Create Department Table
CREATE TABLE Department (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);

-- Create Position Table
CREATE TABLE Position (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL
);

-- Create EmployeeType Table
CREATE TABLE EmployeeType (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Type NVARCHAR(100) NOT NULL
);


-- Insert Sample Data into Department Table
INSERT INTO Department (Name) VALUES ('Human Resources');
INSERT INTO Department (Name) VALUES ('Information Technology');
INSERT INTO Department (Name) VALUES ('Finance');
INSERT INTO Department (Name) VALUES ('Marketing');

-- Insert Sample Data into Position Table
INSERT INTO Position (Title) VALUES ('Manager');
INSERT INTO Position (Title) VALUES ('Team Lead');
INSERT INTO Position (Title) VALUES ('Senior Developer');
INSERT INTO Position (Title) VALUES ('Junior Developer');

-- Insert Sample Data into EmployeeType Table
INSERT INTO EmployeeType (Type) VALUES ('Full-Time');
INSERT INTO EmployeeType (Type) VALUES ('Part-Time');
INSERT INTO EmployeeType (Type) VALUES ('Contract');
INSERT INTO EmployeeType (Type) VALUES ('Intern');





-- ALL SPS ETC
CREATE PROCEDURE UpdateEmployee
    @EmpId INT,
    @FullName NVARCHAR(100),
    @Email NVARCHAR(100),
    @Department INT,
    @Position INT,
    @HireDate DATE,
    @DateOfBirth DATE,
    @EmployeeType INT,
    @Gender NVARCHAR(10),
    @Salary DECIMAL(18, 2),
    @CNIC NVARCHAR(20),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    UPDATE Employees
    SET 
        FullName = @FullName,
        Email = @Email,
        Department = @Department,
        Position = @Position,
        HireDate = @HireDate,
        DateOfBirth = @DateOfBirth,
        EmployeeType = @EmployeeType,
        Gender = @Gender,
        Salary = @Salary,
        CNIC = @CNIC,
        PhoneNumber = @PhoneNumber
    WHERE EmpId = @EmpId;
END;



CREATE PROCEDURE GetAllEmployees    
AS    
BEGIN    
    SELECT e.EmpId,e.FullName,e.Email,p.Title,D.Name,e.Gender,ET.Type from Employees e  
INNER JOIN Position p on p.Id = e.Position  
INNER JOIN Department D on D.Id = e.Department    
INNER JOIN EmployeeType ET on ET.Id = e.EmployeeType  
END;


CREATE PROCEDURE GetEmployeeById
    @EmpId INT
AS
BEGIN


    -- Retrieve the employee details by EmpId
    -- Revised stored procedure to retrieve employee details by EmpId
ALTER PROCEDURE GetEmployeeById
    @EmpId INT
AS
BEGIN
    -- Retrieve the employee details by EmpId
    SELECT 
        e.EmpId,
        e.FullName,
        e.Email,
        e.HireDate,
        e.DateOfBirth,
        e.Gender,
        e.Salary,
        e.CNIC,
        e.PhoneNumber,
        p.Title,
        D.Name,
        ET.Type
    FROM Employees e
    INNER JOIN Position p ON p.Id = e.Position
    INNER JOIN Department D ON D.Id = e.Department
    INNER JOIN EmployeeType ET ON ET.Id = e.EmployeeType
    WHERE e.EmpId = @EmpId;
END;

EXEC GetEmployeeById @EmpId = 1; -- Replace 1 with a valid employee ID


CREATE PROCEDURE DeleteEmployeeById
    @EmployeeId INT
AS
BEGIN
    -- Delete the employee record with the specified ID
    DELETE FROM Employees
    WHERE EmpId = @EmployeeId;
END;

