-- Revamped Orders Database Schema and Seed Data for MySQL

-- 1. Create Tables
CREATE TABLE `order` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    shipping_method VARCHAR(50) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE
);

CREATE TABLE ordered_products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    item_sku VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE
);

CREATE TABLE ordered_delivery_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    recipient_name VARCHAR(255) NOT NULL,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'United States',
    tracking_number VARCHAR(100),
    carrier VARCHAR(50),
    estimated_delivery_date DATETIME,
    actual_delivery_date DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE
);

-- Create Indexes for performance
CREATE INDEX idx_order_customer ON `order`(customer_id);
CREATE INDEX idx_order_number ON `order`(order_number);
CREATE INDEX idx_order_date ON `order`(order_date);
CREATE INDEX idx_order_details_order ON order_details(order_id);
CREATE INDEX idx_ordered_products_order ON ordered_products(order_id);
CREATE INDEX idx_ordered_products_item ON ordered_products(item_id);
CREATE INDEX idx_ordered_delivery_order ON ordered_delivery_details(order_id);

-- 2. Seed Data
-- Seed order (37 records)
INSERT INTO `order` (id, order_number, customer_id, order_date, status, total_amount) VALUES
-- Customer 1 (10 orders)
(1, 'ORD-2026-0001', 1, '2026-01-15 10:30:00', 'delivered', 999.00),
(2, 'ORD-2026-0002', 1, '2026-02-02 14:15:00', 'delivered', 45.00),
(3, 'ORD-2026-0003', 1, '2026-02-18 09:00:00', 'delivered', 33.98),
(4, 'ORD-2026-0004', 1, '2026-03-05 16:45:00', 'delivered', 16.99),
(5, 'ORD-2026-0005', 1, '2026-03-22 11:20:00', 'delivered', 49.00),
(6, 'ORD-2026-0006', 1, '2026-04-10 13:10:00', 'delivered', 66.00),
(7, 'ORD-2026-0007', 1, '2026-04-25 15:30:00', 'delivered', 39.99),
(8, 'ORD-2026-0008', 1, '2026-05-02 10:00:00', 'shipped', 89.00),
(9, 'ORD-2026-0009', 1, '2026-05-12 17:05:00', 'processing', 15.99),
(10, 'ORD-2026-0010', 1, '2026-05-19 14:30:00', 'pending', 14.99),

-- Customer 2 (3 orders)
(11, 'ORD-2026-0011', 2, '2026-02-10 11:00:00', 'delivered', 90.00),
(12, 'ORD-2026-0012', 2, '2026-03-15 15:20:00', 'delivered', 70.00),
(13, 'ORD-2026-0013', 2, '2026-04-28 09:40:00', 'delivered', 180.00),

-- Customer 3 (3 orders)
(14, 'ORD-2026-0014', 3, '2026-01-20 14:50:00', 'delivered', 16.99),
(15, 'ORD-2026-0015', 3, '2026-03-01 10:15:00', 'delivered', 32.45),
(16, 'ORD-2026-0016', 3, '2026-05-05 11:10:00', 'shipped', 69.99),

-- Customer 5 (3 orders)
(17, 'ORD-2026-0017', 5, '2026-02-25 09:30:00', 'delivered', 2997.00),
(18, 'ORD-2026-0018', 5, '2026-04-05 13:00:00', 'delivered', 69.99),
(19, 'ORD-2026-0019', 5, '2026-05-14 16:15:00', 'processing', 229.00),

-- Customer 10 (3 orders)
(20, 'ORD-2026-0020', 10, '2026-03-10 10:45:00', 'delivered', 18.50),
(21, 'ORD-2026-0021', 10, '2026-04-18 14:00:00', 'delivered', 37.00),
(22, 'ORD-2026-0022', 10, '2026-05-16 11:30:00', 'shipped', 24.50),

