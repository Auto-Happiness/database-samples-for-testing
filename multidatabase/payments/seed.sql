-- Revamped Payments Database Schema and Seed Data for MySQL

-- 1. Create Tables
CREATE TABLE payment_method (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    code VARCHAR(20) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE invoice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    tax_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    issued_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    due_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'unpaid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    payment_method_id INT NOT NULL,
    transaction_reference VARCHAR(100) UNIQUE NOT NULL,
    amount_paid DECIMAL(12,2) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'completed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (invoice_id) REFERENCES invoice(id) ON DELETE CASCADE,
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(id) ON DELETE RESTRICT
);

-- Create Indexes for performance
CREATE INDEX idx_payment_method_code ON payment_method(code);
CREATE INDEX idx_invoice_order ON invoice(order_id);
CREATE INDEX idx_invoice_customer ON invoice(customer_id);
CREATE INDEX idx_invoice_status ON invoice(status);
CREATE INDEX idx_payments_invoice ON payments(invoice_id);
CREATE INDEX idx_payments_method ON payments(payment_method_id);
CREATE INDEX idx_payments_date ON payments(payment_date);

-- 2. Seed Data
-- Seed payment_method (20 records)
INSERT INTO payment_method (id, name, code, is_active) VALUES
(1, 'Credit Card', 'credit_card', true),
(2, 'Debit Card', 'debit_card', true),
(3, 'PayPal', 'paypal', true),
(4, 'Apple Pay', 'apple_pay', true),
(5, 'Google Pay', 'google_pay', true),
(6, 'Bank Transfer', 'bank_transfer', true),
(7, 'Wire Transfer', 'wire_transfer', true),
(8, 'Cash on Delivery', 'cod', true),
(9, 'Amazon Pay', 'amazon_pay', true),
(10, 'Venmo', 'venmo', true),
(11, 'Stripe Checkout', 'stripe', true),
(12, 'Shopify Pay', 'shopify_pay', true),
(13, 'Klarna Financing', 'klarna', true),
(14, 'Afterpay Installments', 'afterpay', true),
(15, 'Affirm Loans', 'affirm', true),
(16, 'Bitcoin Core', 'bitcoin', true),
(17, 'Ethereum Chain', 'ethereum', true),
(18, 'Bank Check', 'check', true),
(19, 'Store Gift Card', 'gift_card', true),
(20, 'Internal Store Credit', 'store_credit', true);

-- Seed invoice (37 records, matching 37 orders and customer IDs from order database)
INSERT INTO invoice (id, invoice_number, order_id, customer_id, amount, tax_amount, issued_date, due_date, status) VALUES
-- Customer 1 (10 invoices)
(1, 'INV-2026-0001', 1, 1, 999.00, 79.92, '2026-01-15 10:30:00', '2026-01-30 17:00:00', 'paid'),
(2, 'INV-2026-0002', 2, 1, 45.00, 3.60, '2026-02-02 14:15:00', '2026-02-17 17:00:00', 'paid'),
(3, 'INV-2026-0003', 3, 1, 33.98, 2.72, '2026-02-18 09:00:00', '2026-03-05 17:00:00', 'paid'),
(4, 'INV-2026-0004', 4, 1, 16.99, 1.36, '2026-03-05 16:45:00', '2026-03-20 17:00:00', 'paid'),
(5, 'INV-2026-0005', 5, 1, 49.00, 3.92, '2026-03-22 11:20:00', '2026-04-06 17:00:00', 'paid'),
(6, 'INV-2026-0006', 6, 1, 66.00, 5.28, '2026-04-10 13:10:00', '2026-04-25 17:00:00', 'paid'),
(7, 'INV-2026-0007', 7, 1, 39.99, 3.20, '2026-04-25 15:30:00', '2026-05-10 17:00:00', 'paid'),
(8, 'INV-2026-0008', 8, 1, 89.00, 7.12, '2026-05-02 10:00:00', '2026-05-17 17:00:00', 'paid'),
(9, 'INV-2026-0009', 9, 1, 15.99, 1.28, '2026-05-12 17:05:00', '2026-05-27 17:00:00', 'unpaid'),
(10, 'INV-2026-0010', 10, 1, 14.99, 1.20, '2026-05-19 14:30:00', '2026-06-03 17:00:00', 'unpaid'),

