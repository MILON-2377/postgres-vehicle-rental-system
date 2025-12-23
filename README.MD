
# Vehicle Rental System

This project is a vehicle rental management system that allows customers to book various types of vehicles such as cars, bikes, and trucks. Admin users can manage bookings, users, and vehicles, while customers can view available vehicles and make bookings.

## Features


- **User Management**:
    - Customer and admin user roles.
    - Admin can manage users and their roles.

- **Vehicle Management**:
    - Admin can add, update, and delete Vehicles.
    - Vehicles have attributes like type, model, registration number, daily rate, and availability.

- **Booking System**:
    - Customers can book available vehicles.
    - Admin can view and manage bookings (pending, confirmed, completed, and cancelled).
    - Vehicles' availability is updated based on booking status.

## Technologies Used

- **PostgreSQL**: 
    - For managing data, including users,   vehicles, and bookings.


### Database Schema


### Users Table


The 'users' table contains customer and admin information.


```sql
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

```


### Vehicles Table


The 'vehicles' table stores information about the vehicles for rental



```sql
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

```

### Bookings Table


The 'bookings' table keeps track of vehicle bookings made by customers.


```sql
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
```



### Database Queries



### Retrive Booking Information
 

This query retrieves booking details along with the customer and vehicle names.


```sql
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
```


### Find all vehicles that have never been booked

```sql
select * from vehicles v
where not exists (
  select 1 from bookings b
  where b.vehicle_id = v.vehicle_id
);
```




### Retrive available vehicles of specific type


This query retrieves all available vehicles of specific type (car)


```sql
select * from vehicles
where type = 'car';
```


### Find vehicles with more than 2 bookings

This query returns all vehicles that have more than 2 bookings

```sql
select * from vehicles v
where v.vehicle_id in (
  select vehicle_id from bookings
  group by vehicle_id having count(booking_id) >= 2
);
```


### Installation


- **PostgreSQL database**:
    - Install and setup PostgreSQL on your machine.

- **Database Setup**:
    - Create the vehicle_rental database and run the schema SQL file to create tables and relationships.



### Steps to Set Up:
    1. Clone the repository or set up the database manually.
    2. Import provided SQL schema to create the necessary tables and types in your PostgreSQL database.
    3. Configure the database connection in your environment