-- Other Customers (1 order each)
(23, 'ORD-2026-0023', 6, '2026-03-12 15:40:00', 'delivered', 29.90),
(24, 'ORD-2026-0024', 8, '2026-03-30 09:15:00', 'delivered', 35.00),
(25, 'ORD-2026-0025', 12, '2026-04-02 11:10:00', 'delivered', 55.00),
(26, 'ORD-2026-0026', 14, '2026-04-09 14:20:00', 'delivered', 24.99),
(27, 'ORD-2026-0027', 16, '2026-04-15 16:50:00', 'delivered', 199.00),
(28, 'ORD-2026-0028', 18, '2026-04-20 10:00:00', 'delivered', 120.00),
(29, 'ORD-2026-0029', 20, '2026-04-22 13:30:00', 'delivered', 149.99),
(30, 'ORD-2026-0030', 21, '2026-04-26 15:00:00', 'delivered', 69.99),
(31, 'ORD-2026-0031', 23, '2026-05-01 11:45:00', 'delivered', 43.98),
(32, 'ORD-2026-0032', 24, '2026-05-04 14:10:00', 'delivered', 249.00),
(33, 'ORD-2026-0033', 26, '2026-05-08 09:20:00', 'delivered', 59.99),
(34, 'ORD-2026-0034', 28, '2026-05-11 16:30:00', 'shipped', 15.00),
(35, 'ORD-2026-0035', 30, '2026-05-15 10:05:00', 'processing', 4.99),
(36, 'ORD-2026-0036', 32, '2026-05-18 12:50:00', 'pending', 34.99),
(37, 'ORD-2026-0037', 34, '2026-05-20 08:30:00', 'pending', 99.99);

-- Seed order_details (37 records)
INSERT INTO order_details (order_id, payment_method, shipping_method, notes) VALUES
(1, 'credit_card', 'express', 'Deliver to front desk.'),
(2, 'credit_card', 'standard', 'Leave at door.'),
(3, 'paypal', 'standard', 'Signature not required.'),
(4, 'paypal', 'standard', 'No note.'),
(5, 'credit_card', 'express', 'Wrap as gift.'),
(6, 'paypal', 'standard', 'No note.'),
(7, 'apple_pay', 'express', 'Fragile item.'),
(8, 'credit_card', 'overnight', 'Deliver before noon.'),
(9, 'apple_pay', 'standard', 'No note.'),
(10, 'paypal', 'standard', 'No note.'),
(11, 'credit_card', 'standard', 'Leave with neighbor if not home.'),
(12, 'paypal', 'express', 'No note.'),
(13, 'apple_pay', 'express', 'Gate code 4821.'),
(14, 'credit_card', 'standard', 'Ring bell on arrival.'),
(15, 'credit_card', 'standard', 'No note.'),
(16, 'paypal', 'express', 'No note.'),
(17, 'bank_transfer', 'express', 'Corporate purchase.'),
(18, 'credit_card', 'standard', 'Digital activation, no physical shipping needed.'),
(19, 'bank_transfer', 'standard', 'Bulk lab gear.'),
(20, 'credit_card', 'standard', 'No note.'),
(21, 'credit_card', 'standard', 'No note.'),
(22, 'apple_pay', 'express', 'No note.'),
(23, 'paypal', 'standard', 'Loading dock receipt.'),
(24, 'credit_card', 'standard', 'No note.'),
(25, 'credit_card', 'standard', 'No note.'),
(26, 'paypal', 'standard', 'No note.'),
(27, 'credit_card', 'express', 'Heavy package.'),
(28, 'credit_card', 'standard', 'No note.'),
(29, 'apple_pay', 'standard', 'Call on arrival.'),
(30, 'paypal', 'standard', 'No note.'),
(31, 'credit_card', 'standard', 'No note.'),
(32, 'credit_card', 'express', 'Signature required.'),
(33, 'paypal', 'standard', 'No note.'),
(34, 'credit_card', 'standard', 'No note.'),
(35, 'apple_pay', 'standard', 'No note.'),
(36, 'credit_card', 'express', 'No note.'),
(37, 'paypal', 'standard', 'No note.');

