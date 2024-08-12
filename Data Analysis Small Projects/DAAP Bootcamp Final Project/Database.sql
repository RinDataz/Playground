create database daap;
USE DAAP;

SET FOREIGN_KEY_CHECKS=0; -- temo until we create the table

-- Create the hotels table
CREATE TABLE IF NOT EXISTS hotels (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_name VARCHAR(255)
);

-- Create the employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    job_id VARCHAR(255),
    salary DECIMAL(10, 2) NOT NULL 
);


-- Create the reservations table
CREATE TABLE IF NOT EXISTS reservations (
	reservation_id INT AUTO_INCREMENT PRIMARY KEY,
   hotel_name VARCHAR(255),
    is_canceled TINYINT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month VARCHAR(15),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children INT,
    babies INT,
    meal VARCHAR(50),
    country VARCHAR(50),
    market_segment VARCHAR(50),
    distribution_channel VARCHAR(50),
    is_repeated_guest TINYINT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type VARCHAR(10),
    assigned_room_type VARCHAR(10),
    booking_changes INT,
    deposit_type VARCHAR(50),
    agent VARCHAR(50),
    company VARCHAR(50),
    days_in_waiting_list INT,
    customer_type VARCHAR(50),
    adr DECIMAL(10, 2),
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status VARCHAR(50),
    reservation_status_date DATE,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(50),
    credit_card VARCHAR(20)
);

SET FOREIGN_KEY_CHECKS=1;
-- after creating the tables, the data inserts will be done via import wizard 

-- Verify data in the reservations table
SELECT * FROM reservations LIMIT 5;
-- Verify data in the employees table
SELECT * FROM employees;

-- Trigger on employees:
DELIMITER $$

CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    -- Remove non-numeric characters from phone_number
    SET NEW.phone_number = REGEXP_REPLACE(NEW.phone_number, '[^0-9]', '');
END$$

DELIMITER ;

-- test
-- Insert a new employee with a formatted phone number
INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES ('Jane', 'Smith', 'jane.smith@example.com', '(555) 123-4567', '2024-08-10', 'Developer', 65000.00);

-- Check the inserted data
SELECT * FROM employees where first_name='jane';
