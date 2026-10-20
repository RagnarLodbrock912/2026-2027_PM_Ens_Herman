USE example_db;

CREATE TABLE engines (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    volume_cc SMALLINT UNSIGNED NOT NULL COMMENT 'Engine volume in cubic centimetres',

    CONSTRAINT pk_engines PRIMARY KEY (id),
    CONSTRAINT uq_engines_name_volume UNIQUE (name, volume_cc),
    CONSTRAINT chk_engines_volume CHECK (volume_cc > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE colors (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,

    CONSTRAINT pk_colors PRIMARY KEY (id),
    CONSTRAINT uq_colors_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE motorcycle_types (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,

    CONSTRAINT pk_motorcycle_types PRIMARY KEY (id),
    CONSTRAINT uq_motorcycle_types_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE guarantees (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    terms VARCHAR(512) NOT NULL,
    duration_months SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_guarantees PRIMARY KEY (id),
    CONSTRAINT chk_guarantees_duration CHECK (duration_months > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE discounts (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    amount DECIMAL(12, 2) UNSIGNED NOT NULL,

    CONSTRAINT pk_discounts PRIMARY KEY (id),
    CONSTRAINT chk_discounts_amount CHECK (amount > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE motorcycles (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    max_speed_kmh SMALLINT UNSIGNED NOT NULL,
    price DECIMAL(12, 2) UNSIGNED NOT NULL,
    engine_id BIGINT UNSIGNED NOT NULL,
    color_id BIGINT UNSIGNED NOT NULL,
    motorcycle_type_id BIGINT UNSIGNED NOT NULL,

    CONSTRAINT pk_motorcycles PRIMARY KEY (id),
    CONSTRAINT chk_motorcycles_speed CHECK (max_speed_kmh > 0),
    CONSTRAINT chk_motorcycles_price CHECK (price > 0),
    CONSTRAINT fk_motorcycles_engine FOREIGN KEY (engine_id)
        REFERENCES engines (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_motorcycles_color FOREIGN KEY (color_id)
        REFERENCES colors (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_motorcycles_type FOREIGN KEY (motorcycle_type_id)
        REFERENCES motorcycle_types (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_motorcycles_engine_id (engine_id),
    INDEX idx_motorcycles_color_id (color_id),
    INDEX idx_motorcycles_type_id (motorcycle_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE sales (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    motorcycle_id BIGINT UNSIGNED NOT NULL,
    sold_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    price DECIMAL(12, 2) UNSIGNED NOT NULL,
    discount_id BIGINT UNSIGNED NULL,
    guarantee_id BIGINT UNSIGNED NOT NULL,

    CONSTRAINT pk_sales PRIMARY KEY (id),
    CONSTRAINT chk_sales_price CHECK (price >= 0),
    CONSTRAINT fk_sales_motorcycle FOREIGN KEY (motorcycle_id)
        REFERENCES motorcycles (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_sales_discount FOREIGN KEY (discount_id)
        REFERENCES discounts (id) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_sales_guarantee FOREIGN KEY (guarantee_id)
        REFERENCES guarantees (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_sales_motorcycle_id (motorcycle_id),
    INDEX idx_sales_discount_id (discount_id),
    INDEX idx_sales_guarantee_id (guarantee_id),
    INDEX idx_sales_sold_at (sold_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SHOW TABLES;