-- Seed ordered_products (37 records, referencing items 1 to 40)
INSERT INTO ordered_products (order_id, item_id, item_sku, quantity, unit_price) VALUES
(1, 1, 'ELC-IP15P-128', 1, 999.00),
(2, 2, 'APP-HOOD-BLK-M', 1, 45.00),
(3, 3, 'BOK-ATMIC-HABT', 2, 16.99),
(4, 3, 'BOK-ATMIC-HABT', 1, 16.99),
(5, 5, 'TOY-CATAN-BRD', 1, 49.00),
(6, 7, 'BTY-HYDRA-SRM', 3, 22.00),
(7, 9, 'AUT-OBD2-SCAN', 1, 39.99),
(8, 10, 'TOL-DRILL-KIT', 1, 89.00),
(9, 39, 'ART-SKT-PAD', 1, 15.99),
(10, 33, 'PTG-SEED-STR', 1, 14.99),
(11, 2, 'APP-HOOD-BLK-M', 2, 45.00),
(12, 8, 'SPT-YOGA-MAT', 2, 35.00),
(13, 16, 'JWL-WCH-SLV', 1, 120.00),
(13, 2, 'APP-HOOD-BLK-M', 1, 45.00),
(13, 23, 'BOK-CLR-THNK', 1, 15.00),
(14, 3, 'BOK-ATMIC-HABT', 1, 16.99),
(15, 4, 'GRC-MZO-OAT-1', 5, 6.49),
(16, 12, 'OFC-SHRD-12C', 1, 69.99),
(17, 1, 'ELC-IP15P-128', 3, 999.00),
(18, 18, 'SFT-MS-O365', 1, 69.99),
(19, 20, 'IND-3D-PRNT', 1, 229.00),
(20, 14, 'HLT-VIT-D3', 1, 18.50),
(21, 14, 'HLT-VIT-D3', 2, 18.50),
(22, 34, 'HLT-ORG-MULT', 1, 24.50),
(23, 6, 'HOM-CAST-SKL', 1, 29.90),
(24, 8, 'SPT-YOGA-MAT', 1, 35.00),
(25, 11, 'PET-DOG-BED', 1, 55.00),
(26, 13, 'PTG-SLR-LGT', 1, 24.99),
(27, 15, 'BAB-CAR-SEAT', 1, 199.00),
(28, 16, 'JWL-WCH-SLV', 1, 120.00),
(29, 17, 'MUS-AC-GTR', 1, 149.99),
(30, 18, 'SFT-MS-O365', 1, 69.99),
(31, 19, 'ART-PNT-SET', 2, 21.99),
(32, 21, 'ELC-APW-SE', 1, 249.00),
(33, 22, 'APP-JNS-BLU-32', 1, 59.99),
(34, 23, 'BOK-CLR-THNK', 1, 15.00),
(35, 24, 'GRC-CNO-OIL-1', 1, 4.99),
(36, 25, 'TOY-MONOP-DLX', 1, 34.99),
(37, 26, 'HOM-AIR-FRY', 1, 99.99);

