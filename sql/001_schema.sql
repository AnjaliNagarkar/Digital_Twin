-- ============================================================
-- Village Digital Twin Platform — MySQL Schema
-- ============================================================
SET FOREIGN_KEY_CHECKS = 0;
CREATE DATABASE IF NOT EXISTS village_twin
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE village_twin;

-- ============================================================
-- HOUSEHOLDS — Core geo-entity
-- ============================================================
DROP TABLE IF EXISTS assets;
DROP TABLE IF EXISTS household_schemes;
DROP TABLE IF EXISTS scheme_enrollments;
DROP TABLE IF EXISTS agriculture;
DROP TABLE IF EXISTS family_members;
DROP TABLE IF EXISTS schemes;
DROP TABLE IF EXISTS households;

CREATE TABLE households (
    id               BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    head_name        VARCHAR(100)     NOT NULL,
    address          VARCHAR(255)     NOT NULL,
    ward_no          TINYINT UNSIGNED NOT NULL,
    lat              DECIMAL(10,8)    NOT NULL COMMENT 'Latitude with sub-meter precision',
    lng              DECIMAL(11,8)    NOT NULL COMMENT 'Longitude with sub-meter precision',
    total_members    SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    annual_income    DECIMAL(12,2)    NOT NULL DEFAULT 0.00,
    bpl              TINYINT(1)       NOT NULL DEFAULT 0 COMMENT '1=BPL, 0=APL',
    ration_card      ENUM('BPL','APL','AAY','NONE') NOT NULL DEFAULT 'NONE',
    house_type       ENUM('Kuccha','Semi-Pucca','Pucca') NOT NULL DEFAULT 'Kuccha',
    has_toilet       TINYINT(1)       NOT NULL DEFAULT 0,
    has_electricity  TINYINT(1)       NOT NULL DEFAULT 0,
    has_water_supply TINYINT(1)       NOT NULL DEFAULT 0,
    has_gas          TINYINT(1)       NOT NULL DEFAULT 0,
    created_at       TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Geo index for bounding-box queries: WHERE lat BETWEEN ? AND ? AND lng BETWEEN ? AND ?
    INDEX idx_lat_lng     (lat, lng),
    -- Filter indexes for common API filter parameters
    INDEX idx_bpl         (bpl),
    INDEX idx_ward        (ward_no),
    INDEX idx_toilet      (has_toilet),
    INDEX idx_electricity (has_electricity),
    INDEX idx_water       (has_water_supply)
) ENGINE=InnoDB;

-- ============================================================
-- FAMILY MEMBERS — Sub-entities per household
-- ============================================================
CREATE TABLE family_members (
    id             BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    household_id   BIGINT UNSIGNED  NOT NULL,
    name           VARCHAR(100)     NOT NULL,
    relation       ENUM('Head','Spouse','Son','Daughter','Father','Mother','Other') NOT NULL,
    gender         ENUM('Male','Female','Other') NOT NULL,
    date_of_birth  DATE             NOT NULL,
    education      ENUM('Illiterate','Primary','Secondary','HigherSecondary','Graduate','PostGraduate') NOT NULL DEFAULT 'Illiterate',
    occupation     VARCHAR(100)     DEFAULT NULL,
    aadhaar_hash   CHAR(64)         DEFAULT NULL COMMENT 'SHA-256 hash — never store raw Aadhaar',
    is_disabled    TINYINT(1)       NOT NULL DEFAULT 0,
    created_at     TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_fm_household FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    INDEX idx_fm_household (household_id),
    INDEX idx_fm_dob       (date_of_birth),
    INDEX idx_fm_gender    (gender)
) ENGINE=InnoDB;

-- ============================================================
-- AGRICULTURE — Economic layer
-- ============================================================
CREATE TABLE agriculture (
    id               BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    household_id     BIGINT UNSIGNED  NOT NULL,
    land_area_acres  DECIMAL(6,2)     NOT NULL DEFAULT 0.00,
    crop_type        VARCHAR(50)      NOT NULL,
    season           ENUM('Kharif','Rabi','Zaid') NOT NULL,
    irrigation_type  ENUM('Rainfed','Well','Borewell','Canal','Drip','Sprinkler') NOT NULL DEFAULT 'Rainfed',
    soil_type        VARCHAR(50)      DEFAULT NULL,
    annual_yield_kg  DECIMAL(10,2)    DEFAULT NULL,
    crop_year        YEAR             NOT NULL,
    created_at       TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_agri_household FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    INDEX idx_agri_household  (household_id),
    INDEX idx_agri_crop       (crop_type),
    INDEX idx_agri_season     (season),
    INDEX idx_agri_irrigation (irrigation_type)
) ENGINE=InnoDB;

-- ============================================================
-- SCHEMES — Master list of government welfare schemes
-- ============================================================
CREATE TABLE schemes (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150)  NOT NULL,
    code        VARCHAR(30)   NOT NULL UNIQUE,
    category    ENUM('Housing','Health','Education','Agriculture','Welfare','Employment','Financial') NOT NULL,
    description TEXT,
    eligibility TEXT          COMMENT 'JSON-encoded eligibility criteria',
    created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- HOUSEHOLD SCHEME ENROLLMENT — Tracks which households/members are enrolled
-- ============================================================
CREATE TABLE household_schemes (
    id            BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    household_id  BIGINT UNSIGNED NOT NULL,
    scheme_id     BIGINT UNSIGNED NOT NULL,
    member_id     BIGINT UNSIGNED DEFAULT NULL COMMENT 'NULL = household-level scheme',
    enrolled_on   DATE            NOT NULL,
    status        ENUM('Active','Expired','Pending','Rejected') NOT NULL DEFAULT 'Active',
    created_at    TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_hs_household FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    CONSTRAINT fk_hs_scheme    FOREIGN KEY (scheme_id)    REFERENCES schemes(id)    ON DELETE CASCADE,
    CONSTRAINT fk_hs_member    FOREIGN KEY (member_id)    REFERENCES family_members(id) ON DELETE SET NULL,
    UNIQUE KEY uq_enrollment   (household_id, scheme_id, member_id),
    INDEX idx_hs_scheme (scheme_id),
    INDEX idx_hs_status (status)
) ENGINE=InnoDB;

-- ============================================================
-- ASSETS — Household assets for economic profiling
-- ============================================================
CREATE TABLE assets (
    id            BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    household_id  BIGINT UNSIGNED  NOT NULL,
    asset_type    ENUM('Land','Cattle','Vehicle','Electronics','Machinery','Other') NOT NULL,
    description   VARCHAR(200)     NOT NULL,
    quantity      SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    est_value     DECIMAL(12,2)    DEFAULT NULL,
    created_at    TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_asset_household FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    INDEX idx_asset_household (household_id)
) ENGINE=InnoDB;
SET FOREIGN_KEY_CHECKS = 1;