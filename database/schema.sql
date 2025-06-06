-- Based on our ERD diagram, the following is the detailed rundown of the diagram:
--              Entity-Relationship Diagram (ERD) for VGU Care Database
-- Entities:
-- 1. Users:
--    - user_id (UUID, Primary Key)
--    - name (VARCHAR, Not Null)
--    - gender (VARCHAR, Not Null)
--    - age (INT, Not Null)
--    - role (ENUM: 'student', 'medical_staff', 'admin', Not Null)
--    - email (VARCHAR, Unique, Not Null) 
--    - password_hash (VARCHAR, Not Null)
--    - status (ENUM: 'active', 'inactive', 'banned', Not Null)
--    - points (INT, Not Null) <-- This is intended to track user points for behavioral incentives

-- A User HAS MANY Appointments.

-- 2. Appointments:
--    - appointment_id (UUID, Primary key) 
--    - user_id (UUID, Foreign Key referencing Users)
--    - status (ENUM: 'scheduled', 'completed', 'cancelled', Not Null)
--    - date_requested (TIMESTAMP, Not Null)
--    - date_scheduled (TIMESTAMP, Null)
--    - priorty_level (ENUM: 'low', 'medium', 'high', Not Null)
--    - symptoms (TEXT, Not Null)

-- An Appointment MIGHT HAVE a TemporaryAdvice

-- 3. TemporaryAdvice:
--    - advice_id (UUID, Primary Key)
--    - appointment_id (UUID, Foreign Key referencing Appointments)
--    - message (TEXT, Not Null)
--    - date_sent (TIMESTAMP, Not Null)

-- A User IS A student OR a Medical Staff OR an Admin. 

-- 4. Student:
--    - student_id (UUID, Primary Key)
--    - user_id (UUID, Foreign Key referencing Users)
--    - intake_year (INT, Not Null)
--    - major (VARCHAR, Not Null)

-- A Student can SUBMIT many HealthDocuments.

-- 5. HealthDocument:
--    - document_id (UUID, Primary Key)
--    - student_id (UUID, Foreign Key referencing Student)
--    - document_type (ENUM: 'medical_report', 'vaccination_record', 'health_certificate', Not Null)
--    - symptoms_description (TEXT, Not Null)
--    - date_submitted (TIMESTAMP, Not Null)
--    - other_details (TEXT, Null)

-- A Students can SUBMIT many MoodEntrys. <-- MoodEntry is a record of the student's mood and well-being. Aimed to help with mental health tracking.

-- 6. MoodEntry:
--    - entry_id (UUID, Primary Key)
--    - student_id (UUID, Foreign Key referencing Student)
--    - mood (ENUM: 'happy', 'sad', 'neutral', 'anxious', 'stressed', Not Null)
--    - entry_date (TIMESTAMP, Not Null)
--    - notes (TEXT, Null)

-- A MedicalStaff can ACCESS Students' HealthDocuments and MoodEntrys.

-- 7. MedicalStaff:
--    - staff_id (UUID, Primary Key)
--    - user_id (UUID, Foreign Key referencing Users)
--    - specialty (VARCHAR, Not Null)

-- A MedicalStaff can CREATE many AbuseReports. <-- AbuseReport is a report of any abuse or misconduct on the web app observed by the medical staff.

-- 8. AbuseReport:
--    - report_id (UUID, Primary Key)
--    - staff_id (UUID, Foreign Key referencing MedicalStaff)
--    - student_id (UUID, Not NULL) <-- To links the report to a student 
--    - report_date (TIMESTAMP, Not Null)
--    - description (TEXT, Not Null)
--    - status (ENUM: 'open', 'investigating', 'resolved', Not Null)

-- 9. Admin:
--    - admin_id (UUID, Primary Key)
--    - user_id (UUID, Foreign Key referencing Users)

-- VGU Care Database Schema - Complete Implementation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table (base entity)
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    gender VARCHAR(20) CHECK (gender IN ('male', 'female', 'other')) NOT NULL,
    age INT NOT NULL CHECK (age > 0),
    role VARCHAR(20) CHECK (role IN ('student', 'medical_staff', 'admin')) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('active', 'inactive', 'banned')) NOT NULL DEFAULT 'active',
    points INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Students table
CREATE TABLE students (
    student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    intake_year INT NOT NULL,
    major VARCHAR(100) NOT NULL
);

-- Medical Staff table
CREATE TABLE medical_staff (
    staff_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    specialty VARCHAR(100) NOT NULL
);

-- Admin table
CREATE TABLE admins (
    admin_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE
);

-- Appointments table
CREATE TABLE appointments (
    appointment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    status VARCHAR(20) CHECK (status IN ('scheduled', 'completed', 'cancelled')) NOT NULL DEFAULT 'scheduled',
    date_requested TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_scheduled TIMESTAMP NULL,
    priority_level VARCHAR(10) CHECK (priority_level IN ('low', 'medium', 'high')) NOT NULL,
    symptoms TEXT NOT NULL
);