-- Seed ordered_delivery_details (37 records, aligning delivery details to customer database addresses)
INSERT INTO ordered_delivery_details (order_id, recipient_name, address_line1, address_line2, city, state, postal_code, country, tracking_number, carrier, estimated_delivery_date, actual_delivery_date) VALUES
(1, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', '1Z999AA10123456784', 'UPS', '2026-01-18 17:00:00', '2026-01-18 14:22:00'),
(2, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', '9400111202103456789012', 'USPS', '2026-02-06 17:00:00', '2026-02-05 11:30:00'),
(3, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', '403928109283', 'FedEx', '2026-02-21 17:00:00', '2026-02-21 15:40:00'),
(4, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', '1Z999AA10123456789', 'UPS', '2026-03-08 17:00:00', '2026-03-08 13:10:00'),
(5, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', '9400111202103456789015', 'USPS', '2026-03-26 17:00:00', '2026-03-25 16:00:00'),
(6, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', '403928109287', 'FedEx', '2026-04-13 17:00:00', '2026-04-13 10:15:00'),
(7, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', '9400111202103456789019', 'USPS', '2026-04-28 17:00:00', '2026-04-28 12:45:00'),
(8, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', '1Z999AA10123456792', 'UPS', '2026-05-03 12:00:00', NULL),
(9, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', NULL, NULL, '2026-05-17 17:00:00', NULL),
(10, 'John Doe', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', NULL, NULL, '2026-05-24 17:00:00', NULL),

(11, 'Jane Smith', '456 Oak Ave', NULL, 'Seattle', 'WA', '98101', 'United States', '1Z999AA10123456795', 'UPS', '2026-02-13 17:00:00', '2026-02-12 15:10:00'),
(12, 'Jane Smith', '456 Oak Ave', NULL, 'Seattle', 'WA', '98101', 'United States', '403928109292', 'FedEx', '2026-03-18 17:00:00', '2026-03-18 11:55:00'),
(13, 'Jane Smith', '456 Oak Ave', NULL, 'Seattle', 'WA', '98101', 'United States', '9400111202103456789025', 'USPS', '2026-05-01 17:00:00', '2026-05-01 14:00:00'),

(14, 'Robert Johnson', '321 Maple Dr', NULL, 'Austin', 'TX', '78701', 'United States', '1Z999AA10123456799', 'UPS', '2026-01-23 17:00:00', '2026-01-23 16:30:00'),
(15, 'Robert Johnson', '321 Maple Dr', NULL, 'Austin', 'TX', '78701', 'United States', '403928109298', 'FedEx', '2026-03-04 17:00:00', '2026-03-04 10:00:00'),
(16, 'Robert Johnson', '321 Maple Dr', NULL, 'Austin', 'TX', '78701', 'United States', '9400111202103456789031', 'USPS', '2026-05-08 17:00:00', NULL),

(17, 'Michael Brown', '500 Enterprise Way', 'Floor 12', 'San Jose', 'CA', '95110', 'United States', '9400111202103456789035', 'USPS', '2026-02-28 17:00:00', '2026-02-28 12:00:00'),
(18, 'Michael Brown', '500 Enterprise Way', 'Floor 12', 'San Jose', 'CA', '95110', 'United States', NULL, NULL, NULL, NULL), -- Digital software key, no tracking
(19, 'Michael Brown', '500 Enterprise Way', 'Floor 12', 'San Jose', 'CA', '95110', 'United States', '403928109312', 'FedEx', '2026-05-18 17:00:00', NULL),

(20, 'Joseph Anderson', '400 University Ave', 'Science Hall', 'Boston', 'MA', '02108', 'United States', '1Z999AA10123456812', 'UPS', '2026-03-14 17:00:00', '2026-03-14 15:30:00'),
(21, 'Joseph Anderson', '400 University Ave', 'Science Hall', 'Boston', 'MA', '02108', 'United States', '403928109320', 'FedEx', '2026-04-21 17:00:00', '2026-04-21 13:45:00'),
(22, 'Joseph Anderson', '400 University Ave', 'Science Hall', 'Boston', 'MA', '02108', 'United States', '9400111202103456789045', 'USPS', '2026-05-19 17:00:00', NULL),

(23, 'Linda Miller', '900 Wholesale Blvd', 'Dock 3', 'Dallas', 'TX', '75201', 'United States', '403928109335', 'FedEx', '2026-03-15 17:00:00', '2026-03-15 11:20:00'),
(24, 'David Moore', '101 Birch Ln', NULL, 'Denver', 'CO', '80201', 'United States', '1Z999AA10123456825', 'UPS', '2026-04-03 17:00:00', '2026-04-03 14:10:00'),
(25, 'Charles Jackson', '202 Cedar Pl', NULL, 'Phoenix', 'AZ', '85001', 'United States', '9400111202103456789052', 'USPS', '2026-04-05 17:00:00', '2026-04-05 13:30:00'),
(26, 'Daniel Harris', '888 Distributor Rd', 'Unit C', 'Atlanta', 'GA', '30301', 'United States', '403928109355', 'FedEx', '2026-04-12 17:00:00', '2026-04-12 10:50:00'),
(27, 'Anthony Thompson', '303 Spruce St', NULL, 'Portland', 'OR', '97201', 'United States', '1Z999AA10123456835', 'UPS', '2026-04-18 17:00:00', '2026-04-18 15:40:00'),
(28, 'Donald Martinez', '100 Military Plaza', 'Barracks A', 'San Diego', 'CA', '92101', 'United States', '403928109375', 'FedEx', '2026-04-23 17:00:00', '2026-04-23 11:00:00'),
(29, 'Paul Clark', '600 Tech Startup Rd', 'Suite 5', 'New York', 'NY', '10001', 'United States', '9400111202103456789065', 'USPS', '2026-04-25 17:00:00', '2026-04-25 14:15:00'),
(30, 'Andrew Rodriguez', '404 Walnut Ave', NULL, 'Miami', 'FL', '33101', 'United States', NULL, NULL, NULL, NULL), -- Digital
(31, 'Kenneth Lee', '505 Cherry Dr', NULL, 'Detroit', 'MI', '48201', 'United States', '9400111202103456789072', 'USPS', '2026-05-04 17:00:00', '2026-05-04 16:30:00'),
(32, 'Kevin Walker', '606 Ash Ln', NULL, 'Minneapolis', 'MN', '55401', 'United States', '1Z999AA10123456855', 'UPS', '2026-05-07 17:00:00', '2026-05-07 13:40:00'),
(33, 'George Allen', '707 Student Union Dr', 'Room 304', 'Columbus', 'OH', '43210', 'United States', '403928109405', 'FedEx', '2026-05-11 17:00:00', '2026-05-11 10:15:00'),
(34, 'Ronald Hernandez', '808 Redwood Hwy', NULL, 'San Francisco', 'CA', '94101', 'United States', '1Z999AA10123456860', 'UPS', '2026-05-14 17:00:00', NULL),
(35, 'Jason Wright', '909 Willow Way', NULL, 'Nashville', 'TN', '37201', 'United States', NULL, NULL, '2026-05-19 17:00:00', NULL),
(36, 'Ryan Hill', '111 Cypress St', NULL, 'Orlando', 'FL', '32801', 'United States', NULL, NULL, '2026-05-23 17:00:00', NULL),
(37, 'Gary Green', '222 Poplar Rd', NULL, 'Salt Lake City', 'UT', '84101', 'United States', NULL, NULL, '2026-05-25 17:00:00', NULL);
