DELIMITER //

-- Most ordered item
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MenuItems.ItemName, SUM(Orders.Quantity) AS TotalOrdered
    FROM Orders
    JOIN MenuItems ON Orders.MenuItemID = MenuItems.MenuItemID
    GROUP BY MenuItems.ItemName
    ORDER BY TotalOrdered DESC
    LIMIT 1;
END //

-- Add a new booking
CREATE PROCEDURE AddBooking(
    IN p_CustomerID INT,
    IN p_BookingDate DATE,
    IN p_BookingTime TIME,
    IN p_NumberOfGuests INT,
    IN p_BookingStatus VARCHAR(20)
)
BEGIN
    INSERT INTO Bookings (CustomerID, BookingDate, BookingTime, NumberOfGuests, BookingStatus)
    VALUES (p_CustomerID, p_BookingDate, p_BookingTime, p_NumberOfGuests, p_BookingStatus);
END //

-- Update existing booking
CREATE PROCEDURE UpdateBooking(
    IN p_BookingID INT,
    IN p_BookingDate DATE,
    IN p_BookingTime TIME,
    IN p_NumberOfGuests INT,
    IN p_BookingStatus VARCHAR(20)
)
BEGIN
    UPDATE Bookings
    SET BookingDate = p_BookingDate,
        BookingTime = p_BookingTime,
        NumberOfGuests = p_NumberOfGuests,
        BookingStatus = p_BookingStatus
    WHERE BookingID = p_BookingID;
END //

-- Cancel a booking
CREATE PROCEDURE CancelBooking(
    IN p_BookingID INT
)
BEGIN
    DELETE FROM Bookings WHERE BookingID = p_BookingID;
END //

-- Manage booking (insert if new, update if exists)
CREATE PROCEDURE ManageBooking(
    IN p_CustomerID INT,
    IN p_BookingDate DATE,
    IN p_BookingTime TIME,
    IN p_NumberOfGuests INT
)
BEGIN
    DECLARE existing INT;

    SELECT COUNT(*) INTO existing
    FROM Bookings
    WHERE CustomerID = p_CustomerID AND BookingDate = p_BookingDate;

    IF existing > 0 THEN
        UPDATE Bookings
        SET BookingTime = p_BookingTime,
            NumberOfGuests = p_NumberOfGuests
        WHERE CustomerID = p_CustomerID AND BookingDate = p_BookingDate;
    ELSE
        INSERT INTO Bookings (CustomerID, BookingDate, BookingTime, NumberOfGuests, BookingStatus)
        VALUES (p_CustomerID, p_BookingDate, p_BookingTime, p_NumberOfGuests, 'Confirmed');
    END IF;
END //

DELIMITER ;
