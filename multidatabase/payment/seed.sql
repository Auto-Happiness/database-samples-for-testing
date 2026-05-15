CREATE DATABASE payments_service;
GO

USE payments_service;
GO

CREATE TABLE payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    payment_reference VARCHAR(50) UNIQUE NOT NULL,
    order_number VARCHAR(20) NOT NULL,
    amount DECIMAL(18, 2) NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20) DEFAULT 'completed',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- Simple trigger for updated_at in MSSQL
CREATE TRIGGER trg_payments_UpdateTimestamp
ON payments
AFTER UPDATE
AS
BEGIN
    UPDATE payments
    SET updated_at = GETDATE()
    FROM payments
    INNER JOIN inserted ON payments.id = inserted.id
END;
GO

INSERT INTO payments (payment_reference, order_number, amount, payment_method) VALUES
('PAY-99001', 'ORD-1001', 1999.00, 'Credit Card'),
('PAY-99002', 'ORD-1002', 1998.00, 'PayPal'),
('PAY-99004', 'ORD-1004', 1599.00, 'Bank Transfer');
GO
