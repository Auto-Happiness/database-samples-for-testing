-- Reviews Service Database Schema and Seed Data for PostgreSQL

-- 1. Create Tables
CREATE TABLE customer_review (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,            -- Logical FK to customer service customer table
    item_id INTEGER NOT NULL,                -- Logical FK to items service item table
    order_id INTEGER NULL,                   -- Logical FK to orders service order table
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255) NOT NULL,
    comment TEXT,
    is_verified_purchase BOOLEAN DEFAULT TRUE,
    helpful_votes INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'approved' CHECK (status IN ('pending', 'approved', 'rejected', 'flagged')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes for fast query capabilities
CREATE INDEX idx_customer_review_customer ON customer_review(customer_id);
CREATE INDEX idx_customer_review_item ON customer_review(item_id);
CREATE INDEX idx_customer_review_order ON customer_review(order_id);
CREATE INDEX idx_customer_review_rating ON customer_review(rating);

-- 2. Seed Data
-- Seed customer_review (25 records: 20 verified purchases matching orders, 5 unverified reviews)
INSERT INTO customer_review (id, customer_id, item_id, order_id, rating, title, comment, is_verified_purchase, helpful_votes, status) VALUES
-- Customer 1 reviews (Verified Purchases matching their actual orders)
(1, 1, 1, 1, 5, 'Amazing phone, premium feel!', 'The titanium finish feels incredible in the hand. The camera is a huge step up from my previous phone. Extremely fast and the display is gorgeous!', true, 12, 'approved'),
(2, 1, 2, 2, 4, 'Very comfortable, but runs slightly small', 'Super soft inside and very warm. I ordered a medium and it fits a bit snug, so you might want to size up if you prefer a loose fit.', true, 3, 'approved'),
(3, 1, 3, 3, 5, 'Life-changing advice!', 'James Clear makes building good habits so simple and practical. Highly recommend this to anyone looking to improve their daily routines.', true, 24, 'approved'),
(4, 1, 5, 5, 5, 'Best board game ever!', 'Excellent game for family game nights. Strategic, engaging, and has high replay value. Highly recommended!', true, 4, 'approved'),
(5, 1, 7, 6, 4, 'Excellent serum, very hydrating', 'This serum leaves my skin feeling super soft and plump. The consistency is great and absorbs quickly. Dropped a star because of minor pump issues.', true, 7, 'approved'),
(6, 1, 9, 7, 5, 'Saved me a trip to the mechanic', 'Simple to plug in, read the check engine light code instantly. Looked it up, fixed a loose sensor myself, and saved hundreds. Highly recommend keeping one in the car.', true, 32, 'approved'),
(7, 1, 10, 8, 5, 'Powerful drill and fantastic value', 'This drill handles drywall, wood, and metal with ease. The battery life is impressive and the charger is super fast. Extremely happy with the purchase.', true, 15, 'approved'),

-- Customer 2 reviews (Verified Purchases)
(8, 2, 2, 11, 5, 'Perfect hoodie!', 'Excellent quality! Has survived multiple washes without shrinking or losing color. Love the jet black color and standard fit.', true, 8, 'approved'),
(9, 2, 8, 12, 4, 'Great grip, nice thickness', 'The 6mm thickness is perfect for my knees during yoga sessions. Non-slip texture works well even when sweating. Smelled a bit plasticky at first but cleared up after a day.', true, 15, 'approved'),

-- Customer 3 reviews (Verified Purchases)
(10, 3, 3, 14, 5, 'A must-read for everyone', 'One of the best self-help books I have ever read. The concepts of tiny gains and identity-based habits are brilliant.', true, 10, 'approved'),
(11, 3, 4, 15, 5, 'Clean, organic, and delicious', 'Excellent quality oats! They cook beautifully and make for a super creamy morning oatmeal. Great price for organic.', true, 2, 'approved'),

-- Customer 5 reviews (Verified Purchases)
(12, 5, 1, 17, 5, 'Worth every penny', 'Upgraded after three years and the difference is massive. Extremely fast, beautiful screen, and battery life easily lasts a day and a half.', true, 7, 'approved'),
(13, 5, 18, 18, 4, 'Essential office suite, easy activation', 'Activation was smooth. Hard to go wrong with Microsoft Office. I use Excel and Word daily, and the cloud sync is flawless.', true, 1, 'approved'),

-- Customer 10 reviews (Verified Purchases)
(14, 10, 14, 20, 5, 'High quality supplement', 'Small, easy-to-swallow softgels. Checked my blood levels after 2 months of use and they are back in the optimal range!', true, 4, 'approved'),

-- Other customer verified reviews
(15, 4, 6, 23, 5, 'An absolute kitchen workhorse!', 'Lodge cast iron is legendary for a reason. Pre-seasoned and ready to go. I use it for searing steaks, baking cornbread, and frying eggs.', true, 31, 'approved'),
(16, 6, 8, 24, 5, 'Very happy with this purchase', 'Love the alignment marks, they really help me correct my posture during yoga. Excellent value and durable.', true, 6, 'approved'),
(17, 8, 11, 25, 5, 'My golden retriever loves it!', 'The orthopedic foam is very supportive. As soon as I unboxed it and let it expand, my dog hopped on and fell asleep. The cover is easy to wash too!', true, 18, 'approved'),
(18, 12, 13, 26, 3, 'Decent lights, but not very bright', 'They look great in the garden and stay lit for about 5-6 hours after a sunny day. However, they are more for ambiance than actual illumination.', true, 9, 'approved'),
(19, 14, 15, 27, 5, 'Top-tier safety and comfort', 'Installing this was surprisingly straightforward. Feels extremely secure and sturdy. My toddler looks very comfortable and falls asleep easily.', true, 11, 'approved'),
(20, 16, 16, 28, 5, 'Elegant and classic timepiece', 'Gorgeous watch that looks much more expensive than it is. Keeps perfect time and goes well with both casual and formal wear.', true, 5, 'approved'),

-- Organic, Unverified Reviews (is_verified_purchase = false, order_id = null)
(21, 7, 1, NULL, 2, 'Too expensive for minor upgrades', 'Played around with it in the store. While the titanium frame is light, there is barely any difference from the 14 Pro. Definitely not worth the high price tag.', false, 43, 'approved'),
(22, 15, 3, NULL, 3, 'Good ideas but repetitive', 'The core ideas are excellent and can be summarized in a blog post, but the book repeats them over and over. Still worth reading if you need the reinforcement.', false, 22, 'approved'),
(23, 22, 5, NULL, 5, 'The ultimate gateway board game!', 'If you want to introduce friends to modern board games, this is the one. Easy to learn, highly strategic, and every game is different.', false, 16, 'approved'),
(24, 35, 6, NULL, 5, 'Essential for any kitchen', 'My family has used Lodge pans for generations. Once you learn how to clean and season them, they last forever. Throw away your non-stick pans!', false, 37, 'approved'),
(25, 40, 11, NULL, 1, 'My dog chewed it to pieces in an hour', 'Advertised as durable, but the cover was shredded by my lab in less than an hour. Do not buy if your dog likes to chew.', false, 55, 'approved');

-- Reset sequence for proper auto-increment behaviour
SELECT setval('customer_review_id_seq', 25);
