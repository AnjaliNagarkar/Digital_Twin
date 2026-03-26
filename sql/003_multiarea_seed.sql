-- ============================================================
-- Village Digital Twin — Multi-Area Seed Data v3
-- 5 Geographic Clusters in a PENTAGON layout (~5km × 5km)
-- Ward centres are NOT in a line — proper spatial distribution
-- ============================================================
-- Ward 1 "Kothrud North"  → NW  corner  (18.521, 73.789)
-- Ward 2 "Karve Nagar"    → NE  corner  (18.519, 73.839)
-- Ward 3 "Bavdhan"        → CENTER      (18.497, 73.808)
-- Ward 4 "Warje"          → SW  corner  (18.475, 73.792)
-- Ward 5 "Erandwane"      → SE  corner  (18.479, 73.834)
-- ============================================================

USE village_twin;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE assets;
TRUNCATE TABLE household_schemes;
TRUNCATE TABLE agriculture;
TRUNCATE TABLE family_members;
TRUNCATE TABLE schemes;
TRUNCATE TABLE households;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- HOUSEHOLDS — 64 records, each ward spatially spread ~300m
-- ============================================================
INSERT INTO households
  (id, head_name, address, ward_no, lat, lng,
   total_members, annual_income, bpl, ration_card,
   house_type, has_toilet, has_electricity, has_water_supply, has_gas)
