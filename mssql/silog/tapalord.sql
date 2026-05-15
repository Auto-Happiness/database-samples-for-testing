-- Food Inventory Management System - MSSQL
-- Database: tapalord
-- Created for managing food inventory, orders, and invoicing

-- =====================================================
-- 1. FOOD CATEGORIES TABLE
-- =====================================================
CREATE TABLE food_categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500),
    created_at DATETIME DEFAULT GETDATE()
);
GO


-- =====================================================
-- 2. SUPPLIERS TABLE
-- =====================================================
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY IDENTITY(1,1),
    supplier_name VARCHAR(150) NOT NULL UNIQUE,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    country VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);
GO


-- =====================================================
-- 3. FOOD/PRODUCTS TABLE
-- =====================================================
CREATE TABLE food (
    food_id INT PRIMARY KEY IDENTITY(1,1),
    food_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT,
    description VARCHAR(500),
    unit_price DECIMAL(10,2) NOT NULL,
    quantity_in_stock INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    unit_of_measure VARCHAR(20),
    expiry_date DATE,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES food_categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);
GO


-- =====================================================
-- 4. CUSTOMERS TABLE
-- =====================================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    customer_name VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50),
    customer_type VARCHAR(20), -- Retail, Wholesale, Restaurant
    credit_limit DECIMAL(12,2) DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);
GO


-- =====================================================
-- 5. ORDERS TABLE
-- =====================================================
CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    delivery_date DATE,
    status VARCHAR(20) DEFAULT 'Pending', -- Pending, Confirmed, Shipped, Delivered, Cancelled
    total_amount DECIMAL(12,2) DEFAULT 0,
    notes VARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
GO


-- =====================================================
-- 6. ORDER ITEMS TABLE
-- =====================================================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);
GO


