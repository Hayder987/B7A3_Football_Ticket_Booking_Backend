

# ⚽ Football Ticket Booking Backend

A simplified and high-performance relational database design and SQL query solution for a **Football Ticket Booking System**. This project showcases entity-relationship management, complex standard database joins, subqueries, safe null-handling, data encapsulation constraints, and core relational integrity patterns.

---

## 📌 Project Overview & Objectives

The primary objective of this system is to manage logistics and operations for football fans purchasing tickets for upcoming major tournament matches. It bridges administrative management with customer workflows securely by handling:
* **User roles** (Ticket Managers and Football Fans).
* **Match status matrices** (Available, Selling Fast, Sold Out, Postponed).
* **Strict relational mapping** preventing double-booking overlaps of identical seats in specific fixtures.

---

## 📊 Database Architecture & ERD

The database schema architecture consists of 3 core operational entities: `Users`, `Matches`, and `Bookings`. 

### 🔗 Relationship Metrics
* **One-to-Many (`Users` → `Bookings`):** A single football fan can buy multiple match tickets throughout the season.
* **Many-to-One (`Bookings` → `Matches`):** A single high-demand derby match can be linked to thousands of transactional ticket sales.
* **One-to-One (Logical Isolation):** Every single transaction row inside the `Bookings` table maps exactly **one user** to **one match** for a specific physical seat allocation, avoiding multi-tenant collisions.

📌 **Official Project ERD Link:** [View Diagram on Google Drive](https://drive.google.com/file/d/1KbUpjLREfPoc83Vfbd59pC3ffSc7zqmL/view?usp=sharing)

📌 **Assignment Requirement Link:** [View Requirement](https://github.com/Apollo-Level2-Web-Dev/B7A3)

---

## 🛠️ Database Schema Implementation (PostgreSQL)

```sql
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

-- 3. Create Bookings Table (Junction Table)
CREATE TABLE IF NOT EXISTS Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    match_id int NOT NULL,
    seat_number VARCHAR(20) NULL, 
    payment_status VARCHAR(50) NULL CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_match FOREIGN KEY (match_id) REFERENCES Matches(match_id) ON DELETE CASCADE,

    CONSTRAINT unique_user_match_seat UNIQUE (user_id, match_id, seat_number)
);

## 👨‍💻 Developer & Author Profile

| Criteria | Developer Details |
| :--- | :--- |
| **Name** | Md. Hayder Ali |
| **Email** | [hayderbd4290@gmail.com](mailto:hayderbd4290@gmail.com) |
| **Phone / WhatsApp** | [+8801771814597](https://wa.me/8801771814597) |
| **Platform Track** | Level 2 Web Development (Backend Track) |

---

### 🌐 Let's Connect!
* **Email:** Feel free to reach out for architectural discussions or code reviews.
* **WhatsApp:** Available for urgent workspace collaborations or query fixes.