VALUES
-- ════════════════════════════════════════════════════════════
-- WARD 1 — Kothrud North  |  NW corner  |  DENSE + CRITICAL
-- Centre: 18.521, 73.789  |  14 HH, 72% BPL, Toilet 29%
-- ════════════════════════════════════════════════════════════
(1,  'Ramesh Patil',       'Galli 1, Kothrud North',  1, 18.52350, 73.78720, 8, 36000,  1,'BPL', 'Kuccha',     0, 0, 0, 0),
(2,  'Sunita Bhosale',     'Galli 1, Kothrud North',  1, 18.52080, 73.79120, 7, 42000,  1,'BPL', 'Kuccha',     0, 1, 0, 0),
(3,  'Manoj Jadhav',       'Galli 2, Kothrud North',  1, 18.52420, 73.79080, 9, 48000,  1,'BPL', 'Kuccha',     0, 0, 0, 0),
(4,  'Kalpana More',       'Galli 2, Kothrud North',  1, 18.51970, 73.78850, 6, 54000,  1,'BPL', 'Semi-Pucca', 0, 1, 0, 0),
(5,  'Santosh Gaikwad',    'Galli 3, Kothrud North',  1, 18.52500, 73.78950, 8, 30000,  1,'AAY', 'Kuccha',     0, 0, 0, 0),
(6,  'Nanda Shinde',       'Galli 3, Kothrud North',  1, 18.52150, 73.79200, 7, 66000,  1,'BPL', 'Kuccha',     1, 1, 0, 0),
(7,  'Vikas Waghmare',     'Galli 4, Kothrud North',  1, 18.52280, 73.79010, 5, 78000,  0,'APL', 'Semi-Pucca', 1, 1, 1, 0),
(8,  'Lata Kamble',        'Galli 4, Kothrud North',  1, 18.51900, 73.79160, 9, 24000,  1,'AAY', 'Kuccha',     0, 0, 0, 0),
(9,  'Dnyanoba Raut',      'Galli 5, Kothrud North',  1, 18.52380, 73.78800, 8, 36000,  1,'BPL', 'Kuccha',     0, 1, 0, 0),
(10, 'Savita Pawar',       'Galli 5, Kothrud North',  1, 18.52060, 73.79050, 6, 90000,  0,'APL', 'Pucca',      1, 1, 1, 1),
(11, 'Balu Chavan',        'Galli 6, Kothrud North',  1, 18.52180, 73.78880, 7, 42000,  1,'BPL', 'Kuccha',     0, 0, 0, 0),
(12, 'Asha Deshmukh',      'Galli 6, Kothrud North',  1, 18.52460, 73.79150, 8, 48000,  1,'BPL', 'Kuccha',     0, 1, 0, 0),
(13, 'Tukaram Wagh',       'Galli 7, Kothrud North',  1, 18.51950, 73.78920, 5, 120000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(14, 'Rekha Nikam',        'Galli 7, Kothrud North',  1, 18.52320, 73.79230, 7, 30000,  1,'AAY', 'Kuccha',     0, 0, 0, 0),

-- ════════════════════════════════════════════════════════════
-- WARD 2 — Karve Nagar  |  NE corner  |  DENSE + MEDIUM
-- Centre: 18.519, 73.839  |  15 HH, 40% BPL, Toilet 67%
-- ════════════════════════════════════════════════════════════
(15, 'Priya Kulkarni',     'Row A, Karve Nagar',      2, 18.52100, 73.83580, 5, 168000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(16, 'Ganesh Mane',        'Row A, Karve Nagar',      2, 18.51820, 73.83920, 6, 48000,  1,'BPL', 'Semi-Pucca', 0, 1, 0, 0),
(17, 'Anita Kadam',        'Row B, Karve Nagar',      2, 18.52200, 73.83980, 4, 144000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(18, 'Deepak Salve',       'Row B, Karve Nagar',      2, 18.51720, 73.83720, 7, 60000,  1,'BPL', 'Kuccha',     0, 1, 0, 0),
(19, 'Meena Lokhande',     'Row C, Karve Nagar',      2, 18.52050, 73.83760, 5, 120000, 0,'APL', 'Semi-Pucca', 1, 1, 1, 0),
(20, 'Rajesh Borse',       'Row C, Karve Nagar',      2, 18.51950, 73.84020, 6, 84000,  0,'APL', 'Pucca',      1, 1, 1, 1),
(21, 'Suman Kale',         'Row D, Karve Nagar',      2, 18.51780, 73.84150, 4, 48000,  1,'BPL', 'Kuccha',     0, 0, 0, 0),
(22, 'Prakash Dhole',      'Row D, Karve Nagar',      2, 18.52150, 73.83650, 7, 216000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(23, 'Vandana Kokate',     'Row E, Karve Nagar',      2, 18.52280, 73.83850, 5, 72000,  1,'BPL', 'Semi-Pucca', 1, 1, 0, 0),
(24, 'Nilesh Gholap',      'Row E, Karve Nagar',      2, 18.51670, 73.83800, 6, 156000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(25, 'Ashwini Ahire',      'Row F, Karve Nagar',      2, 18.52020, 73.84080, 4, 96000,  0,'APL', 'Semi-Pucca', 1, 1, 1, 0),
(26, 'Mohan Sonawane',     'Row F, Karve Nagar',      2, 18.51880, 73.83620, 8, 42000,  1,'BPL', 'Kuccha',     0, 1, 0, 0),
(27, 'Kaveri Yadav',       'Row G, Karve Nagar',      2, 18.52320, 73.83720, 5, 180000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(28, 'Sunil Devkar',       'Row G, Karve Nagar',      2, 18.51750, 73.84080, 6, 60000,  1,'BPL', 'Semi-Pucca', 0, 1, 1, 0),
(29, 'Poonam Bhagat',      'Row H, Karve Nagar',      2, 18.52120, 73.83900, 4, 132000, 0,'APL', 'Pucca',      1, 1, 1, 1),

-- ════════════════════════════════════════════════════════════
-- WARD 3 — Bavdhan  |  CENTER  |  MEDIUM + GOOD
-- Centre: 18.497, 73.808  |  12 HH, 17% BPL, Toilet 92%
-- ════════════════════════════════════════════════════════════
(30, 'Anil Londhe',        'Sector 1, Bavdhan',       3, 18.49980, 73.80520, 4, 240000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(31, 'Smita Khairnar',     'Sector 1, Bavdhan',       3, 18.49620, 73.80880, 3, 192000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(32, 'Prasad Khedkar',     'Sector 2, Bavdhan',       3, 18.50050, 73.80780, 5, 168000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(33, 'Nirmala Thombre',    'Sector 2, Bavdhan',       3, 18.49500, 73.80620, 4, 144000, 0,'APL', 'Pucca',      1, 1, 1, 0),
(34, 'Kishor Pardeshi',    'Sector 3, Bavdhan',       3, 18.50120, 73.80500, 3, 288000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(35, 'Archana Ubale',      'Sector 3, Bavdhan',       3, 18.49420, 73.80950, 5, 120000, 0,'APL', 'Semi-Pucca', 1, 1, 0, 0),
(36, 'Hemant Shelke',      'Sector 4, Bavdhan',       3, 18.49880, 73.81020, 4, 204000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(37, 'Mangala Bhandare',   'Sector 4, Bavdhan',       3, 18.49350, 73.80720, 3, 108000, 0,'APL', 'Pucca',      1, 1, 1, 0),
(38, 'Shirish Nimbalkar',  'Sector 5, Bavdhan',       3, 18.50080, 73.80650, 6, 36000,  1,'BPL', 'Semi-Pucca', 0, 1, 1, 0),
(39, 'Usha Kamble',        'Sector 5, Bavdhan',       3, 18.49550, 73.80480, 4, 72000,  1,'BPL', 'Kuccha',     1, 1, 0, 0),
(40, 'Vilas Raut',         'Sector 6, Bavdhan',       3, 18.49700, 73.80980, 3, 336000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(41, 'Chanda Thombare',    'Sector 6, Bavdhan',       3, 18.49200, 73.80800, 4, 156000, 0,'APL', 'Pucca',      1, 1, 1, 1),

-- ════════════════════════════════════════════════════════════
-- WARD 4 — Warje  |  SW corner  |  SPARSE + CRITICAL
-- Centre: 18.475, 73.792  |  10 HH, 80% BPL, Toilet 20%
-- ════════════════════════════════════════════════════════════
(42, 'Bhimrao Lohar',      'Vasti 1, Warje',          4, 18.47780, 73.78920, 7, 30000,  1,'AAY', 'Kuccha',     0, 0, 0, 0),
(43, 'Jyoti Chavan',       'Vasti 1, Warje',          4, 18.47480, 73.79280, 8, 24000,  1,'AAY', 'Kuccha',     0, 0, 0, 0),
(44, 'Santosh Gorde',      'Vasti 2, Warje',          4, 18.47880, 73.79220, 6, 48000,  1,'BPL', 'Kuccha',     0, 1, 0, 0),
(45, 'Padmini Sutar',      'Vasti 2, Warje',          4, 18.47380, 73.78980, 9, 18000,  1,'AAY', 'Kuccha',     0, 0, 0, 0),
(46, 'Narsoba Dhangde',    'Vasti 3, Warje',          4, 18.47620, 73.78820, 5, 60000,  1,'BPL', 'Kuccha',     1, 1, 0, 0),
(47, 'Rani Kumbhar',       'Vasti 3, Warje',          4, 18.47520, 73.79380, 7, 36000,  1,'BPL', 'Kuccha',     0, 0, 0, 0),
(48, 'Govind Masal',       'Vasti 4, Warje',          4, 18.47820, 73.79050, 6, 42000,  1,'BPL', 'Semi-Pucca', 0, 1, 1, 0),
(49, 'Sulochana Mote',     'Vasti 4, Warje',          4, 18.47420, 73.79150, 8, 24000,  1,'AAY', 'Kuccha',     0, 0, 0, 0),
(50, 'Dattatray Gaikwad',  'Vasti 5, Warje',          4, 18.47950, 73.79320, 5, 84000,  0,'APL', 'Semi-Pucca', 1, 1, 1, 0),
(51, 'Pushpa Wable',       'Vasti 5, Warje',          4, 18.47320, 73.79080, 6, 30000,  1,'AAY', 'Kuccha',     0, 0, 0, 0),

-- ════════════════════════════════════════════════════════════
-- WARD 5 — Erandwane  |  SE corner  |  MEDIUM + OK
-- Centre: 18.479, 73.834  |  13 HH, 31% BPL, Toilet 77%
-- ════════════════════════════════════════════════════════════
(52, 'Yashwant Kadam',     'Colony A, Erandwane',     5, 18.48200, 73.83080, 5, 132000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(53, 'Sarika Patil',       'Colony A, Erandwane',     5, 18.47920, 73.83420, 4, 48000,  1,'BPL', 'Semi-Pucca', 0, 1, 0, 0),
(54, 'Rajendra Mhetre',    'Colony B, Erandwane',     5, 18.48320, 73.83350, 6, 180000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(55, 'Rekha Koli',         'Colony B, Erandwane',     5, 18.47820, 73.83150, 3, 96000,  0,'APL', 'Semi-Pucca', 1, 1, 1, 0),
(56, 'Suresh Jadhav',      'Colony C, Erandwane',     5, 18.48250, 73.83520, 5, 60000,  1,'BPL', 'Kuccha',     0, 1, 0, 0),
(57, 'Aarti Deshmukh',     'Colony C, Erandwane',     5, 18.47980, 73.83280, 4, 204000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(58, 'Vinod Shirke',       'Colony D, Erandwane',     5, 18.48150, 73.83050, 7, 48000,  1,'BPL', 'Kuccha',     0, 0, 0, 0),
(59, 'Chhaya Rokade',      'Colony D, Erandwane',     5, 18.47880, 73.83480, 4, 156000, 0,'APL', 'Pucca',      1, 1, 1, 0),
(60, 'Balwant Ingle',      'Colony E, Erandwane',     5, 18.48380, 73.83220, 5, 120000, 0,'APL', 'Semi-Pucca', 1, 1, 0, 0),
(61, 'Nandini Gade',       'Colony E, Erandwane',     5, 18.47750, 73.83380, 3, 48000,  1,'BPL', 'Kuccha',     1, 1, 1, 0),
(62, 'Pravin Shirsat',     'Colony F, Erandwane',     5, 18.48080, 73.83620, 6, 168000, 0,'APL', 'Pucca',      1, 1, 1, 1),
(63, 'Mangal Taware',      'Colony F, Erandwane',     5, 18.48050, 73.83120, 4, 84000,  0,'APL', 'Semi-Pucca', 1, 1, 1, 0),
(64, 'Rohini Shinde',      'Colony G, Erandwane',     5, 18.47700, 73.83550, 5, 42000,  1,'BPL', 'Semi-Pucca', 0, 1, 0, 0);

-- ============================================================
-- SCHEMES (government programs)
-- ============================================================
INSERT INTO schemes (id, name, code, category, description) VALUES
(1, 'Pradhan Mantri Awas Yojana',     'PMAY',      'Housing',    'Housing for all — Kuccha to Pucca'),
(2, 'Swachh Bharat Abhiyan',          'SBA',       'Welfare',    'Individual Household Latrine construction'),
(3, 'Saubhagya Yojana',               'SAUBHAGYA', 'Welfare',    'Household electrification'),
(4, 'Jal Jeevan Mission',             'JJM',       'Welfare',    'Tap water to every rural household'),
(5, 'PM Ujjwala Yojana',              'PMUY',      'Welfare',    'LPG connections for BPL women'),
(6, 'National Food Security Act',     'NFSA',      'Welfare',    'Subsidised ration under BPL/AAY'),
(7, 'MGNREGS',                        'MGNREGS',   'Employment', '100 days guaranteed rural employment'),
(8, 'PM Kisan Samman Nidhi',          'PMKSN',     'Agriculture','₹6000/yr income support to farmers');

-- ============================================================
-- SCHEME ENROLLMENTS
-- ============================================================
INSERT INTO household_schemes (household_id, scheme_id, enrolled_on, status) VALUES
(1,1,'2023-04-01','Active'),(3,1,'2023-04-01','Active'),(5,1,'2023-04-01','Active'),
(8,1,'2023-04-01','Active'),(11,1,'2023-04-01','Active'),(14,1,'2023-04-01','Active'),
(42,1,'2023-04-01','Active'),(43,1,'2023-04-01','Active'),(45,1,'2023-04-01','Active'),
(47,1,'2023-04-01','Active'),(49,1,'2023-04-01','Active'),(51,1,'2023-04-01','Active'),
(1,2,'2022-10-01','Active'),(2,2,'2022-10-01','Active'),(3,2,'2022-10-01','Pending'),
(4,2,'2022-10-01','Active'),(5,2,'2022-10-01','Pending'),(8,2,'2022-10-01','Active'),
(42,2,'2022-10-01','Active'),(43,2,'2022-10-01','Active'),(44,2,'2022-10-01','Pending'),
(1,4,'2023-01-15','Active'),(3,4,'2023-01-15','Pending'),(5,4,'2023-01-15','Active'),
(42,4,'2023-01-15','Active'),(43,4,'2023-01-15','Active'),(45,4,'2023-01-15','Pending'),
(1,6,'2020-01-01','Active'),(2,6,'2020-01-01','Active'),(4,6,'2020-01-01','Active'),
(5,6,'2020-01-01','Active'),(8,6,'2020-01-01','Active'),(42,6,'2020-01-01','Active'),
(43,6,'2020-01-01','Active'),(45,6,'2020-01-01','Active'),(47,6,'2020-01-01','Active'),
(1,7,'2022-06-01','Active'),(2,7,'2022-06-01','Active'),(6,7,'2022-06-01','Active'),
(42,7,'2022-06-01','Active'),(44,7,'2022-06-01','Active'),(46,7,'2022-06-01','Active');
