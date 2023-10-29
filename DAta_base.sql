CREATE DATABASE my_db;
CREATE SCHEMA my_schema;

CREATE TABLE my_db.users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Female', 'Male')),
    birthdate DATE CHECK (birthdate > '2004-08-15'),
    record_ts DATE DEFAULT current_date
);

CREATE TABLE my_db.measurements (
    measurement_id SERIAL PRIMARY KEY,
    user_id INT,
    measured_value DECIMAL NOT NULL CHECK (measured_value >= 0),
    UNIQUE (measurement_id),
    FOREIGN KEY (user_id) REFERENCES my_db.users(user_id),
    record_ts DATE DEFAULT current_date
);

ALTER TABLE my_db.users ADD COLUMN full_name VARCHAR(255) GENERATED ALWAYS AS (username || ' Smith') STORED;

INSERT INTO my_db.users (username, gender, birthdate) VALUES
('Alice', 'Female', '2004-08-12'),
('Bob', 'Male', '1995-11-10');

INSERT INTO my_db.measurements (user_id, measured_value) VALUES
(1, 65.2),
(2, 70.5);

ALTER TABLE my_db.users ADD COLUMN record_ts DATE DEFAULT current_date;
ALTER TABLE my_db.measurements ADD COLUMN record_ts DATE DEFAULT current_date;

SELECT * FROM my_db.users;
SELECT * FROM my_db.measurements;