-- ============================================================
-- Village Digital Twin Platform — Seed Data
-- Realistic Indian village near Pune: ~50 households, 5 wards
-- Center: 18.5074°N, 73.8077°E (Kothrud GP area)
-- ============================================================

USE village_twin;

-- ============================================================
-- HOUSEHOLDS (50 records, 5 wards × 10 each)
-- Intentional gaps: ~40% BPL, ~70% toilet, ~85% electricity, ~60% water
-- ============================================================
INSERT INTO households (id, head_name, address, ward_no, lat, lng, total_members, annual_income, bpl, ration_card, house_type, has_toilet, has_electricity, has_water_supply, has_gas) VALUES
-- Ward 1 (10 households)
(1,  'Ramesh Patil',       'House 1, Ward 1',  1, 18.50810000, 73.80720000, 5, 48000.00,  1, 'BPL',  'Kuccha',    0, 0, 0, 0),
(2,  'Suresh Jadhav',      'House 2, Ward 1',  1, 18.50830000, 73.80750000, 4, 72000.00,  1, 'BPL',  'Semi-Pucca',1, 1, 0, 0),
(3,  'Anita Deshmukh',     'House 3, Ward 1',  1, 18.50850000, 73.80780000, 6, 156000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(4,  'Vikas More',         'House 4, Ward 1',  1, 18.50870000, 73.80810000, 3, 36000.00,  1, 'AAY',  'Kuccha',    0, 0, 0, 0),
(5,  'Priya Kulkarni',     'House 5, Ward 1',  1, 18.50890000, 73.80840000, 7, 240000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(6,  'Ganesh Shinde',      'House 6, Ward 1',  1, 18.50910000, 73.80870000, 4, 60000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(7,  'Sunita Pawar',       'House 7, Ward 1',  1, 18.50930000, 73.80900000, 5, 84000.00,  0, 'APL',  'Semi-Pucca',1, 1, 1, 0),
(8,  'Manoj Gaikwad',      'House 8, Ward 1',  1, 18.50950000, 73.80930000, 3, 42000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(9,  'Kavita Bhosale',     'House 9, Ward 1',  1, 18.50970000, 73.80960000, 6, 180000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(10, 'Ravi Chavan',        'House 10, Ward 1', 1, 18.50990000, 73.80990000, 4, 54000.00,  1, 'BPL',  'Semi-Pucca',1, 1, 0, 0),

-- Ward 2 (10 households)
(11, 'Ashok Kadam',        'House 1, Ward 2',  2, 18.50700000, 73.80700000, 5, 66000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(12, 'Meena Thombare',     'House 2, Ward 2',  2, 18.50720000, 73.80730000, 4, 120000.00, 0, 'APL',  'Semi-Pucca',1, 1, 1, 0),
(13, 'Rajendra Mane',      'House 3, Ward 2',  2, 18.50740000, 73.80760000, 6, 192000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(14, 'Suman Nikam',        'House 4, Ward 2',  2, 18.50760000, 73.80790000, 3, 30000.00,  1, 'AAY',  'Kuccha',    0, 0, 0, 0),
(15, 'Deepak Salve',       'House 5, Ward 2',  2, 18.50780000, 73.80820000, 5, 96000.00,  0, 'APL',  'Semi-Pucca',1, 1, 1, 0),
(16, 'Lata Wagh',          'House 6, Ward 2',  2, 18.50800000, 73.80850000, 4, 48000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(17, 'Prakash Dhole',      'House 7, Ward 2',  2, 18.50820000, 73.80880000, 7, 300000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(18, 'Rekha Borse',        'House 8, Ward 2',  2, 18.50840000, 73.80910000, 3, 54000.00,  1, 'BPL',  'Semi-Pucca',1, 1, 0, 0),
(19, 'Nilesh Kale',        'House 9, Ward 2',  2, 18.50860000, 73.80940000, 5, 132000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(20, 'Asha Lokhande',      'House 10, Ward 2', 2, 18.50880000, 73.80970000, 4, 42000.00,  1, 'BPL',  'Kuccha',    0, 0, 0, 0),

-- Ward 3 (10 households)
(21, 'Sanjay Gholap',      'House 1, Ward 3',  3, 18.50600000, 73.80680000, 5, 78000.00,  0, 'APL',  'Semi-Pucca',1, 1, 1, 0),
(22, 'Vaishali Ahire',     'House 2, Ward 3',  3, 18.50620000, 73.80710000, 6, 264000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(23, 'Dnyaneshwar Raut',   'House 3, Ward 3',  3, 18.50640000, 73.80740000, 3, 36000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(24, 'Jyoti Sonawane',     'House 4, Ward 3',  3, 18.50660000, 73.80770000, 4, 108000.00, 0, 'APL',  'Semi-Pucca',1, 1, 1, 0),
(25, 'Balaji Yadav',       'House 5, Ward 3',  3, 18.50680000, 73.80800000, 7, 360000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(26, 'Mangala Devkar',     'House 6, Ward 3',  3, 18.50700000, 73.80830000, 4, 42000.00,  1, 'BPL',  'Kuccha',    0, 0, 0, 0),
(27, 'Tukaram Bhagat',     'House 7, Ward 3',  3, 18.50720000, 73.80860000, 5, 90000.00,  0, 'APL',  'Semi-Pucca',1, 1, 0, 0),
(28, 'Pushpa Waghmare',    'House 8, Ward 3',  3, 18.50740000, 73.80890000, 3, 30000.00,  1, 'AAY',  'Kuccha',    0, 1, 0, 0),
(29, 'Anil Kamble',        'House 9, Ward 3',  3, 18.50760000, 73.80920000, 6, 168000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(30, 'Vandana Kokate',     'House 10, Ward 3', 3, 18.50780000, 73.80950000, 4, 54000.00,  1, 'BPL',  'Semi-Pucca',0, 1, 0, 0),

-- Ward 4 (10 households)
(31, 'Santosh Ubale',      'House 1, Ward 4',  4, 18.50500000, 73.80660000, 5, 72000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(32, 'Chhaya Khedkar',     'House 2, Ward 4',  4, 18.50520000, 73.80690000, 4, 144000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(33, 'Yashwant Londhe',    'House 3, Ward 4',  4, 18.50540000, 73.80720000, 6, 204000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(34, 'Indira Gawade',      'House 4, Ward 4',  4, 18.50560000, 73.80750000, 3, 36000.00,  1, 'BPL',  'Kuccha',    0, 0, 0, 0),
(35, 'Kiran Shelke',       'House 5, Ward 4',  4, 18.50580000, 73.80780000, 5, 108000.00, 0, 'APL',  'Semi-Pucca',1, 1, 1, 0),
(36, 'Nirmala Bhandare',   'House 6, Ward 4',  4, 18.50600000, 73.80810000, 7, 324000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(37, 'Bhimrao Thombre',    'House 7, Ward 4',  4, 18.50620000, 73.80840000, 4, 48000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(38, 'Savita Pardeshi',    'House 8, Ward 4',  4, 18.50640000, 73.80870000, 3, 60000.00,  1, 'BPL',  'Semi-Pucca',1, 1, 0, 0),
(39, 'Arun Khairnar',      'House 9, Ward 4',  4, 18.50660000, 73.80900000, 6, 180000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(40, 'Usha Nimbalkar',     'House 10, Ward 4', 4, 18.50680000, 73.80930000, 4, 42000.00,  1, 'AAY',  'Kuccha',    0, 0, 0, 0),

-- Ward 5 (10 households)
(41, 'Mohan Dhage',        'House 1, Ward 5',  5, 18.50400000, 73.80640000, 5, 84000.00,  0, 'APL',  'Semi-Pucca',1, 1, 1, 0),
(42, 'Sangita Handore',    'House 2, Ward 5',  5, 18.50420000, 73.80670000, 4, 48000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(43, 'Vitthal Gadekar',    'House 3, Ward 5',  5, 18.50440000, 73.80700000, 6, 216000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(44, 'Rohini Avhad',       'House 4, Ward 5',  5, 18.50460000, 73.80730000, 3, 30000.00,  1, 'AAY',  'Kuccha',    0, 0, 0, 0),
(45, 'Pramod Bansode',     'House 5, Ward 5',  5, 18.50480000, 73.80760000, 7, 288000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(46, 'Shobha Phadtare',    'House 6, Ward 5',  5, 18.50500000, 73.80790000, 4, 54000.00,  1, 'BPL',  'Semi-Pucca',1, 1, 0, 0),
(47, 'Dattatray Masale',   'House 7, Ward 5',  5, 18.50520000, 73.80820000, 5, 96000.00,  0, 'APL',  'Semi-Pucca',1, 1, 1, 0),
(48, 'Anuradha Chaudhari', 'House 8, Ward 5',  5, 18.50540000, 73.80850000, 3, 36000.00,  1, 'BPL',  'Kuccha',    0, 1, 0, 0),
(49, 'Shankar Gaikwad',    'House 9, Ward 5',  5, 18.50560000, 73.80880000, 6, 168000.00, 0, 'APL',  'Pucca',     1, 1, 1, 1),
(50, 'Parvati Thorat',     'House 10, Ward 5', 5, 18.50580000, 73.80910000, 4, 60000.00,  1, 'BPL',  'Semi-Pucca',0, 1, 0, 0);


-- ============================================================
-- FAMILY MEMBERS (~200 records across 50 households)
-- ============================================================
INSERT INTO family_members (household_id, name, relation, gender, date_of_birth, education, occupation, is_disabled) VALUES
-- Household 1 (Ramesh Patil — BPL, Kuccha, no toilet, no electricity)
(1, 'Ramesh Patil',    'Head',     'Male',   '1975-03-15', 'Primary',          'Daily Wage Labourer', 0),
(1, 'Savita Patil',    'Spouse',   'Female', '1978-07-22', 'Illiterate',       NULL,                  0),
(1, 'Amit Patil',      'Son',      'Male',   '1998-11-10', 'Secondary',        'Farm Helper',         0),
(1, 'Pooja Patil',     'Daughter', 'Female', '2002-05-18', 'HigherSecondary',  NULL,                  0),
(1, 'Babu Patil',      'Father',   'Male',   '1948-01-05', 'Illiterate',       NULL,                  1),

-- Household 2
(2, 'Suresh Jadhav',   'Head',     'Male',   '1980-06-20', 'Secondary',        'Mason',               0),
(2, 'Manisha Jadhav',  'Spouse',   'Female', '1983-09-14', 'Primary',          NULL,                  0),
(2, 'Rahul Jadhav',    'Son',      'Male',   '2005-02-28', 'Secondary',        NULL,                  0),
(2, 'Sneha Jadhav',    'Daughter', 'Female', '2008-12-01', 'Primary',          NULL,                  0),

-- Household 3
(3, 'Anita Deshmukh',  'Head',     'Female', '1972-04-10', 'Graduate',         'Teacher',             0),
(3, 'Rajan Deshmukh',  'Spouse',   'Male',   '1970-08-25', 'Graduate',         'Shopkeeper',          0),
(3, 'Neha Deshmukh',   'Daughter', 'Female', '1995-01-12', 'PostGraduate',     'Bank Clerk',          0),
(3, 'Vikram Deshmukh', 'Son',      'Male',   '1997-06-30', 'Graduate',         'Software Developer',  0),
(3, 'Pari Deshmukh',   'Daughter', 'Female', '2010-03-05', 'Primary',          NULL,                  0),
(3, 'Kamala Deshmukh', 'Mother',   'Female', '1945-11-20', 'Illiterate',       NULL,                  1),

-- Household 4
(4, 'Vikas More',      'Head',     'Male',   '1985-12-08', 'Illiterate',       'Daily Wage Labourer', 0),
(4, 'Rani More',       'Spouse',   'Female', '1988-03-25', 'Illiterate',       NULL,                  0),
(4, 'Rohit More',      'Son',      'Male',   '2012-07-15', 'Primary',          NULL,                  0),

-- Household 5
(5, 'Priya Kulkarni',  'Head',     'Female', '1968-09-01', 'PostGraduate',     'Principal',           0),
(5, 'Mahesh Kulkarni', 'Spouse',   'Male',   '1965-02-14', 'Graduate',         'Retired Officer',     0),
(5, 'Aditi Kulkarni',  'Daughter', 'Female', '1990-11-22', 'PostGraduate',     'Doctor',              0),
(5, 'Nikhil Kulkarni', 'Son',      'Male',   '1993-04-08', 'Graduate',         'Engineer',            0),
(5, 'Sakshi Kulkarni', 'Daughter', 'Female', '2000-08-17', 'HigherSecondary',  'Student',             0),
(5, 'Sharda Kulkarni', 'Mother',   'Female', '1940-06-30', 'Primary',          NULL,                  1),
(5, 'Arjun Kulkarni',  'Son',      'Male',   '2005-12-25', 'Secondary',        NULL,                  0),

-- Household 6
(6, 'Ganesh Shinde',   'Head',     'Male',   '1982-01-18', 'Primary',          'Auto Driver',         0),
(6, 'Manda Shinde',    'Spouse',   'Female', '1985-05-10', 'Illiterate',       NULL,                  0),
(6, 'Tushar Shinde',   'Son',      'Male',   '2007-09-22', 'Secondary',        NULL,                  0),
(6, 'Komal Shinde',    'Daughter', 'Female', '2010-04-14', 'Primary',          NULL,                  0),

-- Household 7
(7, 'Sunita Pawar',    'Head',     'Female', '1976-07-05', 'Secondary',        'Tailor',              0),
(7, 'Deepak Pawar',    'Son',      'Male',   '1999-03-20', 'HigherSecondary',  'Electrician',         0),
(7, 'Pallavi Pawar',   'Daughter', 'Female', '2001-10-12', 'Graduate',         'Student',             0),
(7, 'Ajay Pawar',      'Son',      'Male',   '2006-06-28', 'Secondary',        NULL,                  0),
(7, 'Tai Pawar',       'Mother',   'Female', '1950-02-15', 'Illiterate',       NULL,                  0),

-- Household 8
(8, 'Manoj Gaikwad',   'Head',     'Male',   '1990-08-12', 'Primary',          'Painter',             0),
(8, 'Seema Gaikwad',   'Spouse',   'Female', '1992-11-30', 'Primary',          NULL,                  0),
(8, 'Tanvi Gaikwad',   'Daughter', 'Female', '2015-05-20', 'Illiterate',       NULL,                  0),

-- Household 9
(9, 'Kavita Bhosale',  'Head',     'Female', '1969-12-18', 'Graduate',         'Gram Sevak',          0),
(9, 'Shankar Bhosale', 'Spouse',   'Male',   '1967-04-05', 'Graduate',         'Farmer',              0),
(9, 'Yogesh Bhosale',  'Son',      'Male',   '1992-08-14', 'PostGraduate',     'Professor',           0),
(9, 'Swati Bhosale',   'Daughter', 'Female', '1995-01-30', 'Graduate',         'Nurse',               0),
(9, 'Omkar Bhosale',   'Son',      'Male',   '2003-11-11', 'HigherSecondary',  'Student',             0),
(9, 'Aaji Bhosale',    'Mother',   'Female', '1942-07-20', 'Illiterate',       NULL,                  1),

-- Household 10
(10, 'Ravi Chavan',     'Head',     'Male',   '1984-05-28', 'Secondary',       'Carpenter',           0),
(10, 'Asha Chavan',     'Spouse',   'Female', '1987-09-15', 'Primary',         NULL,                  0),
(10, 'Vishal Chavan',   'Son',      'Male',   '2009-02-10', 'Primary',         NULL,                  0),
(10, 'Rupa Chavan',     'Daughter', 'Female', '2012-08-22', 'Illiterate',      NULL,                  0),

-- Households 11-20 (Ward 2) — abbreviated but representative
(11, 'Ashok Kadam',     'Head',     'Male',   '1977-10-05', 'Primary',         'Farmer',              0),
(11, 'Laxmi Kadam',     'Spouse',   'Female', '1980-03-18', 'Illiterate',      NULL,                  0),
(11, 'Sunil Kadam',     'Son',      'Male',   '2001-07-22', 'HigherSecondary', 'Farm Helper',         0),
(11, 'Anita Kadam',     'Daughter', 'Female', '2004-12-10', 'Secondary',       NULL,                  0),
(11, 'Balu Kadam',      'Father',   'Male',   '1950-06-15', 'Illiterate',      NULL,                  1),

(12, 'Meena Thombare',  'Head',     'Female', '1979-04-22', 'HigherSecondary', 'Anganwadi Worker',    0),
(12, 'Sagar Thombare',  'Son',      'Male',   '2002-08-14', 'Graduate',        'Student',             0),
(12, 'Disha Thombare',  'Daughter', 'Female', '2006-01-30', 'Secondary',       NULL,                  0),
(12, 'Nana Thombare',   'Father',   'Male',   '1952-11-05', 'Primary',         NULL,                  0),

(13, 'Rajendra Mane',   'Head',     'Male',   '1971-06-10', 'Graduate',        'Government Clerk',    0),
(13, 'Suvarna Mane',    'Spouse',   'Female', '1974-09-28', 'Secondary',       'Housewife',           0),
(13, 'Akshay Mane',     'Son',      'Male',   '1996-03-15', 'PostGraduate',    'IT Professional',     0),
(13, 'Aparna Mane',     'Daughter', 'Female', '1999-07-20', 'Graduate',        'Teacher',             0),
(13, 'Aditya Mane',     'Son',      'Male',   '2005-12-08', 'Secondary',       NULL,                  0),
(13, 'Lakshmi Mane',    'Mother',   'Female', '1946-04-12', 'Illiterate',      NULL,                  1),

(14, 'Suman Nikam',     'Head',     'Male',   '1987-11-25', 'Illiterate',      'Rag Picker',          0),
(14, 'Parvati Nikam',   'Spouse',   'Female', '1990-02-08', 'Illiterate',      NULL,                  0),
(14, 'Karan Nikam',     'Son',      'Male',   '2014-06-18', 'Illiterate',      NULL,                  0),

(15, 'Deepak Salve',    'Head',     'Male',   '1981-03-14', 'Secondary',       'Plumber',             0),
(15, 'Rani Salve',      'Spouse',   'Female', '1984-08-20', 'Primary',         NULL,                  0),
(15, 'Mayur Salve',     'Son',      'Male',   '2006-05-10', 'Secondary',       NULL,                  0),
(15, 'Priti Salve',     'Daughter', 'Female', '2009-11-28', 'Primary',         NULL,                  0),
(15, 'Nisha Salve',     'Daughter', 'Female', '2013-04-15', 'Illiterate',      NULL,                  0),

(16, 'Lata Wagh',       'Head',     'Female', '1983-07-10', 'Illiterate',      'Domestic Help',       0),
(16, 'Sagar Wagh',      'Son',      'Male',   '2004-01-22', 'Secondary',       NULL,                  0),
(16, 'Sakshi Wagh',     'Daughter', 'Female', '2007-09-05', 'Primary',         NULL,                  0),
(16, 'Ajoba Wagh',      'Father',   'Male',   '1955-12-18', 'Illiterate',      NULL,                  1),

(17, 'Prakash Dhole',   'Head',     'Male',   '1966-02-28', 'PostGraduate',    'Businessman',         0),
(17, 'Sarita Dhole',    'Spouse',   'Female', '1970-05-15', 'Graduate',        'Housewife',           0),
(17, 'Rohan Dhole',     'Son',      'Male',   '1994-09-10', 'PostGraduate',    'CA',                  0),
(17, 'Shruti Dhole',    'Daughter', 'Female', '1997-12-22', 'Graduate',        'Fashion Designer',    0),
(17, 'Kunal Dhole',     'Son',      'Male',   '2001-04-05', 'HigherSecondary', 'Student',             0),
(17, 'Aai Dhole',       'Mother',   'Female', '1940-08-30', 'Primary',         NULL,                  1),
(17, 'Tanmay Dhole',    'Son',      'Male',   '2008-07-18', 'Primary',         NULL,                  0),

(18, 'Rekha Borse',     'Head',     'Female', '1986-10-12', 'Primary',         'Vegetable Seller',    0),
(18, 'Ganpat Borse',    'Spouse',   'Male',   '1984-01-30', 'Secondary',       'Rickshaw Driver',     0),
(18, 'Prashant Borse',  'Son',      'Male',   '2010-06-25', 'Primary',         NULL,                  0),

(19, 'Nilesh Kale',     'Head',     'Male',   '1974-08-18', 'Graduate',        'Dairy Farmer',        0),
(19, 'Sunanda Kale',    'Spouse',   'Female', '1977-12-05', 'Secondary',       NULL,                  0),
(19, 'Swapnil Kale',    'Son',      'Male',   '2000-03-22', 'Graduate',        'Veterinary Asst.',    0),
(19, 'Gauri Kale',      'Daughter', 'Female', '2003-09-14', 'HigherSecondary', 'Student',             0),
(19, 'Nitin Kale',      'Son',      'Male',   '2008-01-08', 'Secondary',       NULL,                  0),

(20, 'Asha Lokhande',   'Head',     'Female', '1989-05-20', 'Illiterate',      'Brick Kiln Worker',   0),
(20, 'Ramesh Lokhande', 'Spouse',   'Male',   '1986-10-08', 'Primary',         'Brick Kiln Worker',   0),
(20, 'Tejas Lokhande',  'Son',      'Male',   '2011-03-12', 'Primary',         NULL,                  0),
(20, 'Sita Lokhande',   'Daughter', 'Female', '2014-08-28', 'Illiterate',      NULL,                  0),

-- Households 21-30 (Ward 3)
(21, 'Sanjay Gholap',   'Head',     'Male',   '1978-11-15', 'Secondary',       'Welder',              0),
(21, 'Jaya Gholap',     'Spouse',   'Female', '1981-04-22', 'Primary',         NULL,                  0),
(21, 'Akash Gholap',    'Son',      'Male',   '2003-07-10', 'HigherSecondary', 'Student',             0),
(21, 'Divya Gholap',    'Daughter', 'Female', '2007-01-18', 'Secondary',       NULL,                  0),
(21, 'Rani Gholap',     'Mother',   'Female', '1952-09-05', 'Illiterate',      NULL,                  0),

(22, 'Vaishali Ahire',  'Head',     'Female', '1970-03-08', 'PostGraduate',    'Doctor',              0),
(22, 'Nitin Ahire',     'Spouse',   'Male',   '1968-07-25', 'PostGraduate',    'Advocate',            0),
(22, 'Mrunmayee Ahire', 'Daughter', 'Female', '1995-12-14', 'PostGraduate',    'Surgeon',             0),
(22, 'Aarush Ahire',    'Son',      'Male',   '1998-05-30', 'Graduate',        'MBA Student',         0),
(22, 'Ruhi Ahire',      'Daughter', 'Female', '2005-10-20', 'Secondary',       NULL,                  0),
(22, 'Nana Ahire',      'Father',   'Male',   '1940-01-10', 'Secondary',       NULL,                  1),

(23, 'Dnyaneshwar Raut','Head',     'Male',   '1988-06-30', 'Primary',         'Shepherd',            0),
(23, 'Alka Raut',       'Spouse',   'Female', '1991-10-15', 'Illiterate',      NULL,                  0),
(23, 'Sachin Raut',     'Son',      'Male',   '2013-04-08', 'Illiterate',      NULL,                  0),

(24, 'Jyoti Sonawane',  'Head',     'Female', '1980-09-25', 'HigherSecondary', 'ASHA Worker',         0),
(24, 'Vinod Sonawane',  'Spouse',   'Male',   '1978-01-12', 'Secondary',       'Mechanic',            0),
(24, 'Pranjal Sonawane','Son',      'Male',   '2004-06-18', 'Secondary',       NULL,                  0),
(24, 'Shraddha Sonawane','Daughter','Female', '2008-11-30', 'Primary',         NULL,                  0),

(25, 'Balaji Yadav',    'Head',     'Male',   '1964-04-10', 'Graduate',        'Retired Army',        0),
(25, 'Sushma Yadav',    'Spouse',   'Female', '1968-08-22', 'Secondary',       'Housewife',           0),
(25, 'Ajinkya Yadav',   'Son',      'Male',   '1991-02-15', 'PostGraduate',    'Bank Manager',        0),
(25, 'Sayali Yadav',    'Daughter', 'Female', '1994-07-05', 'Graduate',        'CA',                  0),
(25, 'Aarav Yadav',     'Son',      'Male',   '2000-12-28', 'HigherSecondary', 'Student',             0),
(25, 'Teju Yadav',      'Daughter', 'Female', '2005-05-14', 'Secondary',       NULL,                  0),
(25, 'Nani Yadav',      'Mother',   'Female', '1938-03-20', 'Illiterate',      NULL,                  1),

(26, 'Mangala Devkar',  'Head',     'Female', '1986-12-05', 'Illiterate',      'Farm Labourer',       0),
(26, 'Suresh Devkar',   'Spouse',   'Male',   '1983-05-18', 'Primary',         'Farm Labourer',       0),
(26, 'Tejas Devkar',    'Son',      'Male',   '2009-08-10', 'Primary',         NULL,                  0),
(26, 'Manasi Devkar',   'Daughter', 'Female', '2012-02-28', 'Illiterate',      NULL,                  0),

(27, 'Tukaram Bhagat',  'Head',     'Male',   '1975-07-20', 'Secondary',       'Electrician',         0),
(27, 'Maya Bhagat',     'Spouse',   'Female', '1978-11-10', 'Primary',         NULL,                  0),
(27, 'Pratik Bhagat',   'Son',      'Male',   '2001-04-25', 'HigherSecondary', 'Apprentice',          0),
(27, 'Snehal Bhagat',   'Daughter', 'Female', '2004-09-15', 'Secondary',       NULL,                  0),
(27, 'Aaji Bhagat',     'Mother',   'Female', '1948-06-30', 'Illiterate',      NULL,                  1),

(28, 'Pushpa Waghmare', 'Head',     'Female', '1991-01-14', 'Illiterate',      'Domestic Help',       0),
(28, 'Atul Waghmare',   'Spouse',   'Male',   '1989-05-08', 'Primary',         'Scrap Collector',     0),
(28, 'Sahil Waghmare',  'Son',      'Male',   '2015-10-20', 'Illiterate',      NULL,                  0),

(29, 'Anil Kamble',     'Head',     'Male',   '1973-09-18', 'Graduate',        'Govt. Teacher',       0),
(29, 'Madhuri Kamble',  'Spouse',   'Female', '1976-02-05', 'HigherSecondary', NULL,                  0),
(29, 'Omkar Kamble',    'Son',      'Male',   '1999-06-22', 'Graduate',        'Software Engineer',   0),
(29, 'Rutuja Kamble',   'Daughter', 'Female', '2002-11-10', 'HigherSecondary', 'Student',             0),
(29, 'Arya Kamble',     'Son',      'Male',   '2008-04-28', 'Secondary',       NULL,                  0),
(29, 'Tai Kamble',      'Mother',   'Female', '1947-08-15', 'Illiterate',      NULL,                  1),

(30, 'Vandana Kokate',  'Head',     'Female', '1984-02-10', 'Primary',         'Maid',                0),
(30, 'Rahul Kokate',    'Spouse',   'Male',   '1982-06-28', 'Secondary',       'Security Guard',      0),
(30, 'Nikita Kokate',   'Daughter', 'Female', '2006-10-15', 'Secondary',       NULL,                  0),
(30, 'Sumit Kokate',    'Son',      'Male',   '2010-03-22', 'Primary',         NULL,                  0),

-- Households 31-40 (Ward 4) — condensed inserts
(31, 'Santosh Ubale',   'Head',     'Male',   '1980-04-15', 'Primary',         'Potter',              0),
(31, 'Kamal Ubale',     'Spouse',   'Female', '1983-08-22', 'Illiterate',      NULL,                  0),
(31, 'Keshav Ubale',    'Son',      'Male',   '2005-01-10', 'Secondary',       NULL,                  0),
(31, 'Sai Ubale',       'Daughter', 'Female', '2008-06-28', 'Primary',         NULL,                  0),
(31, 'Aaji Ubale',      'Mother',   'Female', '1953-12-05', 'Illiterate',      NULL,                  1),

(32, 'Chhaya Khedkar',  'Head',     'Female', '1975-10-20', 'Graduate',        'Sarpanch',            0),
(32, 'Vinay Khedkar',   'Spouse',   'Male',   '1973-03-08', 'Graduate',        'Farmer',              0),
(32, 'Aditya Khedkar',  'Son',      'Male',   '1998-07-15', 'PostGraduate',    'Civil Engineer',      0),
(32, 'Manasi Khedkar',  'Daughter', 'Female', '2001-12-30', 'Graduate',        'Student',             0),

(33, 'Yashwant Londhe', 'Head',     'Male',   '1970-01-25', 'Graduate',        'Panchayat Member',    0),
(33, 'Sunanda Londhe',  'Spouse',   'Female', '1973-05-10', 'Secondary',       NULL,                  0),
(33, 'Tejas Londhe',    'Son',      'Male',   '1996-09-18', 'PostGraduate',    'Architect',           0),
(33, 'Rucha Londhe',    'Daughter', 'Female', '1999-02-05', 'Graduate',        'Dentist',             0),
(33, 'Parth Londhe',    'Son',      'Male',   '2004-07-22', 'Secondary',       NULL,                  0),
(33, 'Nani Londhe',     'Mother',   'Female', '1944-10-15', 'Illiterate',      NULL,                  1),

(34, 'Indira Gawade',   'Head',     'Female', '1990-08-12', 'Illiterate',      'Construction Worker', 0),
(34, 'Balram Gawade',   'Spouse',   'Male',   '1988-01-25', 'Primary',         'Construction Worker', 0),
(34, 'Nisha Gawade',    'Daughter', 'Female', '2014-05-08', 'Illiterate',      NULL,                  0),

(35, 'Kiran Shelke',    'Head',     'Male',   '1979-06-18', 'HigherSecondary', 'Trader',              0),
(35, 'Ashwini Shelke',  'Spouse',   'Female', '1982-10-05', 'Secondary',       NULL,                  0),
(35, 'Tanmay Shelke',   'Son',      'Male',   '2004-03-22', 'Secondary',       NULL,                  0),
(35, 'Ketaki Shelke',   'Daughter', 'Female', '2007-08-14', 'Primary',         NULL,                  0),
(35, 'Arya Shelke',     'Son',      'Male',   '2012-01-30', 'Primary',         NULL,                  0),

(36, 'Nirmala Bhandare','Head',     'Female', '1965-03-22', 'PostGraduate',    'Retired Teacher',     0),
(36, 'Vasant Bhandare', 'Spouse',   'Male',   '1963-07-10', 'PostGraduate',    'Retired Engineer',    0),
(36, 'Amit Bhandare',   'Son',      'Male',   '1989-11-28', 'PostGraduate',    'Professor',           0),
(36, 'Smita Bhandare',  'Daughter', 'Female', '1992-04-15', 'Graduate',        'Journalist',          0),
(36, 'Kusum Bhandare',  'Mother',   'Female', '1938-09-20', 'Primary',         NULL,                  1),
(36, 'Varun Bhandare',  'Son',      'Male',   '1995-08-05', 'Graduate',        'Businessman',         0),
(36, 'Riya Bhandare',   'Daughter', 'Female', '2002-02-18', 'HigherSecondary', 'Student',             0),

(37, 'Bhimrao Thombre', 'Head',     'Male',   '1983-09-10', 'Primary',         'Cobbler',             0),
(37, 'Shanta Thombre',  'Spouse',   'Female', '1986-01-28', 'Illiterate',      NULL,                  0),
(37, 'Sahil Thombre',   'Son',      'Male',   '2008-05-15', 'Primary',         NULL,                  0),
(37, 'Aisha Thombre',   'Daughter', 'Female', '2011-10-22', 'Primary',         NULL,                  0),

(38, 'Savita Pardeshi', 'Head',     'Female', '1985-04-18', 'Secondary',       'Seamstress',          0),
(38, 'Vinod Pardeshi',  'Spouse',   'Male',   '1982-08-05', 'Secondary',       'Weaver',              0),
(38, 'Piyush Pardeshi', 'Son',      'Male',   '2010-12-10', 'Primary',         NULL,                  0),

(39, 'Arun Khairnar',   'Head',     'Male',   '1972-11-30', 'Graduate',        'Businessman',         0),
(39, 'Smita Khairnar',  'Spouse',   'Female', '1975-04-18', 'Graduate',        'Housewife',           0),
(39, 'Hrithik Khairnar','Son',      'Male',   '1998-08-10', 'PostGraduate',    'MBA',                 0),
(39, 'Ishita Khairnar', 'Daughter', 'Female', '2001-01-25', 'Graduate',        'Student',             0),
(39, 'Arjun Khairnar',  'Son',      'Male',   '2005-06-15', 'Secondary',       NULL,                  0),
(39, 'Nani Khairnar',   'Mother',   'Female', '1945-03-08', 'Illiterate',      NULL,                  1),

(40, 'Usha Nimbalkar',  'Head',     'Female', '1988-02-14', 'Illiterate',      'Scrap Collector',     0),
(40, 'Kailash Nimbalkar','Spouse',  'Male',   '1985-07-22', 'Primary',         'Cart Puller',         0),
(40, 'Sachin Nimbalkar', 'Son',     'Male',   '2011-04-10', 'Primary',         NULL,                  0),
(40, 'Neeta Nimbalkar', 'Daughter', 'Female', '2014-09-28', 'Illiterate',      NULL,                  0),

-- Households 41-50 (Ward 5) — condensed
(41, 'Mohan Dhage',     'Head',     'Male',   '1976-05-10', 'HigherSecondary', 'Milk Vendor',         0),
(41, 'Suman Dhage',     'Spouse',   'Female', '1979-09-22', 'Secondary',       NULL,                  0),
(41, 'Akshay Dhage',    'Son',      'Male',   '2002-02-15', 'Graduate',        'Student',             0),
(41, 'Sayali Dhage',    'Daughter', 'Female', '2005-07-28', 'Secondary',       NULL,                  0),
(41, 'Ajoba Dhage',     'Father',   'Male',   '1949-12-10', 'Primary',         NULL,                  1),

(42, 'Sangita Handore', 'Head',     'Female', '1984-08-18', 'Primary',         'Farm Labourer',       0),
(42, 'Ramchandra Handore','Spouse', 'Male',   '1981-01-05', 'Primary',         'Farm Labourer',       0),
(42, 'Ajay Handore',    'Son',      'Male',   '2007-04-22', 'Secondary',       NULL,                  0),
(42, 'Sita Handore',    'Daughter', 'Female', '2010-10-15', 'Primary',         NULL,                  0),

(43, 'Vitthal Gadekar', 'Head',     'Male',   '1969-12-28', 'PostGraduate',    'Retired Professor',   0),
(43, 'Mangal Gadekar',  'Spouse',   'Female', '1972-04-15', 'Graduate',        'Housewife',           0),
(43, 'Gaurav Gadekar',  'Son',      'Male',   '1995-08-10', 'PostGraduate',    'Data Scientist',      0),
(43, 'Pallavi Gadekar', 'Daughter', 'Female', '1998-01-25', 'Graduate',        'Physiotherapist',     0),
(43, 'Ayush Gadekar',   'Son',      'Male',   '2003-06-18', 'HigherSecondary', 'Student',             0),
(43, 'Aaji Gadekar',    'Mother',   'Female', '1942-10-05', 'Primary',         NULL,                  1),

(44, 'Rohini Avhad',    'Head',     'Female', '1992-03-10', 'Illiterate',      'Sweeper',             0),
(44, 'Manoj Avhad',     'Spouse',   'Male',   '1989-07-28', 'Primary',         'Cleaner',             0),
(44, 'Aryan Avhad',     'Son',      'Male',   '2016-11-15', 'Illiterate',      NULL,                  0),

(45, 'Pramod Bansode',  'Head',     'Male',   '1967-08-22', 'Graduate',        'Contractor',          0),
(45, 'Leela Bansode',   'Spouse',   'Female', '1970-12-10', 'HigherSecondary', 'Housewife',           0),
(45, 'Swapnil Bansode', 'Son',      'Male',   '1993-04-05', 'PostGraduate',    'Lawyer',              0),
(45, 'Manisha Bansode', 'Daughter', 'Female', '1996-09-18', 'Graduate',        'Pharmacist',          0),
(45, 'Tanvi Bansode',   'Daughter', 'Female', '2000-02-28', 'HigherSecondary', 'Student',             0),
(45, 'Vedant Bansode',  'Son',      'Male',   '2005-07-15', 'Secondary',       NULL,                  0),
(45, 'Aaji Bansode',    'Mother',   'Female', '1941-05-20', 'Illiterate',      NULL,                  1),

(46, 'Shobha Phadtare', 'Head',     'Female', '1981-06-14', 'Secondary',       'Pottery Worker',      0),
(46, 'Dattatray Phadtare','Spouse', 'Male',   '1979-10-28', 'Secondary',       'Potter',              0),
(46, 'Anurag Phadtare', 'Son',      'Male',   '2004-03-10', 'Secondary',       NULL,                  0),
(46, 'Mansi Phadtare',  'Daughter', 'Female', '2008-08-22', 'Primary',         NULL,                  0),

(47, 'Dattatray Masale','Head',     'Male',   '1977-01-18', 'HigherSecondary', 'Mechanic',            0),
(47, 'Alka Masale',     'Spouse',   'Female', '1980-05-05', 'Secondary',       NULL,                  0),
(47, 'Rohan Masale',    'Son',      'Male',   '2003-10-22', 'HigherSecondary', 'Student',             0),
(47, 'Priya Masale',    'Daughter', 'Female', '2006-04-15', 'Secondary',       NULL,                  0),
(47, 'Nana Masale',     'Father',   'Male',   '1950-08-30', 'Primary',         NULL,                  0),

(48, 'Anuradha Chaudhari','Head',   'Female', '1987-09-25', 'Illiterate',      'Domestic Help',       0),
(48, 'Vilas Chaudhari', 'Spouse',   'Male',   '1984-02-10', 'Primary',         'Watchman',            0),
(48, 'Mayuri Chaudhari','Daughter', 'Female', '2012-06-18', 'Primary',         NULL,                  0),

(49, 'Shankar Gaikwad', 'Head',     'Male',   '1971-07-05', 'Graduate',        'Postmaster',          0),
(49, 'Shobha Gaikwad',  'Spouse',   'Female', '1974-11-22', 'Secondary',       NULL,                  0),
(49, 'Abhijeet Gaikwad','Son',      'Male',   '1997-03-15', 'PostGraduate',    'Scientist',           0),
(49, 'Pooja Gaikwad',   'Daughter', 'Female', '2000-08-28', 'Graduate',        'Teacher',             0),
(49, 'Vivek Gaikwad',   'Son',      'Male',   '2005-01-10', 'Secondary',       NULL,                  0),
(49, 'Aaji Gaikwad',    'Mother',   'Female', '1944-06-18', 'Illiterate',      NULL,                  1),

(50, 'Parvati Thorat',  'Head',     'Female', '1983-11-08', 'Primary',         'Tailoring',           0),
(50, 'Santosh Thorat',  'Spouse',   'Male',   '1980-03-20', 'Secondary',       'Driver',              0),
(50, 'Kunal Thorat',    'Son',      'Male',   '2006-07-15', 'Secondary',       NULL,                  0),
(50, 'Shruti Thorat',   'Daughter', 'Female', '2009-12-28', 'Primary',         NULL,                  0);


-- ============================================================
-- AGRICULTURE (~30 households with farming records)
-- ============================================================
INSERT INTO agriculture (household_id, land_area_acres, crop_type, season, irrigation_type, soil_type, annual_yield_kg, crop_year) VALUES
(1,  0.50, 'Rice',        'Kharif', 'Rainfed',   'Alluvial',  400.00,  2025),
(2,  1.00, 'Wheat',       'Rabi',   'Well',      'Black',     900.00,  2025),
(3,  3.00, 'Sugarcane',   'Kharif', 'Canal',     'Black',     18000.00,2025),
(5,  5.00, 'Soybean',     'Kharif', 'Drip',      'Red',       4500.00, 2025),
(6,  0.25, 'Jowar',       'Rabi',   'Rainfed',   'Red',       150.00,  2025),
(7,  1.50, 'Onion',       'Rabi',   'Borewell',  'Black',     2200.00, 2025),
(9,  4.00, 'Grapes',      'Zaid',   'Drip',      'Red',       8000.00, 2025),
(10, 0.75, 'Bajra',       'Kharif', 'Rainfed',   'Sandy',     400.00,  2025),
(11, 2.00, 'Cotton',      'Kharif', 'Rainfed',   'Black',     1200.00, 2025),
(12, 1.00, 'Wheat',       'Rabi',   'Well',      'Alluvial',  850.00,  2025),
(13, 2.50, 'Turmeric',    'Kharif', 'Sprinkler', 'Red',       3000.00, 2025),
(15, 1.00, 'Onion',       'Rabi',   'Borewell',  'Black',     1500.00, 2025),
(17, 8.00, 'Pomegranate', 'Zaid',   'Drip',      'Red',       12000.00,2025),
(19, 3.00, 'Sugarcane',   'Kharif', 'Canal',     'Black',     17000.00,2025),
(21, 1.00, 'Jowar',       'Rabi',   'Rainfed',   'Sandy',     600.00,  2025),
(22, 4.00, 'Grapes',      'Zaid',   'Drip',      'Red',       7500.00, 2025),
(23, 0.50, 'Rice',        'Kharif', 'Rainfed',   'Alluvial',  350.00,  2025),
(25, 6.00, 'Mango',       'Zaid',   'Sprinkler', 'Laterite',  5000.00, 2025),
(27, 1.50, 'Wheat',       'Rabi',   'Well',      'Black',     1200.00, 2025),
(29, 2.00, 'Soybean',     'Kharif', 'Borewell',  'Black',     1800.00, 2025),
(31, 0.50, 'Bajra',       'Kharif', 'Rainfed',   'Sandy',     250.00,  2025),
(32, 3.50, 'Sugarcane',   'Kharif', 'Canal',     'Black',     20000.00,2025),
(33, 2.00, 'Cotton',      'Kharif', 'Borewell',  'Black',     1400.00, 2025),
(35, 1.50, 'Tomato',      'Rabi',   'Drip',      'Red',       3500.00, 2025),
(36, 4.00, 'Pomegranate', 'Zaid',   'Drip',      'Red',       6000.00, 2025),
(39, 3.00, 'Turmeric',    'Kharif', 'Sprinkler', 'Red',       3200.00, 2025),
(41, 1.00, 'Rice',        'Kharif', 'Rainfed',   'Alluvial',  700.00,  2025),
(43, 2.00, 'Wheat',       'Rabi',   'Well',      'Black',     1600.00, 2025),
(45, 5.00, 'Mango',       'Zaid',   'Sprinkler', 'Laterite',  4200.00, 2025),
(47, 1.00, 'Onion',       'Rabi',   'Borewell',  'Black',     1400.00, 2025),
(49, 2.50, 'Grapes',      'Zaid',   'Drip',      'Red',       5000.00, 2025);


-- ============================================================
-- SCHEMES (8 government welfare schemes)
-- ============================================================
INSERT INTO schemes (id, name, code, category, description, eligibility) VALUES
(1, 'Pradhan Mantri Awas Yojana',       'PMAY',     'Housing',     'Housing for all — subsidized housing for BPL families',                '{"bpl": true, "house_type": ["Kuccha"]}'),
(2, 'Mahatma Gandhi NREGA',             'MGNREGA',  'Employment',  '100 days guaranteed employment for rural households',                   '{"bpl": true}'),
(3, 'PM Kisan Samman Nidhi',            'PMKISAN',  'Agriculture', 'Rs. 6000/year income support for small/marginal farmers',               '{"has_agriculture": true, "land_area_max": 5}'),
(4, 'Pradhan Mantri Ujjwala Yojana',    'UJJWALA',  'Welfare',     'Free LPG connections for BPL women',                                    '{"bpl": true, "has_gas": false}'),
(5, 'Ayushman Bharat PMJAY',            'AYUSHMAN', 'Health',      'Health insurance cover of Rs. 5 lakh/year for BPL families',             '{"bpl": true}'),
(6, 'Jan Dhan Yojana',                  'JANDHAN',  'Financial',   'Zero-balance bank accounts with RuPay debit card and insurance',         '{"all": true}'),
(7, 'Kisan Credit Card',                'KCC',      'Agriculture', 'Short-term credit for crop production and allied activities',             '{"has_agriculture": true}'),
(8, 'Mid-Day Meal Scheme',              'MDM',      'Education',   'Free lunch for school-going children (Class 1-8)',                       '{"age_min": 6, "age_max": 14}');


-- ============================================================
-- HOUSEHOLD SCHEME ENROLLMENTS
-- Intentional gaps: many BPL families NOT enrolled in PMAY, Ujjwala, etc.
-- ============================================================
INSERT INTO household_schemes (household_id, scheme_id, enrolled_on, status) VALUES
-- Household 1 (BPL, Kuccha — should be in PMAY but ISN'T — this is a gap)
(1,  2, '2022-06-15', 'Active'),  -- MGNREGA only

-- Household 2 (BPL)
(2,  2, '2021-04-10', 'Active'),  -- MGNREGA
(2,  5, '2023-01-20', 'Active'),  -- AYUSHMAN
(2,  6, '2020-08-05', 'Active'),  -- JANDHAN

-- Household 3 (APL — enrolled in farmer schemes)
(3,  3, '2022-02-15', 'Active'),  -- PMKISAN
(3,  7, '2021-09-10', 'Active'),  -- KCC
(3,  6, '2019-03-22', 'Active'),  -- JANDHAN

-- Household 4 (BPL, AAY, Kuccha — NO schemes at all — biggest gap)
-- intentionally empty

-- Household 5 (APL, high income)
(5,  3, '2022-05-18', 'Active'),  -- PMKISAN
(5,  7, '2021-11-30', 'Active'),  -- KCC
(5,  6, '2019-07-14', 'Active'),  -- JANDHAN

-- Household 6 (BPL)
(6,  2, '2022-03-08', 'Active'),  -- MGNREGA
(6,  4, '2023-06-20', 'Active'),  -- UJJWALA

-- Household 8 (BPL — has MGNREGA but missing PMAY)
(8,  2, '2022-01-15', 'Active'),  -- MGNREGA
(8,  5, '2023-04-10', 'Active'),  -- AYUSHMAN

-- Household 9 (APL, farmer)
(9,  3, '2022-08-22', 'Active'),  -- PMKISAN
(9,  7, '2022-01-05', 'Active'),  -- KCC

-- Household 10 (BPL)
(10, 2, '2021-07-18', 'Active'),  -- MGNREGA
(10, 6, '2020-05-30', 'Active'),  -- JANDHAN

-- Household 11 (BPL, farmer — has MGNREGA but not PMKISAN — gap)
(11, 2, '2022-02-28', 'Active'),  -- MGNREGA

-- Household 14 (BPL, AAY — NO schemes — major gap)
-- intentionally empty

-- Household 16 (BPL)
(16, 2, '2023-01-05', 'Active'),  -- MGNREGA

-- Household 17 (APL, wealthy farmer)
(17, 3, '2022-06-10', 'Active'),  -- PMKISAN
(17, 7, '2021-12-22', 'Active'),  -- KCC

-- Household 20 (BPL — NO schemes — gap)
-- intentionally empty

-- Household 23 (BPL — has only MGNREGA, missing PMAY for Kuccha)
(23, 2, '2022-08-15', 'Active'),  -- MGNREGA

-- Household 26 (BPL, Kuccha — no schemes — gap)
-- intentionally empty

-- Household 28 (BPL, AAY — only MGNREGA)
(28, 2, '2023-03-10', 'Active'),  -- MGNREGA

-- Household 30 (BPL)
(30, 2, '2022-05-20', 'Active'),  -- MGNREGA
(30, 5, '2023-07-15', 'Active'),  -- AYUSHMAN

-- Household 31 (BPL, farmer)
(31, 2, '2022-09-10', 'Active'),  -- MGNREGA

-- Household 34 (BPL, Kuccha — NO schemes — gap)
-- intentionally empty

-- Household 37 (BPL)
(37, 2, '2023-02-18', 'Active'),  -- MGNREGA
(37, 4, '2023-09-05', 'Active'),  -- UJJWALA

-- Household 38 (BPL)
(38, 2, '2022-11-22', 'Active'),  -- MGNREGA

-- Household 40 (BPL, AAY — no schemes — gap)
-- intentionally empty

-- Household 42 (BPL)
(42, 2, '2023-04-28', 'Active'),  -- MGNREGA

-- Household 44 (BPL, AAY — no schemes — gap)
-- intentionally empty

-- Household 46 (BPL)
(46, 2, '2022-10-15', 'Active'),  -- MGNREGA
(46, 6, '2020-12-10', 'Active'),  -- JANDHAN

-- Household 48 (BPL — only MGNREGA)
(48, 2, '2023-05-22', 'Active'),  -- MGNREGA

-- Household 50 (BPL)
(50, 2, '2022-07-30', 'Active'),  -- MGNREGA
(50, 5, '2023-08-18', 'Active');  -- AYUSHMAN


-- ============================================================
-- ASSETS (sample records across households)
-- ============================================================
INSERT INTO assets (household_id, asset_type, description, quantity, est_value) VALUES
(1,  'Cattle',      'Cow',                 1,  25000.00),
(2,  'Vehicle',     'Bicycle',             1,  3000.00),
(3,  'Land',        'Agricultural Land',   1,  1500000.00),
(3,  'Vehicle',     'Car (Maruti Swift)',   1,  600000.00),
(3,  'Electronics', 'Television',          1,  25000.00),
(5,  'Land',        'Agricultural Land',   1,  2500000.00),
(5,  'Vehicle',     'Car (Honda City)',     1,  1200000.00),
(5,  'Electronics', 'Laptop',              2,  120000.00),
(5,  'Electronics', 'Television',          2,  80000.00),
(6,  'Vehicle',     'Auto Rickshaw',       1,  250000.00),
(7,  'Machinery',   'Sewing Machine',      2,  30000.00),
(9,  'Land',        'Agricultural Land',   1,  2000000.00),
(9,  'Vehicle',     'Tractor',             1,  800000.00),
(9,  'Cattle',      'Cow',                 3,  75000.00),
(11, 'Land',        'Agricultural Land',   1,  800000.00),
(11, 'Cattle',      'Buffalo',             2,  60000.00),
(13, 'Land',        'Agricultural Land',   1,  1200000.00),
(13, 'Vehicle',     'Car (Hyundai i20)',   1,  700000.00),
(17, 'Land',        'Agricultural Land',   1,  4000000.00),
(17, 'Vehicle',     'SUV (Mahindra XUV)',  1,  1500000.00),
(17, 'Vehicle',     'Tractor',             1,  900000.00),
(17, 'Cattle',      'Cow',                 5,  125000.00),
(19, 'Land',        'Agricultural Land',   1,  1500000.00),
(19, 'Cattle',      'Cow',                 8,  200000.00),
(22, 'Land',        'Agricultural Land',   1,  2000000.00),
(22, 'Vehicle',     'Car (Toyota Innova)', 1,  1800000.00),
(25, 'Land',        'Agricultural Land',   1,  3000000.00),
(25, 'Vehicle',     'SUV (Tata Safari)',   1,  1600000.00),
(32, 'Land',        'Agricultural Land',   1,  1800000.00),
(32, 'Vehicle',     'Car (Maruti Ertiga)', 1,  900000.00),
(33, 'Land',        'Agricultural Land',   1,  1000000.00),
(36, 'Land',        'Agricultural Land',   1,  2000000.00),
(36, 'Vehicle',     'Car (Kia Seltos)',    1,  1400000.00),
(39, 'Land',        'Agricultural Land',   1,  1500000.00),
(39, 'Vehicle',     'Car (Hyundai Creta)', 1,  1100000.00),
(43, 'Land',        'Agricultural Land',   1,  1000000.00),
(43, 'Electronics', 'Desktop Computer',    1,  60000.00),
(45, 'Land',        'Agricultural Land',   1,  2500000.00),
(45, 'Vehicle',     'Car (Honda Amaze)',   1,  800000.00),
(49, 'Land',        'Agricultural Land',   1,  1200000.00),
(49, 'Vehicle',     'Scooter',             1,  80000.00);
