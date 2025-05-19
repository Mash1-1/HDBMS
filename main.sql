CREATE TABLE Patient (
PatientID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
DOB DATE NOT NULL,
Gender ENUM('Male', 'Female', 'Other') NOT NULL,
PhoneNumber VARCHAR(15),
Address TEXT
);

CREATE TABLE Department(
DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
DepName VARCHAR(100) NOT NULL,
DepartmentHeadID INT

);

CREATE TABLE DepartmentHead(
DepartmentHeadID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
DepartmentID INT NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Doctor(
DoctorID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Specialty VARCHAR(100),
DepartmentID INT,
ContactNumber VARCHAR(15),
Email VARCHAR(100),
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Appointment(
AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
PatientID INT NOT NULL,
DoctorID INT NOT NULL,
DateAndTime DATETIME NOT NULL,
Diagnosis TEXT,
Status VARCHAR(50),
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Referral(
ReferralID INT PRIMARY KEY AUTO_INCREMENT,
AppointmentID INT NOT NULL,
ReferredToDoctorID INT NOT NULL,
ReferDoctorID INT NOT NULL,
ReferredPatientID INT NOT NULL,
DateOfReferral DATE NOT NULL,
Reason TEXT,
FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
FOREIGN KEY (ReferredToDoctorID) REFERENCES Doctor(DoctorID),
FOREIGN KEY (ReferDoctorID) REFERENCES Doctor(DoctorID),
FOREIGN KEY (ReferredPatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Prescription(
PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
AppointmentID INT NOT NULL,
DoctorID INT NOT NULL,
PatientID INT NOT NULL,
PrescriptionDate DATE NOT NULL,
MedicineName VARCHAR(100) NOT NULL,
Notes TEXT,
FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE LabTest(
LabTestID INT PRIMARY KEY AUTO_INCREMENT,
Diagnosis TEXT,
LTDate DATE NOT NULL,
LTType VARCHAR(100) NOT NULL,
PatientID INT NOT NULL,
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Billing(
BillID INT PRIMARY KEY AUTO_INCREMENT,
PatientID INT NOT NULL,
Amount DECIMAL(10, 2) NOT NULL CHECK (Amount > 0),
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

INSERT INTO Patient (FirstName, LastName, DOB, Gender, PhoneNumber, Address)
VALUES ('Mahder', 'Ashenafi', '2005-01-01', 'Male', '+251912345678', 'Addis Ababa');

INSERT INTO Department (DepName) VALUES ('Cardiology'), ('Neurology');

INSERT INTO DepartmentHead (FirstName, LastName, DepartmentID) VALUES
('Mussie', 'Bekele', 1);

INSERT INTO Doctor (FirstName, LastName, Specialty, DepartmentID, ContactNumber, Email)
VALUES ('Mera', 'Abayneh', 'Cardiologist', 1, '+251911112222', 'jdoe@hospital.et');

INSERT INTO Appointment (PatientID, DoctorID, DateAndTime, Diagnosis, Status)
VALUES (1, 1, '2025-05-20 09:00:00', 'High blood pressure', 'Scheduled');

INSERT INTO Referral (AppointmentID, ReferredToDoctorID, ReferDoctorID, ReferredPatientID, DateOfReferral, Reason)
VALUES (1, 1, 1, 1, '2025-05-20', 'Further examination');

INSERT INTO Prescription (AppointmentID, DoctorID, PatientID, PrescriptionDate, MedicineName, Notes)
VALUES (1, 1, 1, '2025-05-20', 'Amlodipine', 'Take once daily');

INSERT INTO LabTest (Diagnosis, LTDate, LTType, PatientID)
VALUES ('Blood Test Required', '2025-05-20', 'CBC', 1);

INSERT INTO Billing (PatientID, Amount)
VALUES (1, 1200.00);

UPDATE Patient SET Gender = 'female' WHERE PatientID = 1;
SELECT * from DepartmentHead;
SELECT * from Patient;
SELECT * from Appointment;
SELECT * from Prescription;
SELECT * from Billing;

INSERT INTO Patient (FirstName, LastName, DOB, Gender, PhoneNumber, Address)
VALUES ('Abebe', 'Kebede', '2005-01-01', 'Male', '+251912345678', 'Addis Ababa');

SELECT * from Patient;

delete from Patient WHERE PatientID = 2;

SELECT * from Patient;

SELECT * from Department;

UPDATE Department SET DepartmentHeadID = (SELECT DepartmentHeadID FROM DepartmentHead WHERE DepartmentID =DepartmentHead.DepartmentID) WHERE DepartmentID = 1;
UPDATE Department SET DepartmentHeadID = (SELECT DepartmentHeadID FROM DepartmentHead WHERE DepartmentID =DepartmentHead.DepartmentID) WHERE DepartmentID = 2;
SELECT * from Department;
