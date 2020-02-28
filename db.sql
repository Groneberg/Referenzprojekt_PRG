DROP DATABASE IF EXISTS Organizer;

CREATE DATABASE Organizer CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE Organizer;

DROP TABLE IF EXISTS User;

CREATE TABLE User (
	U_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
	U_EMail VARCHAR(50) NOT NULL UNIQUE,
	U_PW VARCHAR(50)
);

DROP TABLE IF EXISTS Contact;

CREATE TABLE Contact (
	C_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
	U_ID INTEGER,
	C_FName VARCHAR(50),
	C_LName VARCHAR(50),
	C_Title VARCHAR(50),
	C_Label VARCHAR(50),
	C_EMail VARCHAR(50),
	C_Phone VARCHAR(20),
	C_Address VARCHAR(50),
	C_Location VARCHAR(50),
	C_Zip VARCHAR (5),
	UNIQUE KEY unique_index_contact (C_FName,C_LName,C_EMail,C_Phone,C_Address)
);

DROP TABLE IF EXISTS Appointment;

CREATE TABLE Appointment (
	A_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
	U_ID INTEGER,
	A_Event VARCHAR(255),
	A_Note TEXT,
	A_Beginning VARCHAR(50),
	A_Ending VARCHAR(50),
	A_Duration VARCHAR(50)
);

DROP PROCEDURE IF EXISTS p_create_appointment;

DELIMITER // 
CREATE PROCEDURE p_create_appointment ( appointment_u_id INTEGER, appointment_event VARCHAR(255), appointment_note TEXT, appointment_beginning VARCHAR(50), appointment_ending VARCHAR(50), appointment_duration VARCHAR(50))
BEGIN
	DECLARE beginning VARCHAR(50);
	SELECT A_Beginning FROM Appointment WHERE A_Beginning IN (appointment_beginning) INTO beginning;
	IF (beginning IS NULL) THEN INSERT INTO Appointment (`U_ID`, `A_Event`, `A_Note`, `A_Beginning`, `A_Ending`, `A_Duration`) VALUES (appointment_u_id, appointment_event, appointment_note, appointment_beginning, appointment_ending, appointment_duration);
	END IF;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS p_create_contact;

DELIMITER // 
CREATE PROCEDURE p_create_contact ( contact_id INTEGER, contact_u_id INTEGER, contact_firstname VARCHAR(50), contact_lastname VARCHAR(50), contact_title VARCHAR(50), contact_label VARCHAR(50), contact_email VARCHAR(50), contact_phone VARCHAR(50), contact_address VARCHAR(50), contact_location VARCHAR(50), contact_zip VARCHAR(5))
BEGIN
	DECLARE id INTEGER;
	SELECT C_ID FROM Contact WHERE C_ID IN (contact_id) INTO id;
	IF (id IS NULL) THEN INSERT INTO Contact (`U_ID`, `C_FName`, `C_LName`, `C_Title`, `C_Label`, `C_EMail`, `C_Phone`, `C_Address`, `C_Location`, `C_Zip`) VALUES ( contact_u_id, contact_firstname, contact_lastname, contact_title, contact_label, contact_email, contact_phone, contact_address, contact_location, contact_zip);
	END IF;
END //
DELIMITER ;




