-- E-Commerce Database Seed Data

-- Insert Item Types (Categories)
INSERT INTO item_type (type_name, description, created_date, updated_date, active) VALUES
('Electronics', 'Electronic devices and gadgets', NOW(), NOW(), TRUE),
('Clothing', 'Apparel and fashion items', NOW(), NOW(), TRUE),
('Books', 'Physical and digital books', NOW(), NOW(), TRUE),
('Home & Garden', 'Home furnishings and garden supplies', NOW(), NOW(), TRUE),
('Sports & Outdoors', 'Sports equipment and outdoor gear', NOW(), NOW(), TRUE);

-- Insert Users
INSERT INTO users (username, email, password_hash, first_name, last_name, phone, address_line1, city, state_province, postal_code, country, created_date, updated_date, active) VALUES
('john_doe', 'john.doe@email.com', '$2b$12$abcdefg123456', 'John', 'Doe', '+1-555-0101', '123 Main St', 'New York', 'NY', '10001', 'USA', NOW(), NOW(), TRUE),
('jane_smith', 'jane.smith@email.com', '$2b$12$hijklmn123456', 'Jane', 'Smith', '+1-555-0102', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA', NOW(), NOW(), TRUE),
('bob_johnson', 'bob.johnson@email.com', '$2b$12$opqrstu123456', 'Bob', 'Johnson', '+1-555-0103', '789 Pine Rd', 'Chicago', 'IL', '60601', 'USA', NOW(), NOW(), TRUE),
('alice_williams', 'alice.williams@email.com', '$2b$12$vwxyzab123456', 'Alice', 'Williams', '+1-555-0104', '321 Elm St', 'Houston', 'TX', '77001', 'USA', NOW(), NOW(), TRUE),
('charlie_brown', 'charlie.brown@email.com', '$2b$12$cdefghi123456', 'Charlie', 'Brown', '+1-555-0105', '654 Maple Dr', 'Phoenix', 'AZ', '85001', 'USA', NOW(), NOW(), TRUE),
('diana_prince', 'diana.prince@email.com', '$2b$12$jklmnop123456', 'Diana', 'Prince', '+1-555-0106', '987 Cedar Ln', 'Philadelphia', 'PA', '19101', 'USA', NOW(), NOW(), TRUE),
('evan_davis', 'evan.davis@email.com', '$2b$12$qrstuvw123456', 'Evan', 'Davis', '+1-555-0107', '135 Birch Ave', 'San Antonio', 'TX', '78201', 'USA', NOW(), NOW(), TRUE),
('fiona_miller', 'fiona.miller@email.com', '$2b$12$xyzabcd123456', 'Fiona', 'Miller', '+1-555-0108', '246 Ash St', 'San Diego', 'CA', '92101', 'USA', NOW(), NOW(), TRUE);

-- Insert Items (Electronics)
INSERT INTO items (item_type_id, item_name, description, price, image_url, stock_quantity, sku, created_date, updated_date, active) VALUES
(1, 'Wireless Bluetooth Headphones', 'High-quality noise-canceling wireless headphones with 30-hour battery life', 129.99, 'https://example.com/headphones.jpg', 45, 'WBH-001', NOW(), NOW(), TRUE),
(1, 'USB-C Charging Cable (3-pack)', 'Durable USB-C cables with fast charging support, 3 pack', 24.99, 'https://example.com/usb-c-cable.jpg', 120, 'USC-001', NOW(), NOW(), TRUE),
(1, '4K Webcam', 'Professional 4K webcam with auto-focus and built-in microphone', 199.99, 'https://example.com/webcam.jpg', 25, 'WEB-001', NOW(), NOW(), TRUE),
(1, 'Portable Phone Charger', '20000mAh portable battery pack with dual USB ports', 39.99, 'https://example.com/powerbank.jpg', 80, 'PBC-001', NOW(), NOW(), TRUE),

-- Insert Items (Clothing)
(2, 'Cotton T-Shirt', 'Premium quality 100% cotton t-shirt, comfortable fit', 19.99, 'https://example.com/tshirt.jpg', 200, 'TSH-001', NOW(), NOW(), TRUE),
(2, 'Denim Jeans', 'Classic blue denim jeans with perfect fit and durability', 59.99, 'https://example.com/jeans.jpg', 150, 'DEN-001', NOW(), NOW(), TRUE),
(2, 'Winter Jacket', 'Warm insulated winter jacket with water-resistant coating', 149.99, 'https://example.com/jacket.jpg', 60, 'JAC-001', NOW(), NOW(), TRUE),
(2, 'Athletic Running Shoes', 'Lightweight and comfortable running shoes with gel cushioning', 89.99, 'https://example.com/shoes.jpg', 100, 'RUN-001', NOW(), NOW(), TRUE),

-- Insert Items (Books)
(3, 'The Art of Programming', 'Comprehensive guide to programming principles and practices', 45.99, 'https://example.com/book1.jpg', 85, 'BOK-001', NOW(), NOW(), TRUE),
(3, 'Digital Marketing Mastery', 'Learn modern digital marketing strategies and tactics', 34.99, 'https://example.com/book2.jpg', 110, 'BOK-002', NOW(), NOW(), TRUE),
(3, 'Science Fiction Novel: Future Worlds', 'Epic science fiction novel set in distant galaxies', 16.99, 'https://example.com/book3.jpg', 200, 'BOK-003', NOW(), NOW(), TRUE),

-- Insert Items (Home & Garden)
(4, 'LED Desk Lamp', 'Adjustable LED desk lamp with touch control and USB charging', 44.99, 'https://example.com/lamp.jpg', 75, 'LMP-001', NOW(), NOW(), TRUE),
(4, 'Bamboo Cutting Board Set', 'Set of 3 eco-friendly bamboo cutting boards', 29.99, 'https://example.com/cutting-board.jpg', 95, 'CUT-001', NOW(), NOW(), TRUE),
(4, 'Indoor Plant Pot', 'Ceramic plant pot with drainage hole, 8-inch diameter', 22.99, 'https://example.com/pot.jpg', 140, 'POT-001', NOW(), NOW(), TRUE),

-- Insert Items (Sports & Outdoors)
(5, 'Yoga Mat', 'Non-slip yoga mat with carrying strap, 6mm thickness', 39.99, 'https://example.com/yoga-mat.jpg', 65, 'YGA-001', NOW(), NOW(), TRUE),
(5, 'Camping Tent', '2-person camping tent with weatherproof design', 119.99, 'https://example.com/tent.jpg', 35, 'TEN-001', NOW(), NOW(), TRUE),
(5, 'Hiking Backpack', '50L hiking backpack with multiple compartments', 89.99, 'https://example.com/backpack.jpg', 50, 'BAK-001', NOW(), NOW(), TRUE);

-- Insert Item Variants (Size variants for clothing)
INSERT INTO item_variants (item_id, variant_name, variant_value, price_modifier, stock_quantity, sku_variant, created_date, updated_date, active) VALUES
(5, 'Size', 'Small', 0.00, 80, 'TSH-001-S', NOW(), NOW(), TRUE),
(5, 'Size', 'Medium', 0.00, 70, 'TSH-001-M', NOW(), NOW(), TRUE),
(5, 'Size', 'Large', 0.00, 50, 'TSH-001-L', NOW(), NOW(), TRUE),
(6, 'Size', '28', 0.00, 40, 'DEN-001-28', NOW(), NOW(), TRUE),
(6, 'Size', '30', 0.00, 50, 'DEN-001-30', NOW(), NOW(), TRUE),
(6, 'Size', '32', 0.00, 60, 'DEN-001-32', NOW(), NOW(), TRUE),
(8, 'Size', '8', 0.00, 35, 'RUN-001-8', NOW(), NOW(), TRUE),
(8, 'Size', '9', 0.00, 40, 'RUN-001-9', NOW(), NOW(), TRUE),
(8, 'Size', '10', 0.00, 25, 'RUN-001-10', NOW(), NOW(), TRUE);

-- Insert Reviews
INSERT INTO reviews (item_id, user_id, rating, review_title, review_text, helpful_count, created_date, updated_date, active) VALUES
(1, 1, 5, 'Excellent sound quality!', 'These headphones have amazing sound quality and the noise cancellation is top-notch. Highly recommended!', 42, NOW() - INTERVAL '30 days', NOW(), TRUE),
(1, 2, 4, 'Good but pricey', 'Great headphones but a bit expensive. The battery life is impressive though.', 28, NOW() - INTERVAL '25 days', NOW(), TRUE),
(2, 3, 5, 'Durable cables', 'These USB-C cables are incredibly durable. I have been using them for 6 months without any issues.', 35, NOW() - INTERVAL '20 days', NOW(), TRUE),
(5, 4, 5, 'Perfect fit and quality', 'The cotton t-shirt is so comfortable and the quality is excellent. Will buy again!', 52, NOW() - INTERVAL '15 days', NOW(), TRUE),
(5, 5, 4, 'Good value', 'Nice t-shirt for the price. Colors fade a bit after washing.', 18, NOW() - INTERVAL '12 days', NOW(), TRUE),
(6, 6, 5, 'Best jeans ever', 'Perfect fit, great quality denim. These are my go-to jeans now.', 67, NOW() - INTERVAL '10 days', NOW(), TRUE),
(7, 7, 4, 'Warm and stylish', 'The jacket keeps me warm and looks great. Highly satisfied with the purchase.', 44, NOW() - INTERVAL '8 days', NOW(), TRUE),
(9, 8, 5, 'Must-read for programmers', 'An absolute must-read book for anyone interested in programming. Very well written.', 89, NOW() - INTERVAL '5 days', NOW(), TRUE),
(9, 1, 4, 'Comprehensive guide', 'Great resource for learning programming concepts. Some examples could be more practical.', 31, NOW() - INTERVAL '3 days', NOW(), TRUE),
(14, 2, 5, 'Love this yoga mat', 'Excellent quality yoga mat. Non-slip surface is perfect for my practice.', 55, NOW() - INTERVAL '7 days', NOW(), TRUE),
(15, 3, 5, 'Great camping tent', 'Sturdy tent with good weather protection. Easy to set up. Highly recommend!', 73, NOW() - INTERVAL '6 days', NOW(), TRUE),
(4, 4, 4, 'Good portable charger', 'Fast charging and good capacity. Works as expected.', 29, NOW() - INTERVAL '4 days', NOW(), TRUE);

-- Insert Orders
INSERT INTO orders (user_id, order_date, total_amount, shipping_address, order_status, tracking_number, created_date, updated_date, active) VALUES
(1, NOW() - INTERVAL '30 days', 259.98, '123 Main St, New York, NY 10001, USA', 'delivered', 'TRACK001234567', NOW() - INTERVAL '30 days', NOW() - INTERVAL '25 days', TRUE),
(2, NOW() - INTERVAL '20 days', 189.98, '456 Oak Ave, Los Angeles, CA 90001, USA', 'delivered', 'TRACK001234568', NOW() - INTERVAL '20 days', NOW() - INTERVAL '15 days', TRUE),
(3, NOW() - INTERVAL '15 days', 79.98, '789 Pine Rd, Chicago, IL 60601, USA', 'shipped', 'TRACK001234569', NOW() - INTERVAL '15 days', NOW() - INTERVAL '10 days', TRUE),
(4, NOW() - INTERVAL '10 days', 169.98, '321 Elm St, Houston, TX 77001, USA', 'delivered', 'TRACK001234570', NOW() - INTERVAL '10 days', NOW() - INTERVAL '5 days', TRUE),
(5, NOW() - INTERVAL '7 days', 349.97, '654 Maple Dr, Phoenix, AZ 85001, USA', 'processing', 'TRACK001234571', NOW() - INTERVAL '7 days', NOW() - INTERVAL '2 days', TRUE),
(6, NOW() - INTERVAL '5 days', 129.99, '987 Cedar Ln, Philadelphia, PA 19101, USA', 'shipped', 'TRACK001234572', NOW() - INTERVAL '5 days', NOW() - INTERVAL '1 days', TRUE),
(7, NOW() - INTERVAL '2 days', 299.98, '135 Birch Ave, San Antonio, TX 78201, USA', 'processing', 'TRACK001234573', NOW() - INTERVAL '2 days', NOW(), TRUE),
(8, NOW() - INTERVAL '1 days', 159.98, '246 Ash St, San Diego, CA 92101, USA', 'pending', NULL, NOW() - INTERVAL '1 days', NOW(), TRUE);

-- Insert Order Items
INSERT INTO order_items (order_id, item_id, variant_id, quantity, unit_price, created_date, updated_date, active) VALUES
(1, 1, NULL, 2, 129.99, NOW() - INTERVAL '30 days', NOW(), TRUE),
(2, 5, 1, 1, 19.99, NOW() - INTERVAL '20 days', NOW(), TRUE),
(2, 6, 4, 1, 59.99, NOW() - INTERVAL '20 days', NOW(), TRUE),
(2, 2, NULL, 2, 24.99, NOW() - INTERVAL '20 days', NOW(), TRUE),
(3, 9, NULL, 1, 45.99, NOW() - INTERVAL '15 days', NOW(), TRUE),
(3, 10, NULL, 1, 34.99, NOW() - INTERVAL '15 days', NOW(), TRUE),
(4, 7, NULL, 1, 149.99, NOW() - INTERVAL '10 days', NOW(), TRUE),
(4, 4, NULL, 1, 39.99, NOW() - INTERVAL '10 days', NOW(), TRUE),
(5, 8, 8, 1, 89.99, NOW() - INTERVAL '7 days', NOW(), TRUE),
(5, 14, NULL, 1, 39.99, NOW() - INTERVAL '7 days', NOW(), TRUE),
(5, 15, NULL, 1, 119.99, NOW() - INTERVAL '7 days', NOW(), TRUE),
(6, 1, NULL, 1, 129.99, NOW() - INTERVAL '5 days', NOW(), TRUE),
(7, 3, NULL, 1, 199.99, NOW() - INTERVAL '2 days', NOW(), TRUE),
(7, 12, NULL, 1, 22.99, NOW() - INTERVAL '2 days', NOW(), TRUE),
(8, 16, NULL, 1, 89.99, NOW() - INTERVAL '1 days', NOW(), TRUE),
(8, 11, NULL, 1, 29.99, NOW() - INTERVAL '1 days', NOW(), TRUE);

-- Insert Payments
INSERT INTO payments (order_id, payment_method, amount, payment_status, transaction_id, card_last_four, created_date, updated_date, active) VALUES
(1, 'Credit Card', 259.98, 'completed', 'TXN20260415001', '4532', NOW() - INTERVAL '30 days', NOW() - INTERVAL '25 days', TRUE),
(2, 'Credit Card', 189.98, 'completed', 'TXN20260425002', '5412', NOW() - INTERVAL '20 days', NOW() - INTERVAL '15 days', TRUE),
(3, 'Debit Card', 79.98, 'completed', 'TXN20260430003', '6011', NOW() - INTERVAL '15 days', NOW() - INTERVAL '10 days', TRUE),
(4, 'Credit Card', 169.98, 'completed', 'TXN20260505004', '3782', NOW() - INTERVAL '10 days', NOW() - INTERVAL '5 days', TRUE),
(5, 'PayPal', 349.97, 'completed', 'TXN20260508005', NULL, NOW() - INTERVAL '7 days', NOW() - INTERVAL '2 days', TRUE),
(6, 'Credit Card', 129.99, 'completed', 'TXN20260510006', '4929', NOW() - INTERVAL '5 days', NOW() - INTERVAL '1 days', TRUE),
(7, 'Credit Card', 299.98, 'pending', 'TXN20260513007', '5678', NOW() - INTERVAL '2 days', NOW(), TRUE),
(8, 'Debit Card', 159.98, 'pending', 'TXN20260514008', '9876', NOW() - INTERVAL '1 days', NOW(), TRUE);