-- =====================================================
-- 7. INVOICE TABLE
-- =====================================================
CREATE TABLE invoice (
    invoice_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    customer_id INT NOT NULL,
    invoice_date DATETIME DEFAULT GETDATE(),
    due_date DATE,
    total_amount DECIMAL(12,2) NOT NULL,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    discount_amount DECIMAL(12,2) DEFAULT 0,
    payment_status VARCHAR(20) DEFAULT 'Unpaid', -- Unpaid, Paid, Partial, Overdue
    payment_method VARCHAR(50),
    payment_date DATE,
    notes VARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
GO


-- =====================================================
-- 8. INVENTORY LOG TABLE
-- =====================================================
CREATE TABLE inventory_log (
    log_id INT PRIMARY KEY IDENTITY(1,1),
    food_id INT NOT NULL,
    transaction_type VARCHAR(20), -- Purchase, Sale, Adjustment, Damage
    quantity_change INT,
    previous_quantity INT,
    new_quantity INT,
    reason VARCHAR(200),
    transaction_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);
GO


-- =====================================================
-- 9. MEALS TABLE
-- =====================================================
CREATE TABLE meals (
    meal_id INT PRIMARY KEY IDENTITY(1,1),
    meal_name VARCHAR(150) NOT NULL,
    meal_type VARCHAR(50), -- Breakfast, Lunch, Dinner, Silog, Dessert
    description VARCHAR(500),
    meal_price DECIMAL(10,2) NOT NULL,
    calories INT,
    preparation_time INT, -- in minutes
    available INT DEFAULT 1, -- 0 = unavailable, 1 = available
    created_at DATETIME DEFAULT GETDATE()
);
GO


-- =====================================================
-- 10. MEAL ITEMS TABLE (Recipe/Ingredients)
-- =====================================================
CREATE TABLE meal_items (
    meal_item_id INT PRIMARY KEY IDENTITY(1,1),
    meal_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity_required DECIMAL(10,2),
    unit_of_measure VARCHAR(20),
    FOREIGN KEY (meal_id) REFERENCES meals(meal_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);
GO


-- =====================================================
-- SAMPLE DATA
-- =====================================================

-- Insert Food Categories
INSERT INTO food_categories (category_name, description) VALUES
('Vegetables', 'Fresh and frozen vegetables'),
('Fruits', 'Fresh and dried fruits'),
('Dairy', 'Milk, cheese, yogurt and dairy products'),
('Meat', 'Fresh and processed meat products'),
('Beverages', 'Drinks including juices and water'),
('Grains', 'Rice, bread, pasta and grain products'),
('Snacks', 'Packaged snacks and chips'),
('Frozen', 'Frozen prepared meals and ice cream'),
('Desserts', 'Cakes, pastries, and sweet treats');

-- Insert Suppliers
INSERT INTO suppliers (supplier_name, contact_person, email, phone, address, city, country) VALUES
('Fresh Farms Ltd', 'John Smith', 'john@freshfarms.com', '+1-555-0101', '123 Farm Road', 'Springfield', 'USA'),
('Premium Dairy Co', 'Sarah Johnson', 'sarah@premiumdairy.com', '+1-555-0102', '456 Milk Lane', 'Shelbyville', 'USA'),
('Quality Meats Inc', 'Mike Davis', 'mike@qualitymeats.com', '+1-555-0103', '789 Butcher Ave', 'Capital City', 'USA'),
('Global Imports', 'Lisa Wong', 'lisa@globalimports.com', '+1-555-0104', '321 Trade Street', 'Metropolis', 'USA'),
('Local Orchard', 'Tom Brown', 'tom@localorchard.com', '+1-555-0105', '654 Fruit Ln', 'Smallville', 'USA');

-- Insert Food Items
INSERT INTO food (food_name, category_id, supplier_id, description, unit_price, quantity_in_stock, reorder_level, unit_of_measure, expiry_date) VALUES
('Tomatoes', 1, 1, 'Fresh red tomatoes', 2.50, 150, 20, 'kg', '2026-05-14'),
('Carrots', 1, 1, 'Fresh orange carrots', 1.80, 200, 30, 'kg', '2026-06-15'),
('Broccoli', 1, 1, 'Fresh green broccoli', 3.20, 100, 15, 'kg', '2026-05-10'),
('Apples', 2, 5, 'Fresh red apples', 3.50, 300, 40, 'kg', '2026-06-30'),
('Bananas', 2, 5, 'Yellow bananas', 2.00, 250, 35, 'kg', '2026-05-12'),
('Milk 1L', 3, 2, 'Fresh whole milk', 2.75, 180, 25, 'liter', '2026-05-15'),
('Cheddar Cheese', 3, 2, 'Aged cheddar cheese', 8.50, 50, 10, 'kg', '2026-07-30'),
('Ground Beef', 4, 3, 'Fresh ground beef', 12.50, 80, 15, 'kg', '2026-05-09'),
('Chicken Breast', 4, 3, 'Fresh chicken breast', 9.75, 120, 20, 'kg', '2026-05-10'),
('Orange Juice', 5, 4, 'Fresh squeezed orange juice', 4.20, 200, 25, 'liter', '2026-05-20'),
('White Rice', 6, 4, 'Premium white rice', 1.50, 500, 100, 'kg', '2027-05-07'),
('Whole Wheat Bread', 6, 1, 'Fresh whole wheat bread', 3.00, 75, 20, 'unit', '2026-05-09'),
('Potato Chips', 7, 4, 'Salted potato chips', 1.99, 300, 50, 'box', '2026-08-07'),
('Vanilla Ice Cream', 8, 2, 'Premium vanilla ice cream', 6.50, 120, 20, 'liter', '2026-08-07'),
('Chocolate Cake', 9, 1, 'Rich chocolate layered cake', 15.00, 30, 5, 'unit', '2026-05-09'),
('Strawberry Cheesecake', 9, 1, 'Fresh strawberry cheesecake', 18.50, 25, 5, 'unit', '2026-05-10'),
('Chocolate Brownies', 9, 1, 'Fudgy chocolate brownies', 2.50, 100, 15, 'box', '2026-05-15'),
('Apple Pie', 9, 1, 'Homemade apple pie', 12.00, 20, 5, 'unit', '2026-05-08'),
('Tiramisu', 9, 1, 'Italian tiramisu dessert', 8.50, 40, 8, 'unit', '2026-05-11'),
('Donuts', 9, 1, 'Glazed donuts assortment', 3.50, 80, 15, 'box', '2026-05-10');

-- Insert Customers
INSERT INTO customers (customer_name, email, phone, address, city, postal_code, country, customer_type, credit_limit) VALUES
('John Smith', 'john.smith@email.com', '+1-555-1001', '111 Main Street', 'Springfield', '12345', 'USA', 'Individual', 1000.00),
('Maria Garcia', 'maria.garcia@email.com', '+1-555-1002', '222 Market Road', 'Shelbyville', '12346', 'USA', 'Individual', 800.00),
('Robert Johnson', 'r.johnson@email.com', '+1-555-1003', '333 Coffee Lane', 'Capital City', '12347', 'USA', 'Individual', 1200.00),
('Jennifer Chen', 'j.chen@email.com', '+1-555-1004', '444 Gourmet Ave', 'Metropolis', '12348', 'USA', 'Individual', 950.00),
('Michael Brown', 'mike.brown@email.com', '+1-555-1005', '555 Bulk Street', 'Smallville', '12349', 'USA', 'Individual', 1100.00),
('Sarah Williams', 'sarah.w@email.com', '+1-555-1006', '666 Family Ln', 'Springfield', '12350', 'USA', 'Individual', 900.00);

-- Insert Orders
INSERT INTO orders (customer_id, order_date, delivery_date, status, total_amount) VALUES
(1, '2026-05-01', '2026-05-03', 'Delivered', 450.00),
(2, '2026-05-02', '2026-05-05', 'Delivered', 1200.50),
(3, '2026-05-03', '2026-05-04', 'Delivered', 325.75),
(1, '2026-05-04', '2026-05-06', 'Confirmed', 550.25),
(4, '2026-05-05', '2026-05-07', 'Pending', 890.00),
(5, '2026-05-06', '2026-05-10', 'Pending', 2500.00);

-- Insert Order Items
INSERT INTO order_items (order_id, food_id, quantity, unit_price, subtotal) VALUES
(1, 1, 50, 2.50, 125.00),
(1, 9, 20, 9.75, 195.00),
(1, 11, 10, 1.50, 15.00),
(1, 6, 20, 2.75, 55.00),
(2, 2, 80, 1.80, 144.00),
(2, 4, 100, 3.50, 350.00),
(2, 8, 40, 12.50, 500.00),
(2, 12, 40, 3.00, 120.00),
(2, 14, 10, 6.50, 65.00),
(3, 5, 75, 2.00, 150.00),
(3, 7, 20, 8.50, 170.00),
(3, 10, 10, 4.20, 42.00),
(4, 3, 30, 3.20, 96.00),
(4, 9, 30, 9.75, 292.50),
(4, 6, 25, 2.75, 68.75),
(4, 13, 50, 1.99, 99.50),
(5, 1, 100, 2.50, 250.00),
(5, 8, 50, 12.50, 625.00),
(5, 11, 25, 1.50, 37.50),
(5, 5, 30, 2.00, 60.00),
(6, 2, 200, 1.80, 360.00),
(6, 4, 150, 3.50, 525.00),
(6, 6, 100, 2.75, 275.00),
(6, 14, 50, 6.50, 325.00),
(6, 12, 100, 3.00, 300.00),
(6, 10, 50, 4.20, 210.00),
(6, 9, 75, 9.75, 731.25),
(6, 8, 20, 12.50, 250.00);

-- Insert Invoices
INSERT INTO invoice (order_id, customer_id, invoice_date, due_date, total_amount, tax_amount, discount_amount, payment_status, payment_method, payment_date) VALUES
(1, 1, '2026-05-01', '2026-05-15', 450.00, 45.00, 0, 'Paid', 'Credit Card', '2026-05-05'),
(2, 2, '2026-05-02', '2026-05-16', 1200.50, 120.05, 0, 'Paid', 'Bank Transfer', '2026-05-06'),
(3, 3, '2026-05-03', '2026-05-17', 325.75, 32.58, 0, 'Paid', 'Cash', '2026-05-04'),
(4, 1, '2026-05-04', '2026-05-18', 550.25, 55.03, 0, 'Unpaid', 'Credit Card', NULL),
(5, 4, '2026-05-05', '2026-05-19', 890.00, 89.00, 0, 'Unpaid', NULL, NULL),
(6, 5, '2026-05-06', '2026-05-20', 2500.00, 250.00, 100.00, 'Partial', 'Bank Transfer', '2026-05-07');

-- Insert Meals (Silog & Breakfast Meals)
INSERT INTO meals (meal_name, meal_type, description, meal_price, calories, preparation_time, available) VALUES
('Silog Special Combo', 'Silog', 'Sinangag rice, fried egg, and tocino with tomatoes', 8.50, 550, 15, 1),
('Breakfast Silog', 'Breakfast', 'White rice, scrambled eggs, and sausage links', 7.75, 480, 12, 1),
('Longsilog', 'Silog', 'Silog with delicious longaniza sausage', 9.25, 620, 18, 1),
('Tapa Silog', 'Silog', 'Silog with tender beef tapa and fresh onions', 9.75, 580, 20, 1),
('Corned Beef Silog', 'Silog', 'Silog with homemade corned beef hash', 8.75, 540, 15, 1),
('Hotsilog', 'Silog', 'Silog with grilled hot dog and vegetables', 7.50, 520, 12, 1),
('Chocolate Cake Slice', 'Dessert', 'Delicious layered chocolate cake', 4.50, 320, 2, 1),
('Cheesecake Delight', 'Dessert', 'Fresh strawberry cheesecake with berry topping', 5.75, 380, 2, 1),
('Brownie Blast', 'Dessert', 'Warm fudgy brownies with ice cream', 4.25, 420, 5, 1),
('Apple Pie Slice', 'Dessert', 'Homemade apple pie with vanilla ice cream', 4.00, 350, 3, 1),
('Tiramisu Elegance', 'Dessert', 'Traditional Italian tiramisu with coffee flavors', 5.50, 360, 2, 1),
('Donut Dozen', 'Dessert', 'Assorted glazed donuts - 12 pieces', 6.99, 280, 2, 1);

-- Insert Meal Items (Recipe Ingredients for Silog)
INSERT INTO meal_items (meal_id, food_id, quantity_required, unit_of_measure) VALUES
-- Silog Special Combo (meal_id 1): Rice, Egg, Tomato
(1, 11, 0.5, 'kg'),
(1, 6, 0.2, 'liter'),
(1, 1, 0.1, 'kg'),
-- Breakfast Silog (meal_id 2): Rice, Egg, Tomato
(2, 11, 0.5, 'kg'),
(2, 6, 0.2, 'liter'),
(2, 1, 0.1, 'kg'),
-- Longsilog (meal_id 3): Rice, Egg
(3, 11, 0.5, 'kg'),
(3, 6, 0.2, 'liter'),
-- Tapa Silog (meal_id 4): Rice, Egg, Beef
(4, 11, 0.5, 'kg'),
(4, 6, 0.2, 'liter'),
(4, 8, 0.15, 'kg'),
-- Corned Beef Silog (meal_id 5): Rice, Egg
(5, 11, 0.5, 'kg'),
(5, 6, 0.2, 'liter'),
-- Hotsilog (meal_id 6): Rice, Egg
(6, 11, 0.5, 'kg'),
(6, 6, 0.2, 'liter'),
-- Chocolate Cake (meal_id 7): Uses cake
(7, 15, 0.25, 'unit'),
-- Cheesecake (meal_id 8): Uses cheesecake
(8, 16, 0.25, 'unit'),
-- Brownie (meal_id 9): Uses brownies and ice cream
(9, 17, 1, 'box'),
(9, 14, 0.1, 'liter'),
-- Apple Pie (meal_id 10): Uses pie and ice cream
(10, 18, 0.25, 'unit'),
(10, 14, 0.1, 'liter'),
-- Tiramisu (meal_id 11): Uses tiramisu
(11, 19, 1, 'unit'),
-- Donuts (meal_id 12): Uses donuts
(12, 20, 1, 'box');

-- Insert Inventory Log
INSERT INTO inventory_log (food_id, transaction_type, quantity_change, previous_quantity, new_quantity, reason) VALUES
(1, 'Purchase', 200, 0, 200, 'Initial stock'),
(1, 'Sale', -50, 200, 150, 'Order #1'),
(2, 'Purchase', 280, 0, 280, 'Initial stock'),
(2, 'Sale', -80, 280, 200, 'Order #2'),
(4, 'Purchase', 400, 0, 400, 'Initial stock'),
(4, 'Sale', -100, 400, 300, 'Order #2'),
(9, 'Purchase', 200, 0, 200, 'Initial stock'),
(9, 'Sale', -50, 200, 150, 'Order #1'),
(6, 'Purchase', 300, 0, 300, 'Initial stock'),
(6, 'Sale', -45, 300, 255, 'Orders #1 and #4'),
(8, 'Purchase', 150, 0, 150, 'Initial stock'),
(8, 'Sale', -40, 150, 110, 'Order #2'),
(3, 'Purchase', 150, 0, 150, 'Initial stock'),
(7, 'Purchase', 100, 0, 100, 'Initial stock'),
(7, 'Sale', -20, 100, 80, 'Order #3'),
(10, 'Purchase', 250, 0, 250, 'Initial stock'),
(11, 'Purchase', 600, 0, 600, 'Initial stock'),
(12, 'Purchase', 200, 0, 200, 'Initial stock'),
(14, 'Purchase', 200, 0, 200, 'Initial stock'),
(13, 'Purchase', 400, 0, 400, 'Initial stock'),
(15, 'Purchase', 100, 0, 100, 'Dessert initial stock'),
(16, 'Purchase', 80, 0, 80, 'Dessert initial stock'),
(17, 'Purchase', 150, 0, 150, 'Dessert initial stock'),
(18, 'Purchase', 60, 0, 60, 'Dessert initial stock'),
(19, 'Purchase', 120, 0, 120, 'Dessert initial stock'),
(20, 'Purchase', 200, 0, 200, 'Dessert initial stock');
GO


-- =====================================================
-- USEFUL QUERIES
-- =====================================================

-- View all inventory
-- SELECT f.food_id, f.food_name, fc.category_name, f.quantity_in_stock, f.unit_price, f.expiry_date
-- FROM food f
-- JOIN food_categories fc ON f.category_id = fc.category_id
-- ORDER BY fc.category_name, f.food_name;

-- View low stock items
-- SELECT f.food_name, f.quantity_in_stock, f.reorder_level, fc.category_name
-- FROM food f
-- JOIN food_categories fc ON f.category_id = fc.category_id
-- WHERE f.quantity_in_stock <= f.reorder_level
-- ORDER BY f.quantity_in_stock;

-- View unpaid invoices
-- SELECT i.invoice_id, c.customer_name, i.total_amount, i.due_date
-- FROM invoice i
-- JOIN customers c ON i.customer_id = c.customer_id
-- WHERE i.payment_status = 'Unpaid'
-- ORDER BY i.due_date;

-- View order summary
-- SELECT o.order_id, c.customer_name, o.order_date, o.total_amount, o.status
-- FROM orders o
-- JOIN customers c ON o.customer_id = c.customer_id
-- ORDER BY o.order_date DESC;

-- View all available meals
-- SELECT meal_id, meal_name, meal_type, meal_price, calories, preparation_time
-- FROM meals
-- WHERE available = 1
-- ORDER BY meal_type, meal_name;

-- View all silog meals
-- SELECT meal_id, meal_name, meal_price, calories, preparation_time
-- FROM meals
-- WHERE meal_type = 'Silog'
-- ORDER BY meal_price;

-- View all desserts
-- SELECT meal_id, meal_name, meal_price, calories
-- FROM meals
-- WHERE meal_type = 'Dessert'
-- ORDER BY meal_price;

-- View meal ingredients/recipe
-- SELECT m.meal_name, f.food_name, mi.quantity_required, mi.unit_of_measure
-- FROM meals m
-- JOIN meal_items mi ON m.meal_id = mi.meal_id
-- JOIN food f ON mi.food_id = f.food_id
-- WHERE m.meal_id = 1
-- ORDER BY f.food_name;

-- =====================================================
-- SAMPLE VIEWS
-- =====================================================

-- =====================================================
-- VIEW 1: Customer Purchase Summary
-- =====================================================
GO
CREATE VIEW vw_customer_purchase_summary AS
SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value,
    MAX(o.order_date) AS last_order_date,
    MIN(o.order_date) AS first_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.email, c.phone;

-- =====================================================
-- VIEW 2: Low Stock Inventory Alert
-- =====================================================
GO
CREATE VIEW vw_low_stock_inventory AS
SELECT 
    f.food_id,
    f.food_name,
    fc.category_name,
    f.quantity_in_stock,
    f.reorder_level,
    (f.reorder_level - f.quantity_in_stock) AS quantity_needed,
    f.unit_price,
    (f.reorder_level - f.quantity_in_stock) * f.unit_price AS estimated_cost,
    f.expiry_date,
    s.supplier_name,
    s.email AS supplier_email
FROM food f
JOIN food_categories fc ON f.category_id = fc.category_id
LEFT JOIN suppliers s ON f.supplier_id = s.supplier_id
WHERE f.quantity_in_stock <= f.reorder_level
ORDER BY (f.reorder_level - f.quantity_in_stock) DESC;

-- =====================================================
-- VIEW 3: Popular Meals and Revenue
-- =====================================================
GO
CREATE VIEW vw_popular_meals_revenue AS
SELECT 
    m.meal_id,
    m.meal_name,
    m.meal_type,
    m.meal_price,
    COUNT(DISTINCT oi.order_id) AS times_ordered,
    SUM(oi.quantity) AS total_quantity_ordered,
    SUM(oi.subtotal) AS total_revenue,
    AVG(m.calories) AS avg_calories,
    m.preparation_time
FROM meals m
LEFT JOIN meal_items mi ON m.meal_id = mi.meal_id
LEFT JOIN order_items oi ON mi.food_id = oi.food_id
GROUP BY m.meal_id, m.meal_name, m.meal_type, m.meal_price, m.calories, m.preparation_time
ORDER BY total_revenue DESC;

-- =====================================================
-- VIEW 4: Invoice and Payment Status Report
-- =====================================================
GO
CREATE VIEW vw_invoice_payment_report AS
SELECT 
    i.invoice_id,
    c.customer_name,
    i.invoice_date,
    i.due_date,
    i.total_amount,
    i.tax_amount,
    i.discount_amount,
    (i.total_amount + i.tax_amount - i.discount_amount) AS final_amount,
    i.payment_status,
    i.payment_date,
    DATEDIFF(DAY, i.due_date, CAST(GETDATE() AS DATE)) AS days_overdue,
    CASE 
        WHEN i.payment_status = 'Paid' THEN 'Complete'
        WHEN DATEDIFF(DAY, i.due_date, CAST(GETDATE() AS DATE)) > 0 AND i.payment_status != 'Paid' THEN 'Overdue'
        ELSE 'Pending'
    END AS status_category
FROM invoice i
JOIN customers c ON i.customer_id = c.customer_id
ORDER BY i.invoice_date DESC;
