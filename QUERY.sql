
-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS

DROP TABLE IF EXISTS Bookings CASCADE;
DROP TABLE IF EXISTS Matches CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

-- 1. Create Users Table
CREATE TABLE IF NOT EXISTS Users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(20) 
);

-- 2. Create Matches Table
CREATE TABLE IF NOT EXISTS Matches (
    match_id SERIAL PRIMARY KEY,
    fixture VARCHAR(80) NOT NULL,
    tournament_category VARCHAR(60) NOT NULL,
    base_ticket_price DECIMAL(10, 2) NOT NULL,
    match_status VARCHAR(40) NOT NULL CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- 3. Create Bookings Table 
CREATE TABLE IF NOT EXISTS Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    match_id INT NOT NULL,
    seat_number VARCHAR(20),
    payment_status VARCHAR(50) NULL CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_match FOREIGN KEY (match_id) REFERENCES Matches(match_id) ON DELETE CASCADE,
    
    CONSTRAINT unique_match_seat UNIQUE (match_id, seat_number)
);