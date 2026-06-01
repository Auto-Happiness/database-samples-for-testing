SET DEFINE OFF;
-- Models Database Schema for Oracle
-- Creates tables for managing modeling agency data with one-to-many relationships

-- Drop existing schema user if exists
BEGIN
  EXECUTE IMMEDIATE 'DROP USER models_schema CASCADE';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE USER models_schema IDENTIFIED BY models123;
GRANT UNLIMITED TABLESPACE TO models_schema;

-- Grant necessary privileges to the schema user
GRANT CREATE SESSION TO models_schema;
GRANT CREATE TABLE TO models_schema;
GRANT CREATE SEQUENCE TO models_schema;
GRANT CREATE TRIGGER TO models_schema;
GRANT CREATE PROCEDURE TO models_schema;

-- Connect as the new schema user
CONNECT models_schema/models123@//localhost:1521/FREEPDB1;

-- Drop tables if they exist (in reverse order of dependencies)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE earnings';
  EXECUTE IMMEDIATE 'DROP TABLE education';
  EXECUTE IMMEDIATE 'DROP TABLE occupation';
  EXECUTE IMMEDIATE 'DROP TABLE talents';
  EXECUTE IMMEDIATE 'DROP TABLE model_contacts';
  EXECUTE IMMEDIATE 'DROP TABLE models';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Create MODELS table (Main table)
