CREATE DATABASE shop_db;
USE shop_db;

CREATE TABLE stores (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    adress VARCHAR(255),

    CONSTRAINT pk_stores PRIMARY KEY (id),
    CONSTRAINT uq_stores_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE recipes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    sold_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    store_id BIGINT UNSIGNED NOT NULL,

    CONSTRAINT pk_recipe PRIMARY KEY (id),
    CONSTRAINT fk_recipes_stores FOREIGN KEY (store_id)
        REFERENCES stores (id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE products (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    count BIGINT UNSIGNED NOT NULL,
    price DECIMAL(12, 2) UNSIGNED NOT NULL,

    CONSTRAINT pk_products PRIMARY KEY (id),
    CONSTRAINT chk_products_price CHECK (price >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE product_recipe (
    recipe_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    count BIGINT UNSIGNED NOT NULL,
    price DECIMAL(12, 2) UNSIGNED NOT NULL,

    CONSTRAINT pk_product_recipe PRIMARY KEY (recipe_id, product_id),
    CONSTRAINT fk_pr_products FOREIGN KEY (product_id)
        REFERENCES products (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_pr_recipes FOREIGN KEY (recipe_id)
        REFERENCES recipes (id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE store_product (
    product_id BIGINT UNSIGNED NOT NULL,
    store_id BIGINT UNSIGNED NOT NULL,
    count BIGINT UNSIGNED NOT NULL,
    price DECIMAL(12, 2) UNSIGNED NOT NULL,

    CONSTRAINT pk_store_product PRIMARY KEY (product_id, store_id),
    CONSTRAINT fk_sp_products FOREIGN KEY (product_id)
        REFERENCES products (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_sp_stores FOREIGN KEY (store_id)
        REFERENCES stores (id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

USE shop_db;

INSERT INTO stores (name, adress) VALUES
('Supermarket Central', 'Lenina St, 10'),
('Local Grocery', 'Mira Ave, 25'),
('Mega Hypermarket', 'Entuziastov Hwy, 50');

INSERT INTO products (name, count, price) VALUES
('Milk 3.2%', 100, 89.90),
('Borodinsky Bread', 50, 45.00),
('Ground Coffee 250g', 30, 350.00),
('Milk Chocolate', 200, 99.99),
('Green Apples (kg)', 80, 129.00),
('Coca-Cola 1.5L', 150, 110.00),
('Mineral Water 1L', 300, 45.00),
('Chicken Breast (kg)', 40, 320.00),
('Pasta 500g', 120, 75.00),
('Olive Oil 500ml', 25, 499.90),
('Black Tea 100 bags', 60, 180.00),
('White Rice 1kg', 90, 95.00);

INSERT INTO store_product (product_id, store_id, count, price) VALUES
(1, 1, 40, 89.90),
(2, 1, 20, 45.00),
(3, 1, 10, 360.00),
(4, 1, 80, 99.99),

(1, 2, 15, 95.00),
(2, 2, 10, 48.00),
(6, 2, 25, 115.00),
(7, 2, 50, 50.00),

(1, 3, 45, 85.00),
(3, 3, 20, 340.00),
(4, 3, 90, 89.90),
(6, 3, 80, 105.00),
(7, 3, 120, 42.00);

SHOW TABLES;

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
