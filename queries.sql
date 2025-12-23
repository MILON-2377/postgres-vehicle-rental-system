

-- Users Table
create type user_role as enum('admin', 'customer');
create table users (
  user_id bigint generated always as identity,
  name varchar(50) not null,
  email text unique not null,
  phone_number varchar(20) not null,
  password text not null,
  role user_role not null default 'customer',
  primary key(user_id)
);



-- Vehicles Table
create type vehicle_type as enum('car', 'bike', 'truck');
create type vehicle_availability as enum('available', 'rented', 'maintenance');
create table vehicles (
  vehicle_id bigint generated always as identity,
  name text not null,
  type vehicle_type not null default 'car',
  model int not null,
  registration_number text unique not null,
  daily_rate numeric(10, 2) not null,
  availability vehicle_availability not null default 'available',
  primary key(vehicle_id)
);



-- Bookings Table
create type booking_status as enum('pending', 'confirmed', 'completed', 'cancelled');
create table bookings (
  booking_id bigint generated always as identity,
  user_id bigint not null,
  vehicle_id bigint not null,
  start_date date not null,
  end_date date not null,
  total_amount numeric(10, 2) not null,
  status booking_status not null default 'pending',

  -- Primary Key
  primary key(booking_id),

  -- Foreign Key Constraints
  constraint fk_rentals_user foreign key(user_id)
  references users(user_id),
  constraint fk_rentals_vehicle foreign key(vehicle_id)
  references vehicles(vehicle_id)
  
);



-- Insert users (customers and admin)
INSERT INTO users (name, email, phone_number, password, role) VALUES
('John Smith', 'john.smith@email.com', '+1-555-0101', 'hashed_password_123', 'customer'),
('Emma Johnson', 'emma.j@email.com', '+1-555-0102', 'hashed_password_456', 'customer'),
('Michael Brown', 'michael.b@email.com', '+1-555-0103', 'hashed_password_789', 'customer'),
('Sarah Wilson', 'sarah.w@email.com', '+1-555-0104', 'hashed_password_101', 'customer'),
('Admin User', 'admin@vehiclerental.com', '+1-555-0000', 'admin_hashed_pass', 'admin'),
('David Lee', 'david.lee@email.com', '+1-555-0105', 'hashed_password_202', 'customer'),
('Lisa Taylor', 'lisa.t@email.com', '+1-555-0106', 'hashed_password_303', 'customer'),
('Robert Garcia', 'robert.g@email.com', '+1-555-0107', 'hashed_password_404', 'customer');



-- Insert vehicles
INSERT INTO vehicles (name, type, registration_number, daily_rate, availability) VALUES
('Toyota Camry 2023', 'car', 'ABC-1234', 45.00, 'available'),
('Honda Civic 2022', 'car', 'XYZ-5678', 40.00, 'available'),
('Ford F-150', 'truck', 'TRK-9012', 75.00, 'available'),
('Yamaha R15', 'bike', 'BIKE-3456', 25.00, 'available'),
('Tesla Model 3', 'car', 'TES-7890', 85.00, 'rented'),
('Harley Davidson', 'bike', 'HD-2023', 50.00, 'maintenance'),
('Chevrolet Tahoe', 'car', 'SUV-1122', 65.00, 'available'),
('Toyota Hilux', 'truck', 'TRK-3344', 70.00, 'available'),
('Suzuki Hayabusa', 'bike', 'BIKE-5566', 60.00, 'available'),
('BMW X5', 'car', 'BMW-7788', 95.00, 'available'),
('Honda Activa', 'bike', 'SCOOT-9900', 20.00, 'available'),
('Isuzu D-Max', 'truck', 'TRK-2233', 80.00, 'rented');
('Hyundai Creta', 'car', 2023, 'TS-06-KL-5566', 60.00, 'available'),
('Ashok Leyland Dost', 'truck', 2019, 'UP-07-MN-7788', 55.00, 'available'),
('TVS Apache RTR 160', 'bike', 2022, 'RJ-08-OP-9900', 25.00, 'rented'),
('Maruti Suzuki Swift', 'car', 2020, 'HR-09-QR-2233', 45.00, 'available'),
('Tata Ace', 'truck', 2021, 'WB-10-ST-4455', 50.00, 'maintenance');




