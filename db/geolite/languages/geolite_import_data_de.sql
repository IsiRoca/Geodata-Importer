LOAD DATA LOCAL INFILE './././download/geolite/city/GeoLite2-City-Blocks-IPv4.csv'
INTO TABLE geoip_city_blocks_ipv4
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(network, geoname_id, registered_country_geoname_id, represented_country_geoname_id, is_anonymous_proxy, is_satellite_provider, postal_code, latitude, longitude);

LOAD DATA LOCAL INFILE './././download/geolite/city/GeoLite2-City-Blocks-IPv6.csv'
INTO TABLE geoip_city_blocks_ipv6
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(network, geoname_id, registered_country_geoname_id, represented_country_geoname_id, is_anonymous_proxy, is_satellite_provider, postal_code, latitude, longitude);

LOAD DATA LOCAL INFILE './././download/geolite/city/GeoLite2-City-Locations-de.csv'
INTO TABLE geoip_city_location
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(geoname_id, locale_code, continent_code, continent_name, country_iso_code, country_name, subdivision_1_iso_code, subdivision_1_name, subdivision_2_iso_code, subdivision_2_name, city_name, metro_code, time_zone);

LOAD DATA LOCAL INFILE './././download/geolite/country/GeoLite2-Country-Blocks-IPv4.csv'
INTO TABLE geoip_country_blocks_ipv4
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(network, geoname_id, registered_country_geoname_id, represented_country_geoname_id, is_anonymous_proxy, is_satellite_provider);

LOAD DATA LOCAL INFILE './././download/geolite/country/GeoLite2-Country-Blocks-IPv6.csv'
INTO TABLE geoip_country_blocks_ipv6
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(network, geoname_id, registered_country_geoname_id, represented_country_geoname_id, is_anonymous_proxy, is_satellite_provider);

LOAD DATA LOCAL INFILE './././download/geolite/country/GeoLite2-Country-Locations-de.csv'
INTO TABLE geoip_country_location
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(geoname_id, locale_code, continent_code, continent_name, country_iso_code, country_name);