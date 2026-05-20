-- Revamped Items Database Schema and Seed Data for PostgreSQL

-- 1. Create Tables
CREATE TABLE item_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    is_digital BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE item (
    -- 1-5
    id SERIAL PRIMARY KEY,
    sku VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    type_id INTEGER NOT NULL REFERENCES item_type(id) ON DELETE RESTRICT,
    
    -- 6-10
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    stock_quantity INTEGER DEFAULT 0,
    reorder_level INTEGER DEFAULT 10,
    weight DECIMAL(8,2),
    
    -- 11-15
    dimensions VARCHAR(50),
    barcode VARCHAR(50) UNIQUE,
    manufacturer VARCHAR(100),
    brand VARCHAR(100),
    model_number VARCHAR(100),
    
    -- 16-20
    is_active BOOLEAN DEFAULT TRUE,
    is_taxable BOOLEAN DEFAULT TRUE,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- 21
    disclaimer TEXT
);

CREATE TABLE item_variants (
    id SERIAL PRIMARY KEY,
    item_id INTEGER NOT NULL REFERENCES item(id) ON DELETE CASCADE,
    sku_modifier VARCHAR(20) NOT NULL,
    variant_name VARCHAR(100) NOT NULL,
    variant_value VARCHAR(100) NOT NULL,
    price_adjustment DECIMAL(10,2) DEFAULT 0.00,
    stock_quantity INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes for performance
CREATE INDEX idx_item_sku ON item(sku);
CREATE INDEX idx_item_type ON item(type_id);
CREATE INDEX idx_item_active ON item(is_active);
CREATE INDEX idx_item_variants_item ON item_variants(item_id);

-- 2. Seed Data
-- Seed item_type (20 records)
INSERT INTO item_type (id, name, description, is_digital) VALUES
(1, 'Electronics', 'Consumer electronic devices, smart devices, and computer parts.', false),
(2, 'Apparel', 'Clothing, footwear, and accessory products.', false),
(3, 'Books', 'Physical print books, textbooks, and novels.', false),
(4, 'Grocery', 'Pantry staples, organic foods, snacks, and fresh produce.', false),
(5, 'Toys & Games', 'Board games, card games, educational toys, and action figures.', false),
(6, 'Home & Kitchen', 'Furniture, bedding, cookware, kitchen appliances, and home decor.', false),
(7, 'Beauty & Personal Care', 'Cosmetics, skincare products, hair care, and hygiene items.', false),
(8, 'Sports & Outdoors', 'Fitness gear, athletic apparel, camping gear, and sports equipment.', false),
(9, 'Automotive', 'Car care, replacement parts, tools, and accessories.', false),
(10, 'Tools & Home Improvement', 'Power tools, hand tools, hardware, electrical, and plumbing.', false),
(11, 'Pet Supplies', 'Pet food, treats, toys, collars, beds, and grooming supplies.', false),
(12, 'Office Products', 'Stationery, notebooks, printers, calculators, and desk chairs.', false),
(13, 'Patio, Lawn & Garden', 'Outdoor furniture, plants, seeds, fertilizers, and lawn mowers.', false),
(14, 'Health & Household', 'Vitamins, supplements, cleaning supplies, and first aid kits.', false),
(15, 'Baby Products', 'Strollers, diapers, baby clothing, pacifiers, and nursery decor.', false),
(16, 'Jewelry', 'Watches, necklaces, bracelets, rings, and fine jewelry.', false),
(17, 'Musical Instruments', 'Guitars, keyboards, drums, microphones, and audio equipment.', false),
(18, 'Software & Video Games', 'Digital application software, gaming discs, and licenses.', true),
(19, 'Arts, Crafts & Sewing', 'Yarn, paint, drawing pads, sewing machines, and craft supplies.', false),
(20, 'Industrial & Scientific', 'Lab equipment, 3D printers, safety gear, and industrial tools.', false);

-- Seed item (20 records with 21 columns populated)
INSERT INTO item (id, sku, name, description, type_id, price, cost, stock_quantity, reorder_level, weight, dimensions, barcode, manufacturer, brand, model_number, is_active, is_taxable, image_url, disclaimer) VALUES
(1, 'ELC-IP15P-128', 'iPhone 15 Pro 128GB', 'High-end smartphone featuring titanium finish and Action button.', 1, 999.00, 450.00, 50, 10, 0.41, '5.81 x 2.78 x 0.32 in', '195949000128', 'Apple Inc.', 'Apple', 'A3102', true, true, 'https://images.orcha.io/items/iphone15pro.jpg', 'Requires carrier activation contract or unlocked carrier plan.'),
(2, 'APP-HOOD-BLK-M', 'Classic Hooded Sweatshirt', 'Warm fleece hooded sweatshirt in jet black, medium size.', 2, 45.00, 15.00, 150, 25, 1.20, '12 x 10 x 2 in', '742398001021', 'Apparel Mfg Co.', 'Threads', 'TH-HOOD-01', true, true, 'https://images.orcha.io/items/hoodie_black.jpg', 'Machine wash cold with like colors.'),
(3, 'BOK-ATMIC-HABT', 'Atomic Habits by James Clear', 'An easy and proven way to build good habits and break bad ones.', 3, 16.99, 8.50, 300, 50, 0.85, '8.2 x 5.5 x 1.1 in', '978073521129', 'Penguin Publishing', 'Random House', '9780735211292', true, false, 'https://images.orcha.io/items/atomichabits.jpg', 'Includes copyright and publishing rights reserved.'),
(4, 'GRC-MZO-OAT-1', 'Organic Rolled Oats 1kg', '100% whole grain organic rolled oats for classic breakfast oatmeal.', 4, 6.49, 2.50, 80, 20, 2.20, '9.5 x 5.0 x 3.0 in', '041220005432', 'Nature Farms Corp', 'Nature Organic', 'NO-OAT-1KG', true, false, 'https://images.orcha.io/items/rolledoats.jpg', 'Processed in a facility that also processes wheat and nuts.'),
(5, 'TOY-CATAN-BRD', 'Catan Board Game (Base)', 'Strategy game of trading, building, and settling the island of Catan.', 5, 49.00, 22.00, 45, 15, 2.10, '11.6 x 11.6 x 3.0 in', '029877030718', 'Asmodee Group', 'Catan Studio', 'CN3071', true, true, 'https://images.orcha.io/items/catan.jpg', 'Choking hazard: contains small parts. Not for children under 3 years.'),
(6, 'HOM-CAST-SKL', 'Lodge 10.25 Inch Cast Iron Skillet', 'Pre-seasoned cast iron skillet with assist handle for cooking.', 6, 29.90, 12.00, 60, 15, 5.35, '16.1 x 10.7 x 2.0 in', '075536301037', 'Lodge Manufacturing', 'Lodge', 'L8SK3', true, true, 'https://images.orcha.io/items/ LodgeCastIron.jpg', 'Season with oil periodically to maintain natural non-stick surface.'),
(7, 'BTY-HYDRA-SRM', 'Hydrating Hyaluronic Acid Serum', 'Daily moisture facial serum enriched with Vitamin B5 for soft skin.', 7, 22.00, 7.00, 120, 30, 0.25, '4.5 x 1.5 x 1.5 in', '850021304521', 'Aura Skincare Labs', 'Aura', 'AU-HA-30', true, true, 'https://images.orcha.io/items/hyaluronic.jpg', 'For external cosmetic use only. Avoid contact with eyes.'),
(8, 'SPT-YOGA-MAT', 'Premium 6mm Non-Slip Yoga Mat', 'Extra-thick eco-friendly TPE fitness mat with alignment marks.', 8, 35.00, 14.00, 95, 20, 1.80, '24.0 x 6.0 x 6.0 in', '697123901452', 'FlexFit Athletics', 'FlexFit', 'FF-YM-06', true, true, 'https://images.orcha.io/items/yogamat.jpg', 'Wipe down with damp cloth after use. Store away from direct sunlight.'),
(9, 'AUT-OBD2-SCAN', 'OBD2 Engine Code Scanner', 'Handheld diagnostic scan tool for check engine light codes.', 9, 39.99, 18.00, 40, 10, 0.70, '7.2 x 3.1 x 1.0 in', '840192803120', 'Ancel Diagnostics', 'Ancel', 'AD310', true, true, 'https://images.orcha.io/items/obd2scanner.jpg', 'Compatible with most 1996 and newer OBDII protocol vehicles.'),
(10, 'TOL-DRILL-KIT', '20V Max Cordless Drill Driver Kit', 'Power drill driver kit with lithium-ion battery, charger, and bits.', 10, 89.00, 41.00, 35, 8, 5.80, '12.0 x 9.5 x 3.8 in', '885911204910', 'DeWalt Power Tools', 'DeWalt', 'DCD771C2', true, true, 'https://images.orcha.io/items/dewartdrill.jpg', 'Wear eye protection during use. Keep out of reach of children.'),
(11, 'PET-DOG-BED', 'Orthopedic Memory Foam Dog Bed', 'Plush supportive memory foam bed with removable washable cover.', 11, 55.00, 23.00, 28, 6, 4.50, '36.0 x 28.0 x 4.0 in', '810019280374', 'BarkSoft Products', 'BarkSoft', 'BS-OBB-LG', true, true, 'https://images.orcha.io/items/dogbed.jpg', 'Unroll memory foam and allow up to 48 hours to fully expand.'),
(12, 'OFC-SHRD-12C', '12-Sheet Cross-Cut Paper Shredder', 'High-security paper, CD, and credit card shredder with bin.', 12, 69.99, 32.00, 22, 5, 11.20, '16.0 x 12.5 x 8.0 in', '015482087610', 'Bonsaii Business', 'Bonsaii', 'C149-C', true, true, 'https://images.orcha.io/items/shredder.jpg', 'Do not insert hands, hair, or jewelry near feeding slot.'),
(13, 'PTG-SLR-LGT', 'Solar Outdoor Path Lights (6 Pack)', 'Solar powered waterproof LED garden pathway stake lights.', 13, 24.99, 9.50, 110, 20, 2.40, '11.0 x 6.5 x 4.5 in', '710892305814', 'EcoGlow Lighting', 'EcoGlow', 'EG-PL-06', true, true, 'https://images.orcha.io/items/pathlights.jpg', 'Ensure solar panel receives unobstructed direct sunlight for charging.'),
(14, 'HLT-VIT-D3', 'Vitamin D3 5000 IU (360 Softgels)', 'High potency immune and bone support dietary supplement softgels.', 14, 18.50, 6.00, 200, 40, 0.35, '4.2 x 2.2 x 2.2 in', '733739003652', 'NOW Foods', 'NOW', 'NOW-0365', true, true, 'https://images.orcha.io/items/vitamind3.jpg', 'These statements have not been evaluated by the FDA. Product not intended to diagnose or treat disease.'),
(15, 'BAB-CAR-SEAT', 'Infant Convertible Car Seat', '3-in-1 rear and forward-facing infant to toddler safety car seat.', 15, 199.00, 95.00, 18, 5, 19.50, '25.0 x 20.0 x 19.0 in', '047406145329', 'Graco Baby', 'Graco', 'Graco-Extend2Fit', true, true, 'https://images.orcha.io/items/carseat.jpg', 'Securely install using LATCH system and read instructions fully before first use.'),
(16, 'JWL-WCH-SLV', 'Minimalist Stainless Steel Watch', 'Sleek silver analog quartz watch with black mesh strap.', 16, 120.00, 45.00, 32, 8, 0.40, '6.0 x 3.5 x 2.0 in', '789123805910', 'Bering Time Corp', 'Bering', 'B-14539', true, true, 'https://images.orcha.io/items/meshwatch.jpg', 'Water resistant up to 3 ATM (splash proof). Not suitable for swimming.'),
(17, 'MUS-AC-GTR', 'Acoustic Guitar Starter Pack', 'Full-size 41-inch dreadnought steel string acoustic guitar kit.', 17, 149.99, 68.00, 15, 4, 9.80, '42.0 x 18.0 x 6.0 in', '804598001095', 'Fender Instruments', 'Fender', 'Squier-SA150', true, true, 'https://images.orcha.io/items/guitar.jpg', 'Includes gig bag, clip-on tuner, guitar strap, picks, and spare strings.'),
(18, 'SFT-MS-O365', 'Microsoft 365 Personal (1 Year)', 'One year subscription for word processing, cloud backup, and sheets.', 18, 69.99, 48.00, 500, 100, 0.00, 'Digital License Key', '889842605914', 'Microsoft Corp', 'Microsoft', 'M365-PERS-1Y', true, true, 'https://images.orcha.io/items/office365.jpg', 'Non-refundable digital purchase. License is valid for 1 account for 12 months.'),
(19, 'ART-PNT-SET', 'Acrylic Paint Set 24 Colors', 'Professional non-toxic water-based art paints with 3 brushes.', 19, 21.99, 8.00, 75, 15, 1.50, '9.0 x 4.0 x 1.8 in', '749102380590', 'Castle Art Supplies', 'Castle', 'CAS-AP-24', true, true, 'https://images.orcha.io/items/acrylicpaint.jpg', 'Conforms to ASTM D-4236 standards. Washable on skin while wet.'),
(20, 'IND-3D-PRNT', 'Ender 3 DIY 3D Printer', 'High-precision open-source DIY kit desktop FDM 3D printer.', 20, 229.00, 110.00, 12, 3, 17.60, '20.0 x 18.0 x 15.0 in', '697163809123', 'Creality 3D', 'Creality', 'Ender-3', true, true, 'https://images.orcha.io/items/ender3.jpg', 'Assembly required. Read safety sheet regarding hot nozzle temperatures.'),
(21, 'ELC-APW-SE', 'Apple Watch SE (2nd Gen)', 'Smartwatch with health monitoring, activity tracking, and fall detection.', 1, 249.00, 120.00, 40, 8, 0.07, '1.73 x 1.50 x 0.42 in', '194253139045', 'Apple Inc.', 'Apple', 'A2722', true, true, 'https://images.orcha.io/items/applewatchse.jpg', 'Requires iPhone 8 or later with iOS 16 or later.'),
(22, 'APP-JNS-BLU-32', 'Classic Straight Fit Jeans', 'Durable cotton denim straight fit jeans in medium indigo wash, size 32.', 2, 59.99, 20.00, 110, 20, 1.45, '14 x 11 x 1.5 in', '742398002042', 'Denim Works Ltd', 'Indigo', 'DN-STR-32', true, true, 'https://images.orcha.io/items/jeans_blue.jpg', 'Color may transfer when new. Wash separately before wearing.'),
(23, 'BOK-CLR-THNK', 'The Art of Thinking Clearly', 'World bestseller exploring common cognitive biases and decision traps.', 3, 15.00, 7.50, 180, 30, 0.70, '7.8 x 5.1 x 0.9 in', '978006221969', 'HarperCollins Publishers', 'Harper', '9780062219694', true, false, 'https://images.orcha.io/items/thinkingclearly.jpg', 'Translation and regional rights reserved under licensing agreements.'),
(24, 'GRC-CNO-OIL-1', 'Pure Canola Oil 1L', '100% pure all-purpose cooking oil, high smoke point, cholesterol free.', 4, 4.99, 1.80, 140, 35, 2.05, '10.5 x 3.5 x 3.5 in', '041220006711', 'SunGlow Farms', 'SunGlow', 'SG-CAN-1L', true, false, 'https://images.orcha.io/items/canolaoil.jpg', 'Store in a cool, dark place away from heat sources.'),
(25, 'TOY-MONOP-DLX', 'Monopoly Deluxe Edition', 'Classic board game with premium gold tokens and wooden houses.', 5, 34.99, 15.50, 50, 12, 2.40, '15.7 x 10.5 x 2.2 in', '029877024810', 'Hasbro Gaming', 'Hasbro', 'HB-MON-DLX', true, true, 'https://images.orcha.io/items/monopoly.jpg', 'Choking hazard: contains small parts. Recommended for ages 8 and up.'),
(26, 'HOM-AIR-FRY', 'Digital Air Fryer 5.8QT', 'Large capacity oil-free convection air fryer with 10 presets.', 6, 99.99, 45.00, 25, 6, 12.50, '14.3 x 11.8 x 12.6 in', '850021305610', 'Cosori Appliances', 'Cosori', 'CP158-AF', true, true, 'https://images.orcha.io/items/airfryer.jpg', 'Do not submerge the main electrical housing unit in water.'),
(27, 'BTY-LIP-BALM', 'Organic Beeswax Lip Balm (4 Pack)', 'All-natural moisturizing lip balms containing peppermint and shea butter.', 7, 9.99, 3.20, 250, 50, 0.15, '3.5 x 2.8 x 0.6 in', '850021307184', 'EcoLips Inc.', 'EcoLips', 'EL-LBP-04', true, true, 'https://images.orcha.io/items/lipbalm.jpg', 'For external topical application only. Store below 80 degrees F.'),
(28, 'SPT-DUMB-SET', 'Adjustable Dumbbell Set 50lbs', 'Pair of steel selectorized adjustable dumbbells for strength training.', 8, 189.00, 85.00, 15, 4, 50.00, '16.0 x 8.5 x 8.0 in', '697123903128', 'IronMax Strength', 'IronMax', 'IM-ADJ-50', true, true, 'https://images.orcha.io/items/dumbbells.jpg', 'Place on level surfaces. Ensure weight selector pin is fully engaged before lifting.'),
(29, 'AUT-WSH-MIT', 'Microfiber Car Wash Mitt', 'Scratch-free extra soft premium microfiber wash glove.', 9, 8.50, 2.50, 160, 30, 0.30, '10.0 x 8.0 x 1.5 in', '840192804592', 'Chemical Guys', 'Chemical Guys', 'MIC493', true, true, 'https://images.orcha.io/items/washmitt.jpg', 'Machine washable. Do not use fabric softener to preserve microfiber properties.'),
(30, 'TOL-SCREW-SET', '42-Piece Magnetic Screwdriver Set', 'Professional Grade chrome vanadium screwdriver set with organizer rack.', 10, 29.99, 12.00, 55, 10, 3.80, '11.5 x 8.0 x 4.0 in', '885911207812', 'Stanley Tools', 'Stanley', 'ST-SD-42', true, true, 'https://images.orcha.io/items/screwdriverset.jpg', 'Not insulated against electrical shock. Do not use on live circuits.'),
(31, 'PET-CAT-TWR', 'Multi-Level Cat Tree Tower', '60-inch cat activity tree with scratching posts, condo, and hammock.', 11, 79.99, 34.00, 20, 5, 28.50, '20.0 x 20.0 x 60.0 in', '810019280916', 'Feandrea Pet', 'Feandrea', 'FA-CT-60', true, true, 'https://images.orcha.io/items/cattower.jpg', 'Anchor securely to the wall using the provided anti-toppling hardware.'),
(32, 'OFC-MESH-CHR', 'Ergonomic Mesh Office Chair', 'High back desk chair with adjustable lumbar support and armrests.', 12, 149.00, 65.00, 30, 8, 32.40, '26.0 x 24.5 x 45.0 in', '015482089201', 'Sihoo Ergonomics', 'Sihoo', 'SH-M57', true, true, 'https://images.orcha.io/items/officechair.jpg', 'Supports maximum weight capacity up to 300 lbs. Assembly required.'),
(33, 'PTG-SEED-STR', 'Organic Tomato Seed Starter Kit', 'Complete indoor gardening kit with peat pots, soil pellets, and organic seeds.', 13, 14.99, 5.00, 90, 20, 0.90, '8.0 x 6.0 x 3.5 in', '710892306712', 'Garden Republic', 'Garden Republic', 'GR-TSK-01', true, true, 'https://images.orcha.io/items/tomatokit.jpg', 'Germination rates depend on environmental temperature and regular watering.'),
(34, 'HLT-ORG-MULT', 'Womens Organic Multivitamin 90ct', 'Whole-food plant-based daily multivitamin tablets for active women.', 14, 24.50, 9.00, 115, 25, 0.45, '4.8 x 2.5 x 2.5 in', '733739004819', 'Garden of Life', 'Garden of Life', 'GOL-8041', true, true, 'https://images.orcha.io/items/womensmulti.jpg', 'Consult healthcare professional before use if pregnant or nursing.'),
(35, 'BAB-PLAY-PEN', 'Foldable Baby Playpen 50x50"', 'Safe indoor/outdoor activity center with breathable mesh side panels.', 15, 59.99, 24.00, 24, 6, 8.40, '25.0 x 8.0 x 8.0 in', '047406149020', 'Regalo Baby', 'Regalo', 'RG-PP-50', true, true, 'https://images.orcha.io/items/playpen.jpg', 'Never leave child unattended inside the playpen. Adult assembly required.'),
(36, 'JWL-GLD-ERR', '14k Gold Hoop Earrings', 'Classic 20mm round lightweight hollow click-top 14k gold hoops.', 16, 89.00, 32.00, 45, 10, 0.10, '3.0 x 3.0 x 1.0 in', '789123807815', 'Karat Jewelry', 'Karat', 'KT-HE-20', true, true, 'https://images.orcha.io/items/goldhoops.jpg', 'Clean gently with a soft microfibre cloth. Store in fabric-lined box.'),
(37, 'MUS-USB-MIC', 'Studio USB Condenser Microphone', 'Cardioid USB microphone kit with boom arm, shock mount, and pop filter.', 17, 49.99, 21.00, 50, 12, 3.20, '17.0 x 8.0 x 3.5 in', '804598002047', 'Maono Technology', 'Maono', 'AU-A04', true, true, 'https://images.orcha.io/items/usbmic.jpg', 'Plug and play compatible with Windows, macOS, and Linux platforms.'),
(38, 'SFT-WIN-11PR', 'Windows 11 Pro License Key', 'Original retail license activation product key for Windows 11 Professional.', 18, 199.99, 130.00, 400, 80, 0.00, 'Digital License Key', '889842609042', 'Microsoft Corp', 'Microsoft', 'WIN11PRO-RET', true, true, 'https://images.orcha.io/items/win11pro.jpg', 'Activation key is tied to a single motherboard hardware profile.'),
(39, 'ART-SKT-PAD', 'Premium Sketch Pad 9x12" (2 Pack)', '100 sheets per pad, acid-free heavyweight drawing paper, spiral bound.', 19, 15.99, 5.50, 85, 15, 2.80, '12.0 x 9.0 x 1.6 in', '749102381207', 'Arteza Art Corp', 'Arteza', 'ART-SP-912', true, true, 'https://images.orcha.io/items/sketchpad.jpg', 'Acid-free paper prevents yellowing over time to preserve sketches.'),
(40, 'IND-SAFETY-GL', 'Anti-Fog Protective Safety Glasses', 'Scratch resistant clear wrap-around lenses with soft temple grips.', 20, 7.99, 2.00, 300, 50, 0.18, '6.0 x 2.2 x 1.8 in', '697163809987', '3M Personal Safety', '3M', 'SF401AF', true, true, 'https://images.orcha.io/items/safetyglasses.jpg', 'Meets ANSI Z87.1-2015 high-impact standard requirements.');

-- Seed item_variants (20 records)
INSERT INTO item_variants (id, item_id, sku_modifier, variant_name, variant_value, price_adjustment, stock_quantity) VALUES
(1, 1, '-256GB', 'Storage', '256GB', 100.00, 20),
(2, 1, '-512GB', 'Storage', '512GB', 300.00, 10),
(3, 1, '-BLU', 'Color', 'Blue Titanium', 0.00, 15),
(4, 1, '-WHT', 'Color', 'White Titanium', 0.00, 15),
(5, 2, '-BLK-L', 'Size', 'Large', 0.00, 40),
(6, 2, '-BLK-XL', 'Size', 'Extra Large', 3.00, 30),
(7, 2, '-GRY-M', 'Color', 'Heather Gray', 0.00, 40),
(8, 2, '-GRY-L', 'Color & Size', 'Heather Gray, Large', 0.00, 35),
(9, 3, '-HRDCVR', 'Format', 'Hardcover', 12.00, 50),
(10, 8, '-BLU', 'Color', 'Ocean Blue', 0.00, 30),
(11, 8, '-PNK', 'Color', 'Sakura Pink', 0.00, 25),
(12, 8, '-PUR', 'Color', 'Royal Purple', 0.00, 20),
(13, 11, '-MED', 'Size', 'Medium (30x20")', -10.00, 15),
(14, 11, '-XLG', 'Size', 'Extra Large (44x35")', 20.00, 10),
(15, 16, '-GLD', 'Material', 'Rose Gold Plated', 30.00, 12),
(16, 17, '-LEFT', 'Dexterity', 'Left-Handed', 15.00, 3),
(17, 18, '-FAMILY', 'Plan Type', 'M365 Family (6 Users)', 30.00, 200),
(18, 19, '-XL-TUBES', 'Tube Size', '120ml Large Tubes', 15.00, 25),
(19, 20, '-PRO', 'Model Grade', 'Ender 3 Pro Upgrade', 50.00, 5),
(20, 20, '-V2', 'Model Grade', 'Ender 3 V2 Silent Board', 80.00, 4);

-- Reset sequences for proper auto-increment behaviour
SELECT setval('item_type_id_seq', 20);
SELECT setval('item_id_seq', 40);
SELECT setval('item_variants_id_seq', 20);
