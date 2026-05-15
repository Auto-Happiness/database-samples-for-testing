CREATE TABLE order_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(20) UNIQUE NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    type_id INT, -- Links to order_types
    item_sku VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    status ENUM('pending', 'shipped', 'delivered') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (type_id) REFERENCES order_types(id)
);

-- Seed Order Types
INSERT INTO order_types (name, description) VALUES
('Online', 'Orders placed through the website'),
('Retail', 'In-store point of sale purchases'),
('Wholesale', 'Bulk business-to-business orders');

-- Seed Orders
INSERT INTO orders (order_number, customer_email, type_id, item_sku, quantity, status) VALUES
('ORD-1001', 'james@bond.com', 1, 'LAP-001', 1, 'delivered'),
('ORD-1002', 'ciel@orcha.io', 1, 'PHN-002', 2, 'shipped'),
('ORD-1003', 'tony@stark.com', 3, 'LAP-001', 5, 'pending'),
('ORD-1004', 'ciel@orcha.io', 2, 'MNR-003', 1, 'delivered'),
('ORD-1005', 'james@bond.com', 1, 'MSE-005', 3, 'shipped');
