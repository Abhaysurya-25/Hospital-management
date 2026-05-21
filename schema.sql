CREATE DATABASE hospital_management;
USE hospital_management;

-- USER TABLE
CREATE TABLE User (
    EmployeeID INT PRIMARY KEY,
    Type VARCHAR(50),
    Name VARCHAR(100),
    Email VARCHAR(100),
    Password VARCHAR(100),
    Pass_iv VARCHAR(100)
);

-- FRONT DESK OPERATOR
CREATE TABLE Front_desk_operator (
    EmployeeID INT PRIMARY KEY,
    Address VARCHAR(255),
    FOREIGN KEY (EmployeeID) REFERENCES User(EmployeeID)
);

-- DATA ENTRY OPERATOR
CREATE TABLE Data_entry_operator (
    EmployeeID INT PRIMARY KEY,
    Address VARCHAR(255),
    FOREIGN KEY (EmployeeID) REFERENCES User(EmployeeID)
);

-- DATABASE ADMINISTRATOR
CREATE TABLE Database_administrator (
    EmployeeID INT PRIMARY KEY,
    Address VARCHAR(255),
    FOREIGN KEY (EmployeeID) REFERENCES User(EmployeeID)
);

-- PHYSICIAN
CREATE TABLE Physician (
    PhysicianID INT PRIMARY KEY,
    Position VARCHAR(100),
    FOREIGN KEY (PhysicianID) REFERENCES User(EmployeeID)
);

-- DEPARTMENT
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    Head INT,
    Dep_Name VARCHAR(100),
    FOREIGN KEY (Head) REFERENCES Physician(PhysicianID)
);

-- AFFILIATED WITH
CREATE TABLE Affiliated_with (
    PhysicianID INT,
    DepartmentID INT,
    PRIMARY KEY (PhysicianID, DepartmentID),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- PATIENT
CREATE TABLE Patient (
    Patient_SSN INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Address VARCHAR(255),
    Age INT,
    Gender VARCHAR(10),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Status VARCHAR(50),
    InsuranceID VARCHAR(100)
);

-- SLOT
CREATE TABLE Slot (
    SlotID INT PRIMARY KEY AUTO_INCREMENT,
    Start TIME,
    End TIME
);

-- APPOINTMENT
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_SSN INT,
    PhysicianID INT,
    SlotID INT,
    Date DATE,
    FOREIGN KEY (Patient_SSN) REFERENCES Patient(Patient_SSN),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID),
    FOREIGN KEY (SlotID) REFERENCES Slot(SlotID)
);

-- TREATMENT DESCRIPTION
CREATE TABLE Treatment_Description (
    Treatment_DescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    Desc_Name VARCHAR(255),
    Cost DECIMAL(10,2)
);

-- TREATMENT
CREATE TABLE Treatment (
    TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_SSN INT,
    Treatment_DescriptionID INT,
    PhysicianID INT,
    SlotID INT,
    Date DATE,
    FOREIGN KEY (Patient_SSN) REFERENCES Patient(Patient_SSN),
    FOREIGN KEY (Treatment_DescriptionID) REFERENCES Treatment_Description(Treatment_DescriptionID),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID),
    FOREIGN KEY (SlotID) REFERENCES Slot(SlotID)
);

-- ROOM
CREATE TABLE Room (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    Unavailable BOOLEAN,
    Room_type VARCHAR(100)
);

-- STAY
CREATE TABLE Stay (
    StayID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_SSN INT,
    RoomID INT,
    Start DATE,
    End DATE,
    FOREIGN KEY (Patient_SSN) REFERENCES Patient(Patient_SSN),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

-- TEST
CREATE TABLE Test (
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    Test_Name VARCHAR(100),
    Cost DECIMAL(10,2)
);

-- TEST INSTANCE
CREATE TABLE Test_instance (
    Test_instanceID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_SSN INT,
    PhysicianID INT,
    TestID INT,
    SlotID INT,
    Result TEXT,
    Test_image VARCHAR(255),
    Date DATE,
    FOREIGN KEY (Patient_SSN) REFERENCES Patient(Patient_SSN),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID),
    FOREIGN KEY (TestID) REFERENCES Test(TestID),
    FOREIGN KEY (SlotID) REFERENCES Slot(SlotID)
);

-- MEDICATION
CREATE TABLE Medication (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    Medication_Name VARCHAR(100),
    Brand VARCHAR(100),
    Description TEXT
);

-- PRESCRIBES MEDICATION
CREATE TABLE Prescribes_Medication (
    PhysicianID INT,
    Patient_SSN INT,
    MedicationID INT,
    Date DATE,
    AppointmentID INT,
    Dose VARCHAR(100),
    PRIMARY KEY (PhysicianID, Patient_SSN, MedicationID, Date),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID),
    FOREIGN KEY (Patient_SSN) REFERENCES Patient(Patient_SSN),
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);