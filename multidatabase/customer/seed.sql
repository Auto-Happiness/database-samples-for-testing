-- Customer Service Database Schema and Seed Data for PostgreSQL

-- 1. Create Tables
CREATE TABLE customer_type (
    id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    discount_percentage NUMERIC(5,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(30),
    type_id INTEGER NOT NULL REFERENCES customer_type(id) ON DELETE RESTRICT,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_contacts (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    contact_type VARCHAR(50) NOT NULL,
    contact_value VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_address (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    address_type VARCHAR(50) NOT NULL,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'United States',
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_referral_links (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    referral_code VARCHAR(50) UNIQUE NOT NULL,
    link_url VARCHAR(255) UNIQUE NOT NULL,
    click_count INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_refferal_recruits (
    id SERIAL PRIMARY KEY,
    referral_link_id INTEGER NOT NULL REFERENCES customer_referral_links(id) ON DELETE CASCADE,
    referred_customer_id INTEGER UNIQUE NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    reward_points_awarded INTEGER DEFAULT 0,
    conversion_status VARCHAR(50) DEFAULT 'signed_up' CHECK (conversion_status IN ('signed_up', 'purchased', 'expired')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes for optimization
CREATE INDEX idx_customer_email ON customer(email);
CREATE INDEX idx_customer_type ON customer(type_id);
CREATE INDEX idx_customer_contacts_customer ON customer_contacts(customer_id);
CREATE INDEX idx_customer_address_customer ON customer_address(customer_id);
CREATE INDEX idx_referral_links_customer ON customer_referral_links(customer_id);
CREATE INDEX idx_referral_recruits_link ON customer_refferal_recruits(referral_link_id);
CREATE INDEX idx_referral_recruits_referred ON customer_refferal_recruits(referred_customer_id);

-- 2. Seed Data
-- Seed customer_type (20 records)
INSERT INTO customer_type (id, type_name, description, discount_percentage) VALUES
(1, 'Standard', 'Regular retail customer with standard benefits.', 0.00),
(2, 'Premium', 'Premium tier customer with minor perks.', 5.00),
(3, 'VIP', 'VIP loyalty customer with advanced support and pricing.', 10.00),
(4, 'Platinum VIP', 'High tier VIP customer with custom support access.', 15.00),
(5, 'Enterprise', 'Corporate commercial accounts under bulk agreements.', 20.00),
(6, 'Wholesale', 'Bulk distributor and wholesaler client tier.', 25.00),
(7, 'Non-Profit', 'Verified tax-exempt charitable organisations.', 12.00),
(8, 'Government', 'Public administration and federal department bodies.', 8.00),
(9, 'Educational', 'Schools, universities, and education staff.', 10.00),
(10, 'Employee', 'Internal staff and personnel discount tier.', 30.00),
(11, 'Beta-Tester', 'Early product testers and tech community members.', 5.00),
(12, 'Affiliate Partner', 'Content publishers and affiliate network accounts.', 10.00),
(13, 'Distributor', 'Local regional product distributor accounts.', 18.00),
(14, 'Legacy Loyalty', 'Customers registered prior to 2022 with grandfathered rates.', 7.50),
(15, 'Student', 'Verified active higher-education student tier.', 15.00),
(16, 'Senior Citizens', 'Senior citizen benefit discount tier (65+).', 12.00),
(17, 'Military Personnel', 'Armed forces active personnel and veteran tier.', 15.00),
(18, 'Corporate SME', 'Small to medium size business client accounts.', 10.00),
(19, 'Startup Hub', 'Incubator program members and startup participants.', 12.50),
(20, 'Reseller', 'Standard retail reseller and dropship client accounts.', 15.00);

-- Seed customer (40 records: 20 referrers, 20 referred recruits)
INSERT INTO customer (id, first_name, last_name, email, phone, type_id, status) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '+1-555-0101', 1, 'active'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '+1-555-0102', 2, 'active'),
(3, 'Robert', 'Johnson', 'robert.j@example.com', '+1-555-0103', 3, 'active'),
(4, 'Emily', 'Davis', 'emily.davis@example.com', '+1-555-0104', 1, 'active'),
(5, 'Michael', 'Brown', 'michael.b@example.com', '+1-555-0105', 4, 'active'),
(6, 'Linda', 'Miller', 'linda.m@example.com', '+1-555-0106', 5, 'active'),
(7, 'William', 'Wilson', 'william.w@example.com', '+1-555-0107', 6, 'active'),
(8, 'David', 'Moore', 'david.moore@example.com', '+1-555-0108', 7, 'active'),
(9, 'Richard', 'Taylor', 'richard.t@example.com', '+1-555-0109', 8, 'active'),
(10, 'Joseph', 'Anderson', 'joseph.a@example.com', '+1-555-0110', 9, 'active'),
(11, 'Thomas', 'Thomas', 'thomas.t@example.com', '+1-555-0111', 10, 'active'),
(12, 'Charles', 'Jackson', 'charles.j@example.com', '+1-555-0112', 11, 'active'),
(13, 'Christopher', 'White', 'chris.white@example.com', '+1-555-0113', 12, 'active'),
(14, 'Daniel', 'Harris', 'daniel.h@example.com', '+1-555-0114', 13, 'active'),
(15, 'Matthew', 'Martin', 'matthew.m@example.com', '+1-555-0115', 14, 'active'),
(16, 'Anthony', 'Thompson', 'anthony.t@example.com', '+1-555-0116', 15, 'active'),
(17, 'Mark', 'Garcia', 'mark.g@example.com', '+1-555-0117', 16, 'active'),
(18, 'Donald', 'Martinez', 'donald.m@example.com', '+1-555-0118', 17, 'active'),
(19, 'Steven', 'Robinson', 'steven.r@example.com', '+1-555-0119', 18, 'active'),
(20, 'Paul', 'Clark', 'paul.clark@example.com', '+1-555-0120', 19, 'active'),
(21, 'Andrew', 'Rodriguez', 'andrew.r@example.com', '+1-555-0121', 1, 'active'),
(22, 'Joshua', 'Lewis', 'joshua.l@example.com', '+1-555-0122', 1, 'active'),
(23, 'Kenneth', 'Lee', 'kenneth.l@example.com', '+1-555-0123', 2, 'active'),
(24, 'Kevin', 'Walker', 'kevin.w@example.com', '+1-555-0124', 2, 'active'),
(25, 'Brian', 'Hall', 'brian.h@example.com', '+1-555-0125', 1, 'active'),
(26, 'George', 'Allen', 'george.a@example.com', '+1-555-0126', 15, 'active'),
(27, 'Edward', 'Young', 'edward.y@example.com', '+1-555-0127', 15, 'active'),
(28, 'Ronald', 'Hernandez', 'ronald.h@example.com', '+1-555-0128', 1, 'active'),
(29, 'Timothy', 'King', 'timothy.k@example.com', '+1-555-0129', 14, 'active'),
(30, 'Jason', 'Wright', 'jason.w@example.com', '+1-555-0130', 1, 'active'),
(31, 'Jeffrey', 'Lopez', 'jeffrey.l@example.com', '+1-555-0131', 11, 'active'),
(32, 'Ryan', 'Hill', 'ryan.hill@example.com', '+1-555-0132', 1, 'active'),
(33, 'Jacob', 'Scott', 'jacob.s@example.com', '+1-555-0133', 2, 'active'),
(34, 'Gary', 'Green', 'gary.g@example.com', '+1-555-0134', 1, 'active'),
(35, 'Nicholas', 'Adams', 'nicholas.a@example.com', '+1-555-0135', 14, 'suspended'),
(36, 'Eric', 'Baker', 'eric.b@example.com', '+1-555-0136', 1, 'active'),
(37, 'Jonathan', 'Gonzalez', 'jon.g@example.com', '+1-555-0137', 1, 'inactive'),
(38, 'Stephen', 'Nelson', 'stephen.n@example.com', '+1-555-0138', 1, 'active'),
(39, 'Larry', 'Carter', 'larry.c@example.com', '+1-555-0139', 2, 'active'),
(40, 'Justin', 'Mitchell', 'justin.m@example.com', '+1-555-0140', 20, 'active');

-- Seed customer_contacts (25 records)
INSERT INTO customer_contacts (id, customer_id, contact_type, contact_value, is_primary) VALUES
(1, 1, 'email_work', 'john.doe.corp@company.com', false),
(2, 1, 'phone_home', '+1-555-1001', false),
(3, 2, 'email_billing', 'smith.billing@example.com', false),
(4, 3, 'slack_handle', '@robert_johnson', false),
(5, 5, 'email_work', 'mbrown@enterprise.org', false),
(6, 6, 'phone_work', '+1-555-6001', false),
(7, 7, 'email_purchasing', 'wholesale.procurement@example.com', false),
(8, 8, 'phone_mobile', '+1-555-8001', false),
(9, 10, 'email_edu', 'janderson@university.edu', false),
(10, 11, 'phone_office', '+1-555-1101', false),
(11, 13, 'phone_pager', '+1-555-1313', false),
(12, 15, 'email_backup', 'matt.m.personal@example.com', false),
(13, 17, 'phone_spouse', '+1-555-1717', false),
(14, 18, 'email_work', 'donald.m@military.mil', false),
(15, 20, 'slack_handle', '@paul_clark_tech', false),
(16, 21, 'phone_mobile', '+1-555-2121', false),
(17, 22, 'email_personal', 'joshua.lewis99@gmail.com', false),
(18, 25, 'email_billing', 'brian.hall.billing@example.com', false),
(19, 27, 'phone_parents', '+1-555-2727', false),
(20, 29, 'email_old', 'tim.k.grandfathered@oldnet.org', false),
(21, 31, 'phone_mobile', '+1-555-3131', false),
(22, 33, 'phone_work', '+1-555-3333', false),
(23, 35, 'email_guardian', 'adams.guardian@example.com', false),
(24, 37, 'phone_home', '+1-555-3737', false),
(25, 40, 'email_partner', 'mitchell.dropship@reseller.net', false);

-- Seed customer_address (25 records)
INSERT INTO customer_address (id, customer_id, address_type, address_line1, address_line2, city, state, postal_code, country, is_default) VALUES
(1, 1, 'shipping', '123 Elm St', 'Apt 4B', 'Springfield', 'IL', '62701', 'United States', true),
(2, 2, 'shipping', '456 Oak Ave', NULL, 'Seattle', 'WA', '98101', 'United States', true),
(3, 2, 'billing', '789 Pine Rd', 'Suite 100', 'Bellevue', 'WA', '98004', 'United States', false),
(4, 3, 'billing', '321 Maple Dr', NULL, 'Austin', 'TX', '78701', 'United States', true),
(5, 5, 'office', '500 Enterprise Way', 'Floor 12', 'San Jose', 'CA', '95110', 'United States', true),
(6, 6, 'warehouse', '900 Wholesale Blvd', 'Dock 3', 'Dallas', 'TX', '75201', 'United States', true),
(7, 8, 'home', '101 Birch Ln', NULL, 'Denver', 'CO', '80201', 'United States', true),
(8, 10, 'office', '400 University Ave', 'Science Hall', 'Boston', 'MA', '02108', 'United States', true),
(9, 12, 'home', '202 Cedar Pl', NULL, 'Phoenix', 'AZ', '85001', 'United States', true),
(10, 14, 'shipping', '888 Distributor Rd', 'Unit C', 'Atlanta', 'GA', '30301', 'United States', true),
(11, 16, 'home', '303 Spruce St', NULL, 'Portland', 'OR', '97201', 'United States', true),
(12, 18, 'billing', '100 Military Plaza', 'Barracks A', 'San Diego', 'CA', '92101', 'United States', true),
(13, 20, 'office', '600 Tech Startup Rd', 'Suite 5', 'New York', 'NY', '10001', 'United States', true),
(14, 21, 'home', '404 Walnut Ave', NULL, 'Miami', 'FL', '33101', 'United States', true),
(15, 23, 'shipping', '505 Cherry Dr', NULL, 'Detroit', 'MI', '48201', 'United States', true),
(16, 24, 'billing', '606 Ash Ln', NULL, 'Minneapolis', 'MN', '55401', 'United States', true),
(17, 26, 'dorm', '707 Student Union Dr', 'Room 304', 'Columbus', 'OH', '43210', 'United States', true),
(18, 28, 'home', '808 Redwood Hwy', NULL, 'San Francisco', 'CA', '94101', 'United States', true),
(19, 30, 'home', '909 Willow Way', NULL, 'Nashville', 'TN', '37201', 'United States', true),
(20, 32, 'shipping', '111 Cypress St', NULL, 'Orlando', 'FL', '32801', 'United States', true),
(21, 34, 'home', '222 Poplar Rd', NULL, 'Salt Lake City', 'UT', '84101', 'United States', true),
(22, 36, 'billing', '333 Alder Ln', NULL, 'Indianapolis', 'IN', '46201', 'United States', true),
(23, 38, 'home', '444 Magnolia Ct', NULL, 'Charlotte', 'NC', '28201', 'United States', true),
(24, 39, 'billing', '555 Sycamore St', NULL, 'Richmond', 'VA', '23219', 'United States', true),
(25, 40, 'office', '777 Reseller Row', 'Building B', 'Las Vegas', 'NV', '89101', 'United States', true);

-- Seed customer_referral_links (20 records, created by customers 1 to 20)
INSERT INTO customer_referral_links (id, customer_id, referral_code, link_url, click_count, is_active) VALUES
(1, 1, 'JOHNDOE10', 'https://orcha.io/ref/JOHNDOE10', 42, true),
(2, 2, 'JANESMITH5', 'https://orcha.io/ref/JANESMITH5', 128, true),
(3, 3, 'ROBJOHNSON', 'https://orcha.io/ref/ROBJOHNSON', 15, true),
(4, 4, 'EMILYD15', 'https://orcha.io/ref/EMILYD15', 3, true),
(5, 5, 'MBROWNENTERPRISE', 'https://orcha.io/ref/MBROWNENTERPRISE', 1050, true),
(6, 6, 'LINDAMILLERWHOLE', 'https://orcha.io/ref/LINDAMILLERWHOLE', 80, true),
(7, 7, 'WWILSON_DIST', 'https://orcha.io/ref/WWILSON_DIST', 211, true),
(8, 8, 'DAVIDMOORE77', 'https://orcha.io/ref/DAVIDMOORE77', 4, true),
(9, 9, 'RTAYLOR_GOV', 'https://orcha.io/ref/RTAYLOR_GOV', 0, true),
(10, 10, 'JANDERSON_EDU', 'https://orcha.io/ref/JANDERSON_EDU', 12, true),
(11, 11, 'THOMAST_STAFF', 'https://orcha.io/ref/THOMAST_STAFF', 29, true),
(12, 12, 'CHARLESA_BETA', 'https://orcha.io/ref/CHARLESA_BETA', 99, true),
(13, 13, 'CHRISWHITE_AFFIL', 'https://orcha.io/ref/CHRISWHITE_AFFIL', 814, true),
(14, 14, 'DANIELH_REGIONAL', 'https://orcha.io/ref/DANIELH_REGIONAL', 16, true),
(15, 15, 'MATTHEWM_LEGACY', 'https://orcha.io/ref/MATTHEWM_LEGACY', 5, true),
(16, 16, 'ANTHONYT_STUDENT', 'https://orcha.io/ref/ANTHONYT_STUDENT', 57, true),
(17, 17, 'MARKG_SENIOR', 'https://orcha.io/ref/MARKG_SENIOR', 8, true),
(18, 18, 'DONALDM_MILITARY', 'https://orcha.io/ref/DONALDM_MILITARY', 145, true),
(19, 19, 'STEVENR_SME', 'https://orcha.io/ref/STEVENR_SME', 23, true),
(20, 20, 'PAULCLARK_STARTUP', 'https://orcha.io/ref/PAULCLARK_STARTUP', 310, true);

-- Seed customer_refferal_recruits (20 records, recruiting customers 21 to 40)
INSERT INTO customer_refferal_recruits (id, referral_link_id, referred_customer_id, reward_points_awarded, conversion_status) VALUES
(1, 1, 21, 100, 'purchased'),
(2, 2, 22, 50, 'purchased'),
(3, 2, 23, 50, 'purchased'),
(4, 3, 24, 250, 'purchased'),
(5, 5, 25, 500, 'purchased'),
(6, 6, 26, 0, 'signed_up'),
(7, 7, 27, 200, 'purchased'),
(8, 10, 28, 100, 'purchased'),
(9, 11, 29, 0, 'expired'),
(10, 12, 30, 50, 'purchased'),
(11, 13, 31, 150, 'purchased'),
(12, 13, 32, 150, 'purchased'),
(13, 14, 33, 0, 'signed_up'),
(14, 15, 34, 100, 'purchased'),
(15, 16, 35, 0, 'expired'),
(16, 18, 36, 100, 'purchased'),
(17, 18, 37, 0, 'signed_up'),
(18, 19, 38, 100, 'purchased'),
(19, 20, 39, 250, 'purchased'),
(20, 20, 40, 250, 'purchased');

-- Reset sequences for proper auto-increment behaviour
SELECT setval('customer_type_id_seq', 20);
SELECT setval('customer_id_seq', 40);
SELECT setval('customer_contacts_id_seq', 25);
SELECT setval('customer_address_id_seq', 25);
SELECT setval('customer_referral_links_id_seq', 20);
SELECT setval('customer_refferal_recruits_id_seq', 20);
