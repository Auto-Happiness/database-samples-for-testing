CREATE TABLE item_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    type_id INT REFERENCES item_types(id),
    price DECIMAL(10, 2),
    stock_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed Types
INSERT INTO item_types (name, description) VALUES
('Hardware', 'Physical devices and equipment'),
('Peripheral', 'Input/Output devices and accessories'),
('Software', 'Licenses and digital products');

-- Seed Items
INSERT INTO items (sku, name, type_id, price, stock_quantity) VALUES
('LAP-001', 'MacBook Pro 14', 1, 1999.00, 15),
('PHN-002', 'iPhone 15 Pro', 1, 999.00, 42),
('MNR-003', 'Studio Display', 2, 1599.00, 8),
('KEY-004', 'Magic Keyboard', 2, 99.00, 100),
('MSE-005', 'Magic Mouse', 2, 79.00, 120);