-- Customer 2 (3 invoices)
(11, 'INV-2026-0011', 11, 2, 90.00, 7.20, '2026-02-10 11:00:00', '2026-02-25 17:00:00', 'paid'),
(12, 'INV-2026-0012', 12, 2, 70.00, 5.60, '2026-03-15 15:20:00', '2026-03-30 17:00:00', 'paid'),
(13, 'INV-2026-0013', 13, 2, 180.00, 14.40, '2026-04-28 09:40:00', '2026-05-13 17:00:00', 'paid'),

-- Customer 3 (3 invoices)
(14, 'INV-2026-0014', 14, 3, 16.99, 1.36, '2026-01-20 14:50:00', '2026-02-04 17:00:00', 'paid'),
(15, 'INV-2026-0015', 15, 3, 32.45, 2.60, '2026-03-01 10:15:00', '2026-03-16 17:00:00', 'paid'),
(16, 'INV-2026-0016', 16, 3, 69.99, 5.60, '2026-05-05 11:10:00', '2026-05-20 17:00:00', 'paid'),

-- Customer 5 (3 invoices)
(17, 'INV-2026-0017', 17, 5, 2997.00, 239.76, '2026-02-25 09:30:00', '2026-03-12 17:00:00', 'paid'),
(18, 'INV-2026-0018', 18, 5, 69.99, 5.60, '2026-04-05 13:00:00', '2026-04-20 17:00:00', 'paid'),
(19, 'INV-2026-0019', 19, 5, 229.00, 18.32, '2026-05-14 16:15:00', '2026-05-29 17:00:00', 'unpaid'),

-- Customer 10 (3 invoices)
(20, 'INV-2026-0020', 20, 10, 18.50, 1.48, '2026-03-10 10:45:00', '2026-03-25 17:00:00', 'paid'),
(21, 'INV-2026-0021', 21, 10, 37.00, 2.96, '2026-04-18 14:00:00', '2026-05-03 17:00:00', 'paid'),
(22, 'INV-2026-0022', 22, 10, 24.50, 1.96, '2026-05-16 11:30:00', '2026-05-31 17:00:00', 'paid'),

-- Other Customers (1 invoice each)
(23, 'INV-2026-0023', 23, 6, 29.90, 2.39, '2026-03-12 15:40:00', '2026-03-27 17:00:00', 'paid'),
(24, 'INV-2026-0024', 24, 8, 35.00, 2.80, '2026-03-30 09:15:00', '2026-04-14 17:00:00', 'paid'),
(25, 'INV-2026-0025', 25, 12, 55.00, 4.40, '2026-04-02 11:10:00', '2026-04-17 17:00:00', 'paid'),
(26, 'INV-2026-0026', 26, 14, 24.99, 2.00, '2026-04-09 14:20:00', '2026-04-24 17:00:00', 'paid'),
(27, 'INV-2026-0027', 27, 16, 199.00, 15.92, '2026-04-15 16:50:00', '2026-04-30 17:00:00', 'paid'),
(28, 'INV-2026-0028', 28, 18, 120.00, 9.60, '2026-04-20 10:00:00', '2026-05-05 17:00:00', 'paid'),
(29, 'INV-2026-0029', 29, 20, 149.99, 12.00, '2026-04-22 13:30:00', '2026-05-07 17:00:00', 'paid'),
(30, 'INV-2026-0030', 30, 21, 69.99, 5.60, '2026-04-26 15:00:00', '2026-05-11 17:00:00', 'paid'),
(31, 'INV-2026-0031', 31, 23, 43.98, 3.52, '2026-05-01 11:45:00', '2026-05-16 17:00:00', 'paid'),
(32, 'INV-2026-0032', 32, 24, 249.00, 19.92, '2026-05-04 14:10:00', '2026-05-19 17:00:00', 'paid'),
(33, 'INV-2026-0033', 33, 26, 59.99, 4.80, '2026-05-08 09:20:00', '2026-05-23 17:00:00', 'paid'),
(34, 'INV-2026-0034', 34, 28, 15.00, 1.20, '2026-05-11 16:30:00', '2026-05-26 17:00:00', 'paid'),
(35, 'INV-2026-0035', 35, 30, 4.99, 0.40, '2026-05-15 10:05:00', '2026-05-30 17:00:00', 'paid'),
(36, 'INV-2026-0036', 36, 32, 34.99, 2.80, '2026-05-18 12:50:00', '2026-06-02 17:00:00', 'unpaid'),
(37, 'INV-2026-0037', 37, 34, 99.99, 8.00, '2026-05-20 08:30:00', '2026-06-04 17:00:00', 'unpaid');