-- Temporary Advice table
CREATE TABLE temporary_advice (
    advice_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    appointment_id UUID NOT NULL REFERENCES appointments(appointment_id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    date_sent TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Health Documents table
CREATE TABLE health_documents (
    document_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    document_type VARCHAR(30) CHECK (document_type IN ('medical_report', 'vaccination_record', 'health_certificate')) NOT NULL,
    symptoms_description TEXT NOT NULL,
    date_submitted TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    other_details TEXT NULL
);

-- Mood Entry table
CREATE TABLE mood_entries (
    entry_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    mood VARCHAR(20) CHECK (mood IN ('happy', 'sad', 'neutral', 'anxious', 'stressed')) NOT NULL,
    entry_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes TEXT NULL
);

-- Abuse Reports table
CREATE TABLE abuse_reports (
    report_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    staff_id UUID NOT NULL REFERENCES medical_staff(staff_id) ON DELETE CASCADE,
    student_id UUID REFERENCES students(student_id) ON DELETE SET NULL,
    report_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description TEXT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('open', 'investigating', 'resolved')) NOT NULL DEFAULT 'open'
);

-- Dummy Data (10 users: 7 students, 2 medical staff, 1 admin)

-- Insert Users
INSERT INTO users (name, gender, age, role, email, password_hash, status, points) VALUES
-- Students (7)
('Nguyen Van A', 'male', 20, 'student', 'student1@vgu.edu.vn', '$2a$10$sample_hash_1', 'active', 150),
('Tran Thi B', 'female', 21, 'student', 'student2@vgu.edu.vn', '$2a$10$sample_hash_2', 'active', 200),
('Le Van C', 'male', 19, 'student', 'student3@vgu.edu.vn', '$2a$10$sample_hash_3', 'active', 75),
('Pham Thi D', 'female', 22, 'student', 'student4@vgu.edu.vn', '$2a$10$sample_hash_4', 'active', 300),
('Hoang Van E', 'male', 20, 'student', 'student5@vgu.edu.vn', '$2a$10$sample_hash_5', 'active', 125),
('Vu Thi F', 'female', 21, 'student', 'student6@vgu.edu.vn', '$2a$10$sample_hash_6', 'inactive', 50),
('Do Van G', 'male', 23, 'student', 'student7@vgu.edu.vn', '$2a$10$sample_hash_7', 'active', 175),

-- Medical Staff (2)
('Dr. Nguyen Thi H', 'female', 35, 'medical_staff', 'doctor1@vgu.edu.vn', '$2a$10$sample_hash_8', 'active', 0),
('Dr. Tran Van I', 'male', 42, 'medical_staff', 'doctor2@vgu.edu.vn', '$2a$10$sample_hash_9', 'active', 0),

-- Admin (1)
('Admin User', 'other', 30, 'admin', 'admin@vgu.edu.vn', '$2a$10$sample_hash_10', 'active', 0);

-- Insert Students (get user_ids for students)
INSERT INTO students (user_id, intake_year, major)
SELECT u.user_id, 
       CASE 
           WHEN u.email = 'student1@vgu.edu.vn' THEN 2023
           WHEN u.email = 'student2@vgu.edu.vn' THEN 2022
           WHEN u.email = 'student3@vgu.edu.vn' THEN 2024
           WHEN u.email = 'student4@vgu.edu.vn' THEN 2021
           WHEN u.email = 'student5@vgu.edu.vn' THEN 2023
           WHEN u.email = 'student6@vgu.edu.vn' THEN 2022
           WHEN u.email = 'student7@vgu.edu.vn' THEN 2020
       END as intake_year,
       CASE 
           WHEN u.email = 'student1@vgu.edu.vn' THEN 'Computer Science'
           WHEN u.email = 'student2@vgu.edu.vn' THEN 'Business Administration'
           WHEN u.email = 'student3@vgu.edu.vn' THEN 'Engineering'
           WHEN u.email = 'student4@vgu.edu.vn' THEN 'Medicine'
           WHEN u.email = 'student5@vgu.edu.vn' THEN 'International Relations'
           WHEN u.email = 'student6@vgu.edu.vn' THEN 'Economics'
           WHEN u.email = 'student7@vgu.edu.vn' THEN 'Psychology'
       END as major
FROM users u WHERE u.role = 'student';

-- Insert Medical Staff
INSERT INTO medical_staff (user_id, specialty)
SELECT u.user_id,
       CASE 
           WHEN u.email = 'doctor1@vgu.edu.vn' THEN 'General Medicine'
           WHEN u.email = 'doctor2@vgu.edu.vn' THEN 'Psychology'
       END as specialty
FROM users u WHERE u.role = 'medical_staff';

-- Insert Admin
INSERT INTO admins (user_id)
SELECT user_id FROM users WHERE role = 'admin';

-- Sample appointments
INSERT INTO appointments (user_id, priority_level, symptoms, date_scheduled)
SELECT s.user_id, 'medium', 'Headache and fever', CURRENT_TIMESTAMP + INTERVAL '2 days'
FROM students s LIMIT 3;

-- Sample mood entries
INSERT INTO mood_entries (student_id, mood, notes)
SELECT s.student_id, 'happy', 'Feeling great today!'
FROM students s LIMIT 2;