-- Insert bookings
INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, total_amount, status) VALUES
(1, 1, '2024-01-15', '2024-01-17', 90.00, 'completed'),
(2, 5, '2024-01-20', '2024-01-25', 425.00, 'confirmed'),
(3, 4, '2024-01-10', '2024-01-12', 50.00, 'completed'),
(1, 3, '2024-01-18', '2024-01-20', 150.00, 'completed'),
(4, 2, '2024-01-22', '2024-01-24', 80.00, 'pending'),
(6, 8, '2024-01-25', '2024-01-28', 210.00, 'confirmed'),
(7, 9, '2024-01-14', '2024-01-16', 120.00, 'completed'),
(2, 12, '2024-01-26', '2024-02-01', 480.00, 'confirmed'),
(3, 7, '2024-01-19', '2024-01-21', 130.00, 'cancelled'),
(5, 10, '2024-01-23', '2024-01-25', 190.00, 'pending'),
(8, 11, '2024-01-27', '2024-01-29', 40.00, 'confirmed'),
(1, 6, '2024-02-01', '2024-02-03', 100.00, 'pending');
(2, 1, '2024-01-05', '2024-01-07', 90.00, 'completed'),
(3, 1, '2024-01-25', '2024-01-27', 90.00, 'completed'),
(4, 1, '2024-02-01', '2024-02-03', 90.00, 'confirmed'),
(5, 1, '2024-02-10', '2024-02-12', 90.00, 'pending'),
(1, 2, '2024-01-03', '2024-01-05', 80.00, 'completed'),
(6, 2, '2024-01-15', '2024-01-17', 80.00, 'completed'),
(7, 2, '2024-01-28', '2024-01-30', 80.00, 'confirmed'),
(2, 2, '2024-02-05', '2024-02-08', 120.00, 'pending'),
(8, 4, '2024-01-02', '2024-01-04', 50.00, 'completed'),
(5, 4, '2024-01-18', '2024-01-20', 50.00, 'completed'),
(3, 4, '2024-02-02', '2024-02-04', 50.00, 'confirmed'),
(6, 4, '2024-02-15', '2024-02-16', 25.00, 'pending'),
(4, 3, '2024-01-08', '2024-01-10', 150.00, 'completed'),
(7, 3, '2024-01-22', '2024-01-24', 150.00, 'completed'),
(1, 3, '2024-02-03', '2024-02-06', 225.00, 'confirmed'),
(2, 7, '2024-01-12', '2024-01-14', 130.00, 'completed'),
(8, 7, '2024-01-26', '2024-01-28', 130.00, 'completed'),
(4, 7, '2024-02-07', '2024-02-09', 130.00, 'pending'),
(3, 8, '2024-01-07', '2024-01-09', 140.00, 'completed'),
(5, 8, '2024-01-21', '2024-01-23', 140.00, 'completed'),
(6, 8, '2024-02-04', '2024-02-07', 210.00, 'confirmed'),
(7, 9, '2024-01-09', '2024-01-11', 120.00, 'completed'),
(1, 9, '2024-01-24', '2024-01-26', 120.00, 'completed'),
(2, 9, '2024-02-08', '2024-02-10', 120.00, 'pending'),
(4, 10, '2024-01-11', '2024-01-13', 190.00, 'completed'),
(8, 10, '2024-01-30', '2024-02-01', 190.00, 'completed'),
(3, 10, '2024-02-12', '2024-02-14', 190.00, 'confirmed'),
(5, 11, '2024-01-04', '2024-01-06', 40.00, 'completed'),
(6, 11, '2024-01-13', '2024-01-15', 40.00, 'completed'),
(7, 11, '2024-01-27', '2024-01-29', 40.00, 'completed'),
(1, 11, '2024-02-05', '2024-02-07', 40.00, 'confirmed'),
(2, 11, '2024-02-14', '2024-02-16', 40.00, 'pending'),
(3, 12, '2024-01-17', '2024-01-19', 160.00, 'completed'),
(4, 5, '2024-01-29', '2024-01-31', 170.00, 'completed'), 
(5, 6, '2024-02-11', '2024-02-13', 100.00, 'pending');




------------- Problems and Solutions Queries --------------

-- Retrieve booking information along with
-- customer name, vehicle name
select 
  b.booking_id, 
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
from users u
join bookings b on b.user_id = u.user_id
join vehicles v on v.vehicle_id = b.vehicle_id;



-- Find all vehicles that have never been booked.
select * from vehicles v
where not exists (
  select 1 from bookings b
  where b.vehicle_id = v.vehicle_id
);



-- Retrieve all available vehicles 
-- of a specific type (e.g. cars).
select * from vehicles
where type = 'car';



-- Find the total number of bookings 
-- for each vehicle and display only 
-- those vehicles that have more than 2 bookings.
select * from vehicles v
where v.vehicle_id in (
  select vehicle_id from bookings
  group by vehicle_id having count(booking_id) >= 2
);