CREATE TABLE models (
  model_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(50) NOT NULL,
  last_name VARCHAR2(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR2(10) NOT NULL,
  height_cm NUMBER,
  weight_kg NUMBER,
  eye_color VARCHAR2(20),
  hair_color VARCHAR2(20),
  image VARCHAR2(500),
  bio VARCHAR2(500),
  created_date DATE DEFAULT SYSDATE
);

-- Create MODEL_CONTACTS table (One-to-Many with models)
CREATE TABLE model_contacts (
  contact_id NUMBER PRIMARY KEY,
  model_id NUMBER NOT NULL,
  contact_type VARCHAR2(50) NOT NULL, -- Email, Phone, Address, Social Media
  contact_value VARCHAR2(200) NOT NULL,
  is_primary CHAR(1) DEFAULT 'N',
  CONSTRAINT fk_contacts_models FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- Create TALENTS table (One-to-Many with models)
CREATE TABLE talents (
  talent_id NUMBER PRIMARY KEY,
  model_id NUMBER NOT NULL,
  talent_name VARCHAR2(100) NOT NULL,
  proficiency_level VARCHAR2(20), -- Beginner, Intermediate, Advanced, Expert
  years_of_experience NUMBER,
  certification VARCHAR2(200),
  CONSTRAINT fk_talents_models FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- Create OCCUPATION table (One-to-Many with models)
CREATE TABLE occupation (
  occupation_id NUMBER PRIMARY KEY,
  model_id NUMBER NOT NULL,
  occupation_title VARCHAR2(100) NOT NULL,
  occupation_type VARCHAR2(50), -- Runway, Commercial, Print, Tv, Social Media, etc.
  specialization VARCHAR2(200),
  start_date DATE,
  end_date DATE,
  CONSTRAINT fk_occupation_models FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- Create EDUCATION table (One-to-Many with models)
CREATE TABLE education (
  education_id NUMBER PRIMARY KEY,
  model_id NUMBER NOT NULL,
  school_name VARCHAR2(150) NOT NULL,
  degree VARCHAR2(100),
  field_of_study VARCHAR2(100),
  graduation_year NUMBER,
  CONSTRAINT fk_education_models FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- Create EARNINGS table (One-to-Many with models)
CREATE TABLE earnings (
  earning_id NUMBER PRIMARY KEY,
  model_id NUMBER NOT NULL,
  earning_amount NUMBER(10,2) NOT NULL,
  earning_date DATE NOT NULL,
  project_name VARCHAR2(200),
  payment_method VARCHAR2(50),
  status VARCHAR2(20), -- Pending, Completed, Paid
  CONSTRAINT fk_earnings_models FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- Create Sequences for auto-increment
CREATE SEQUENCE seq_model_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_contact_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_talent_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_occupation_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_education_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_earning_id START WITH 1 INCREMENT BY 1;

-- Insert 20+ Model Records
INSERT INTO models VALUES (1, 'Sophia', 'Anderson', TO_DATE('1998-05-15', 'YYYY-MM-DD'), 'Female', 173, 55, 'Blue', 'Blonde', NULL, 'Professional runway model with 5 years experience', SYSDATE);
INSERT INTO models VALUES (2, 'Isabella', 'Martinez', TO_DATE('2000-08-22', 'YYYY-MM-DD'), 'Female', 175, 56, 'Brown', 'Black', NULL, 'Commercial and print model', SYSDATE);
INSERT INTO models VALUES (3, 'Ada', 'Wong', TO_DATE('1999-03-10', 'YYYY-MM-DD'), 'Female', 171, 54, 'Green', 'Brown', 'https://i.pinimg.com/originals/70/cc/9d/70cc9dacf708a763aee5b8e417273c06.jpg', 'Fashion and beauty specialist', SYSDATE);
INSERT INTO models VALUES (4, 'Olivia', 'Davis', TO_DATE('2001-11-30', 'YYYY-MM-DD'), 'Female', 177, 57, 'Hazel', 'Auburn', NULL, 'Emerging talent in high fashion', SYSDATE);
INSERT INTO models VALUES (5, 'Charlotte', 'Wilson', TO_DATE('1998-07-12', 'YYYY-MM-DD'), 'Female', 172, 55, 'Blue', 'Dark Blonde', NULL, 'Experienced in editorial shoots', SYSDATE);
INSERT INTO models VALUES (6, 'Ava', 'Garcia', TO_DATE('2000-02-20', 'YYYY-MM-DD'), 'Female', 176, 58, 'Brown', 'Black', NULL, 'Bilingual model - English, Spanish', SYSDATE);
INSERT INTO models VALUES (7, 'Mia', 'Rodriguez', TO_DATE('1999-09-14', 'YYYY-MM-DD'), 'Female', 174, 56, 'Dark Brown', 'Black', NULL, 'Specialist in Latin American markets', SYSDATE);
INSERT INTO models VALUES (8, 'Amelia', 'Brown', TO_DATE('2001-04-05', 'YYYY-MM-DD'), 'Female', 170, 53, 'Green', 'Red', NULL, 'Rising star in commercial modeling', SYSDATE);
INSERT INTO models VALUES (9, 'Harper', 'Taylor', TO_DATE('1998-12-18', 'YYYY-MM-DD'), 'Female', 175, 57, 'Blue', 'Brunette', NULL, 'Expert in runway and haute couture', SYSDATE);
INSERT INTO models VALUES (10, 'Evelyn', 'Thompson', TO_DATE('2000-06-25', 'YYYY-MM-DD'), 'Female', 173, 55, 'Amber', 'Chestnut', NULL, 'Social media influencer model', SYSDATE);
INSERT INTO models VALUES (11, 'James', 'Miller', TO_DATE('1997-10-08', 'YYYY-MM-DD'), 'Male', 185, 75, 'Blue', 'Black', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_rz85z6CCpqZLcdx3if6A4TQmJA2yeSatsw&s', 'Professional male model, fashion focused', SYSDATE);
INSERT INTO models VALUES (12, 'Michael', 'White', TO_DATE('1999-05-20', 'YYYY-MM-DD'), 'Male', 182, 72, 'Brown', 'Brown', NULL, 'Commercial and TV advertisement model', SYSDATE);
INSERT INTO models VALUES (13, 'Daniel', 'Harris', TO_DATE('2000-08-12', 'YYYY-MM-DD'), 'Male', 188, 78, 'Hazel', 'Blonde', NULL, 'High fashion runway specialist', SYSDATE);
INSERT INTO models VALUES (14, 'Matthew', 'Clark', TO_DATE('1998-02-15', 'YYYY-MM-DD'), 'Male', 183, 74, 'Green', 'Dark Blonde', NULL, 'Print and editorial focused', SYSDATE);
INSERT INTO models VALUES (15, 'David', 'Lewis', TO_DATE('1999-11-22', 'YYYY-MM-DD'), 'Male', 186, 76, 'Blue', 'Black', NULL, 'Experienced in international campaigns', SYSDATE);
INSERT INTO models VALUES (16, 'Andrew', 'Walker', TO_DATE('2000-03-18', 'YYYY-MM-DD'), 'Male', 181, 71, 'Brown', 'Brown', NULL, 'Freelance model with diverse portfolio', SYSDATE);
INSERT INTO models VALUES (17, 'Christopher', 'Scott', TO_DATE('1998-07-30', 'YYYY-MM-DD'), 'Male', 184, 75, 'Green', 'Auburn', NULL, 'Commercial and brand modeling', SYSDATE);
INSERT INTO models VALUES (18, 'Ryan', 'Green', TO_DATE('2001-01-11', 'YYYY-MM-DD'), 'Male', 180, 70, 'Blue', 'Blonde', NULL, 'New talent with great potential', SYSDATE);
INSERT INTO models VALUES (19, 'Kevin', 'Adams', TO_DATE('1999-04-25', 'YYYY-MM-DD'), 'Male', 187, 77, 'Brown', 'Black', NULL, 'Athletic and fitness model', SYSDATE);
INSERT INTO models VALUES (20, 'Brian', 'Nelson', TO_DATE('1997-09-09', 'YYYY-MM-DD'), 'Male', 185, 75, 'Hazel', 'Dark Brown', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJMoFHd8ZyoLk_-f1zlChyhPqV_AU8ncEw8g&s', 'Senior model with extensive experience', SYSDATE);
INSERT INTO models VALUES (21, 'Jessica', 'Carter', TO_DATE('2000-10-14', 'YYYY-MM-DD'), 'Female', 172, 54, 'Blue', 'Blonde', NULL, 'Beauty and cosmetics specialist', SYSDATE);
INSERT INTO models VALUES (22, 'Michelle', 'Roberts', TO_DATE('1999-06-29', 'YYYY-MM-DD'), 'Female', 176, 58, 'Brown', 'Black', NULL, 'Fashion week regular', SYSDATE);

COMMIT;

-- Insert MODEL_CONTACTS (One-to-Many relationships)
-- Sophia Anderson
INSERT INTO model_contacts VALUES (1, 1, 'Email', 'sophia.anderson@email.com', 'Y');
INSERT INTO model_contacts VALUES (2, 1, 'Phone', '+1-555-0101', 'Y');
INSERT INTO model_contacts VALUES (3, 1, 'Instagram', '@sophiaandersson', 'N');
INSERT INTO model_contacts VALUES (4, 1, 'Address', '123 Fashion Street, New York, NY 10001', 'N');

-- Isabella Martinez
INSERT INTO model_contacts VALUES (5, 2, 'Email', 'isabella.martinez@email.com', 'Y');
INSERT INTO model_contacts VALUES (6, 2, 'Phone', '+1-555-0102', 'Y');
INSERT INTO model_contacts VALUES (7, 2, 'Instagram', '@isabellamartinez', 'N');

-- Emma Johnson
INSERT INTO model_contacts VALUES (8, 3, 'Email', 'emma.johnson@email.com', 'Y');
INSERT INTO model_contacts VALUES (9, 3, 'Phone', '+1-555-0103', 'Y');

-- Olivia Davis
INSERT INTO model_contacts VALUES (10, 4, 'Email', 'olivia.davis@email.com', 'Y');
INSERT INTO model_contacts VALUES (11, 4, 'Phone', '+1-555-0104', 'Y');
INSERT INTO model_contacts VALUES (12, 4, 'TikTok', '@oliviadavis_model', 'N');

-- Charlotte Wilson
INSERT INTO model_contacts VALUES (13, 5, 'Email', 'charlotte.wilson@email.com', 'Y');
INSERT INTO model_contacts VALUES (14, 5, 'Phone', '+1-555-0105', 'Y');

-- Ava Garcia
INSERT INTO model_contacts VALUES (15, 6, 'Email', 'ava.garcia@email.com', 'Y');
INSERT INTO model_contacts VALUES (16, 6, 'Phone', '+1-555-0106', 'Y');
INSERT INTO model_contacts VALUES (17, 6, 'Instagram', '@avagarciamodel', 'N');

-- James Miller
INSERT INTO model_contacts VALUES (18, 11, 'Email', 'james.miller@email.com', 'Y');
INSERT INTO model_contacts VALUES (19, 11, 'Phone', '+1-555-0111', 'Y');

-- Michael White
INSERT INTO model_contacts VALUES (20, 12, 'Email', 'michael.white@email.com', 'Y');
INSERT INTO model_contacts VALUES (21, 12, 'Phone', '+1-555-0112', 'Y');

COMMIT;

-- Insert TALENTS (One-to-Many relationships)
-- Sophia Anderson
INSERT INTO talents VALUES (1, 1, 'Runway Walking', 'Expert', 5, 'Fashion Week Certified');
INSERT INTO talents VALUES (2, 1, 'Photography', 'Advanced', 4, NULL);
INSERT INTO talents VALUES (3, 1, 'Public Speaking', 'Intermediate', 2, NULL);

-- Isabella Martinez
INSERT INTO talents VALUES (4, 2, 'Commercial Acting', 'Advanced', 3, 'SAG-AFTRA Member');
INSERT INTO talents VALUES (5, 2, 'Photography', 'Advanced', 3, NULL);
INSERT INTO talents VALUES (6, 2, 'Choreography', 'Intermediate', 2, NULL);

-- Emma Johnson
INSERT INTO talents VALUES (7, 3, 'Makeup Artistry', 'Expert', 6, 'Certified MUA');
INSERT INTO talents VALUES (8, 3, 'Hair Styling', 'Advanced', 4, NULL);
INSERT INTO talents VALUES (9, 3, 'Photography', 'Intermediate', 2, NULL);

-- Olivia Davis
INSERT INTO talents VALUES (10, 4, 'Video Presentation', 'Advanced', 2, NULL);
INSERT INTO talents VALUES (11, 4, 'Runway Walking', 'Advanced', 3, NULL);

-- Charlotte Wilson
INSERT INTO talents VALUES (12, 5, 'Editorial Modeling', 'Expert', 5, NULL);
INSERT INTO talents VALUES (13, 5, 'Photography', 'Advanced', 4, NULL);

-- James Miller
INSERT INTO talents VALUES (14, 11, 'Fashion Runway', 'Expert', 6, 'NYMFW Certified');
INSERT INTO talents VALUES (15, 11, 'Acting', 'Intermediate', 2, NULL);

-- Michael White
INSERT INTO talents VALUES (16, 12, 'Commercial Acting', 'Advanced', 4, NULL);
INSERT INTO talents VALUES (17, 12, 'Photography', 'Intermediate', 2, NULL);

-- Daniel Harris
INSERT INTO talents VALUES (18, 13, 'Runway', 'Expert', 5, NULL);
INSERT INTO talents VALUES (19, 13, 'Acting', 'Advanced', 3, NULL);

-- Matthew Clark
INSERT INTO talents VALUES (20, 14, 'Editorial Photography', 'Expert', 6, NULL);
INSERT INTO talents VALUES (21, 14, 'Runway', 'Advanced', 4, NULL);

-- Additional talents for other models
INSERT INTO talents VALUES (22, 6, 'Bilingual Presentation', 'Expert', 8, 'Fluent Spanish');
INSERT INTO talents VALUES (23, 7, 'Cultural Modeling', 'Advanced', 3, NULL);
INSERT INTO talents VALUES (24, 15, 'Brand Representation', 'Expert', 7, NULL);

COMMIT;

-- Insert OCCUPATION (One-to-Many relationships)
-- Sophia Anderson
INSERT INTO occupation VALUES (1, 1, 'Fashion Model', 'Runway', 'High Fashion, Luxury Brands', TO_DATE('2019-01-15', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (2, 1, 'Brand Ambassador', 'Commercial', 'Beauty Products', TO_DATE('2020-06-01', 'YYYY-MM-DD'), NULL);

-- Isabella Martinez
INSERT INTO occupation VALUES (3, 2, 'Commercial Model', 'Commercial', 'Advertising Campaigns', TO_DATE('2020-03-01', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (4, 2, 'Print Model', 'Print', 'Fashion Magazines', TO_DATE('2019-11-15', 'YYYY-MM-DD'), NULL);

-- Emma Johnson
INSERT INTO occupation VALUES (5, 3, 'Fashion Model', 'Runway', 'Mid-Range Brands', TO_DATE('2020-01-10', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (6, 3, 'Beauty Specialist', 'Commercial', 'Cosmetics', TO_DATE('2021-05-20', 'YYYY-MM-DD'), NULL);

-- Olivia Davis
INSERT INTO occupation VALUES (7, 4, 'Emerging Model', 'Runway', 'Emerging Designers', TO_DATE('2022-03-01', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (8, 4, 'Social Media Model', 'Social Media', 'Instagram', TO_DATE('2021-09-15', 'YYYY-MM-DD'), NULL);

-- Charlotte Wilson
INSERT INTO occupation VALUES (9, 5, 'Editorial Model', 'Print', 'Magazine Editorial', TO_DATE('2018-08-20', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (10, 5, 'Fashion Runway', 'Runway', 'Designer Collections', TO_DATE('2019-02-14', 'YYYY-MM-DD'), NULL);

-- James Miller
INSERT INTO occupation VALUES (11, 11, 'Fashion Model', 'Runway', 'Men Fashion Week', TO_DATE('2017-06-01', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (12, 11, 'Brand Model', 'Commercial', 'Men Apparel', TO_DATE('2019-01-15', 'YYYY-MM-DD'), NULL);

-- Michael White
INSERT INTO occupation VALUES (13, 12, 'Commercial Actor', 'Tv', 'TV Commercials', TO_DATE('2019-04-10', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (14, 12, 'Print Model', 'Print', 'Magazine Ads', TO_DATE('2020-08-05', 'YYYY-MM-DD'), NULL);

-- Daniel Harris
INSERT INTO occupation VALUES (15, 13, 'High Fashion Model', 'Runway', 'Luxury Brands', TO_DATE('2018-09-20', 'YYYY-MM-DD'), NULL);

-- Matthew Clark
INSERT INTO occupation VALUES (16, 14, 'Editorial Photographer', 'Print', 'Fashion Editorial', TO_DATE('2018-05-15', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (17, 14, 'Commercial Model', 'Commercial', 'Advertising', TO_DATE('2019-10-01', 'YYYY-MM-DD'), NULL);

-- Kevin Arnold
INSERT INTO occupation VALUES (18, 19, 'Athletic Model', 'Commercial', 'Sports Brand', TO_DATE('2020-02-18', 'YYYY-MM-DD'), NULL);
INSERT INTO occupation VALUES (19, 19, 'Fitness Influencer', 'Social Media', 'YouTube', TO_DATE('2021-03-10', 'YYYY-MM-DD'), NULL);

COMMIT;

-- Insert EDUCATION (One-to-Many relationships)
-- Sophia Anderson
INSERT INTO education VALUES (1, 1, 'New York Fashion Institute', 'Diploma', 'Fashion Design', 2016);
INSERT INTO education VALUES (2, 1, 'Fashion Academy NYC', 'Certificate', 'Runway Training', 2018);

-- Isabella Martinez
INSERT INTO education VALUES (3, 2, 'International School of Modeling', 'Certificate', 'Professional Modeling', 2019);
INSERT INTO education VALUES (4, 2, 'UCLA', 'Bachelor Degree', 'Communications', 2022);

-- Emma Johnson
INSERT INTO education VALUES (5, 3, 'School of Visual Arts', 'Diploma', 'Photography', 2015);
INSERT INTO education VALUES (6, 3, 'Makeup Artistry Institute', 'Certificate', 'Professional Makeup', 2017);
INSERT INTO education VALUES (7, 3, 'Beauty Academy', 'Certificate', 'Hair Design', 2017);

-- Olivia Davis
INSERT INTO education VALUES (8, 4, 'Fashion Institute of Technology', 'Certificate', 'Modeling', 2020);
INSERT INTO education VALUES (9, 4, 'Online Academy', 'Course', 'Social Media Marketing', 2021);

-- Charlotte Wilson
INSERT INTO education VALUES (10, 5, 'Elite Modeling Academy', 'Certificate', 'Professional Modeling', 2018);
INSERT INTO education VALUES (11, 5, 'Columbia University', 'Bachelor Degree', 'Communications', 2020);

-- Ava Garcia
INSERT INTO education VALUES (12, 6, 'International Modeling School', 'Certificate', 'Advanced Modeling', 2018);
INSERT INTO education VALUES (13, 6, 'Language Institute', 'Certificate', 'Spanish Language', 2015);

-- James Miller
INSERT INTO education VALUES (14, 11, 'Men Modeling Academy', 'Certificate', 'Men Fashion', 2017);
INSERT INTO education VALUES (15, 11, 'NYU Tisch', 'Bachelor Degree', 'Acting', 2019);

-- Michael White
INSERT INTO education VALUES (16, 12, 'Commercial Acting School', 'Certificate', 'Commercial Acting', 2018);
INSERT INTO education VALUES (17, 12, 'State University', 'Bachelor Degree', 'Business', 2021);

-- Daniel Harris
INSERT INTO education VALUES (18, 13, 'Fashion Academy', 'Diploma', 'High Fashion Modeling', 2017);
INSERT INTO education VALUES (19, 13, 'Drama School', 'Certificate', 'Acting Basics', 2019);

-- Matthew Clark
INSERT INTO education VALUES (20, 14, 'Photography Institute', 'Diploma', 'Professional Photography', 2016);
INSERT INTO education VALUES (21, 14, 'Fashion Business School', 'Bachelor Degree', 'Fashion Business', 2021);

-- Kevin Arnold
INSERT INTO education VALUES (22, 19, 'Fitness Academy', 'Certificate', 'Personal Training', 2018);
INSERT INTO education VALUES (23, 19, 'Sports Management School', 'Diploma', 'Sports Marketing', 2020);

COMMIT;

-- Insert EARNINGS (One-to-Many relationships)
-- Sophia Anderson
INSERT INTO earnings VALUES (1, 1, 5000.00, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Gucci Runway Show', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (2, 1, 3500.00, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'Vogue Magazine Photoshoot', 'Check', 'Paid');
INSERT INTO earnings VALUES (3, 1, 4200.00, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'Brand Endorsement - Skincare', 'Bank Transfer', 'Completed');
INSERT INTO earnings VALUES (4, 1, 2800.00, TO_DATE('2024-04-12', 'YYYY-MM-DD'), 'Local Brand Campaign', 'Check', 'Pending');

-- Isabella Martinez
INSERT INTO earnings VALUES (5, 2, 3000.00, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Commercial TV Shoot', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (6, 2, 2500.00, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Fashion Print Ad', 'Check', 'Paid');
INSERT INTO earnings VALUES (7, 2, 3800.00, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Magazine Feature', 'Bank Transfer', 'Completed');

-- Emma Johnson
INSERT INTO earnings VALUES (8, 3, 2200.00, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'Product Shoot', 'Check', 'Paid');
INSERT INTO earnings VALUES (9, 3, 2800.00, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 'Brand Campaign', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (10, 3, 3100.00, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Cosmetics Endorsement', 'Check', 'Completed');

-- Olivia Davis
INSERT INTO earnings VALUES (11, 4, 1500.00, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Emerging Designer Runway', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (12, 4, 2000.00, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Instagram Campaign', 'Check', 'Paid');
INSERT INTO earnings VALUES (13, 4, 2500.00, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'Social Media Collab', 'Bank Transfer', 'Completed');

-- Charlotte Wilson
INSERT INTO earnings VALUES (14, 5, 4500.00, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 'Vogue Editorial', 'Check', 'Paid');
INSERT INTO earnings VALUES (15, 5, 3200.00, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 'Designer Collection Show', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (16, 5, 3800.00, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'Magazine Cover Shoot', 'Check', 'Completed');

-- James Miller
INSERT INTO earnings VALUES (17, 11, 6000.00, TO_DATE('2024-01-30', 'YYYY-MM-DD'), 'Paris Fashion Week', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (18, 11, 4500.00, TO_DATE('2024-02-25', 'YYYY-MM-DD'), 'Men Fashion Brand Campaign', 'Check', 'Paid');
INSERT INTO earnings VALUES (19, 11, 5200.00, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'International Brand Shoot', 'Bank Transfer', 'Completed');

-- Michael White
INSERT INTO earnings VALUES (20, 12, 3500.00, TO_DATE('2024-01-12', 'YYYY-MM-DD'), 'TV Commercial', 'Check', 'Paid');
INSERT INTO earnings VALUES (21, 12, 2800.00, TO_DATE('2024-02-18', 'YYYY-MM-DD'), 'Magazine Ad', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (22, 12, 3200.00, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Brand Partnership', 'Check', 'Completed');

-- Daniel Harris
INSERT INTO earnings VALUES (23, 13, 5500.00, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'Milan Fashion Week', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (24, 13, 4000.00, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'Luxury Brand Campaign', 'Check', 'Completed');

-- Matthew Clark
INSERT INTO earnings VALUES (25, 14, 4200.00, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Editorial Shoot', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (26, 14, 3500.00, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Commercial Brand', 'Check', 'Paid');
INSERT INTO earnings VALUES (27, 14, 3800.00, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 'Fashion Campaign', 'Bank Transfer', 'Pending');

-- Kevin Arnold
INSERT INTO earnings VALUES (28, 19, 3000.00, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 'Sports Brand Campaign', 'Check', 'Paid');
INSERT INTO earnings VALUES (29, 19, 2500.00, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Fitness Equipment Shoot', 'Bank Transfer', 'Completed');

-- Additional earnings for other models
INSERT INTO earnings VALUES (30, 6, 2800.00, TO_DATE('2024-01-28', 'YYYY-MM-DD'), 'International Campaign', 'Bank Transfer', 'Paid');
INSERT INTO earnings VALUES (31, 15, 4800.00, TO_DATE('2024-02-08', 'YYYY-MM-DD'), 'Brand Ambassador Work', 'Check', 'Completed');

COMMIT;

-- Create Indexes for better performance
CREATE INDEX idx_model_contacts_model_id ON model_contacts(model_id);
CREATE INDEX idx_talents_model_id ON talents(model_id);
CREATE INDEX idx_occupation_model_id ON occupation(model_id);
CREATE INDEX idx_education_model_id ON education(model_id);
CREATE INDEX idx_earnings_model_id ON earnings(model_id);
CREATE INDEX idx_earnings_date ON earnings(earning_date);

-- Verify data insertion
SELECT 'Models inserted: ' || COUNT(*) FROM models;
SELECT 'Contacts inserted: ' || COUNT(*) FROM model_contacts;
SELECT 'Talents inserted: ' || COUNT(*) FROM talents;
SELECT 'Occupations inserted: ' || COUNT(*) FROM occupation;
SELECT 'Educations inserted: ' || COUNT(*) FROM education;
SELECT 'Earnings inserted: ' || COUNT(*) FROM earnings;
