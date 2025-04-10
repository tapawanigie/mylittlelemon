CREATE DATABASE IF NOT EXISTS mylittle_lemon;
USE mylittle_lemon;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    BookingDate DATE,
    BookingTime TIME,
    NumberOfGuests INT,
    BookingStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE MenuItems (
    MenuItemID INT AUTO_INCREMENT PRIMARY KEY,
    ItemName VARCHAR(100),
    Price DECIMAL(10,2),
    Category VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT,
    MenuItemID INT,
    Quantity INT,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (MenuItemID) REFERENCES MenuItems(MenuItemID)
);
