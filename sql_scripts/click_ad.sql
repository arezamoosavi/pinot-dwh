CREATE DATABASE IF NOT EXISTS events_db;

CREATE TABLE IF NOT EXISTS events_db.ad_click (
    `session_id` INT,
    `created` DATETIME,
    `user_id` INT,
    `product` VARCHAR(10) CHARACTER SET utf8,
    `campaign_id` INT,
    `webpage_id` INT,
    `product_category_1` INT,
    `product_category_2` NUMERIC(10, 1),
    `user_group_id` NUMERIC(10, 1),
    `gender` VARCHAR(10) CHARACTER SET utf8,
    `age_level` NUMERIC(10, 1),
    `user_depth` NUMERIC(10, 1),
    `city_development_index` NUMERIC(10, 1),
    `var_1` INT
);

LOAD DATA LOCAL INFILE '/docker-entrypoint-initdb.d/init_data/ad_click_data.csv'
INTO TABLE events_db.ad_click
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(session_id,created,user_id,product,campaign_id,webpage_id,product_category_1,product_category_2,user_group_id,gender,age_level,user_depth,city_development_index,var_1);

ANALYZE TABLE events_db.ad_click;