-- Seed payments (34 records, matching the 34 paid invoices, using the correct payment_method_id)
INSERT INTO payments (id, invoice_id, payment_method_id, transaction_reference, amount_paid, payment_date, status) VALUES
(1, 1, 1, 'TXN-2026-A101', 999.00, '2026-01-15 10:35:00', 'completed'),
(2, 2, 1, 'TXN-2026-A102', 45.00, '2026-02-02 14:20:00', 'completed'),
(3, 3, 3, 'TXN-2026-A103', 33.98, '2026-02-18 09:05:00', 'completed'),
(4, 4, 3, 'TXN-2026-A104', 16.99, '2026-03-05 16:50:00', 'completed'),
(5, 5, 1, 'TXN-2026-A105', 49.00, '2026-03-22 11:25:00', 'completed'),
(6, 6, 3, 'TXN-2026-A106', 66.00, '2026-04-10 13:15:00', 'completed'),
(7, 7, 4, 'TXN-2026-A107', 39.99, '2026-04-25 15:35:00', 'completed'),
(8, 8, 1, 'TXN-2026-A108', 89.00, '2026-05-02 10:05:00', 'completed'),
-- Note: Invoices 9 and 10 are unpaid, so no transaction record is seeded for them.
(9, 11, 1, 'TXN-2026-B101', 90.00, '2026-02-10 11:05:00', 'completed'),
(10, 12, 3, 'TXN-2026-B102', 70.00, '2026-03-15 15:25:00', 'completed'),
(11, 13, 4, 'TXN-2026-B103', 180.00, '2026-04-28 09:45:00', 'completed'),
(12, 14, 1, 'TXN-2026-C101', 16.99, '2026-01-20 14:55:00', 'completed'),
(13, 15, 1, 'TXN-2026-C102', 32.45, '2026-03-01 10:20:00', 'completed'),
(14, 16, 3, 'TXN-2026-C103', 69.99, '2026-05-05 11:15:00', 'completed'),
(15, 17, 6, 'TXN-2026-D101', 2997.00, '2026-02-25 09:40:00', 'completed'),
(16, 18, 1, 'TXN-2026-D102', 69.99, '2026-04-05 13:05:00', 'completed'),
-- Note: Invoice 19 is unpaid.
(17, 20, 1, 'TXN-2026-E101', 18.50, '2026-03-10 10:50:00', 'completed'),
(18, 21, 1, 'TXN-2026-E102', 37.00, '2026-04-18 14:05:00', 'completed'),
(19, 22, 4, 'TXN-2026-E103', 24.50, '2026-05-16 11:35:00', 'completed'),
(20, 23, 3, 'TXN-2026-F101', 29.90, '2026-03-12 15:45:00', 'completed'),
(21, 24, 1, 'TXN-2026-F102', 35.00, '2026-03-30 09:20:00', 'completed'),
(22, 25, 1, 'TXN-2026-F103', 55.00, '2026-04-02 11:15:00', 'completed'),
(23, 26, 3, 'TXN-2026-F104', 24.99, '2026-04-09 14:25:00', 'completed'),
(24, 27, 1, 'TXN-2026-F105', 199.00, '2026-04-15 16:55:00', 'completed'),
(25, 28, 1, 'TXN-2026-F106', 120.00, '2026-04-20 10:05:00', 'completed'),
(26, 29, 4, 'TXN-2026-F107', 149.99, '2026-04-22 13:35:00', 'completed'),
(27, 30, 3, 'TXN-2026-F108', 69.99, '2026-04-26 15:05:00', 'completed'),
(28, 31, 1, 'TXN-2026-F109', 43.98, '2026-05-01 11:50:00', 'completed'),
(29, 32, 1, 'TXN-2026-F110', 249.00, '2026-05-04 14:15:00', 'completed'),
(30, 33, 3, 'TXN-2026-F111', 59.99, '2026-05-08 09:25:00', 'completed'),
(31, 34, 1, 'TXN-2026-F112', 15.00, '2026-05-11 16:35:00', 'completed'),
(32, 35, 4, 'TXN-2026-F113', 4.99, '2026-05-15 10:10:00', 'completed');
-- Note: Invoices 36 and 37 are unpaid, so they do not have a completed payment record.
