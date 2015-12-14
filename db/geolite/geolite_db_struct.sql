-- Create syntax for TABLE 'geoip_city_blocks_ipv4'
CREATE TABLE `geoip_city_blocks_ipv4` (
  `network` varchar(100),
  `geoname_id` int(10) unsigned,
  `registered_country_geoname_id` int,
  `represented_country_geoname_id` int,
  `is_anonymous_proxy` bit,
  `is_satellite_provider` bit,
  `postal_code` varchar(10),
  `latitude` decimal,
  `longitude` decimal
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'geoip_city_blocks_ipv6'
CREATE TABLE `geoip_city_blocks_ipv6` (
  `network` varchar(100),
  `geoname_id` int(10) unsigned,
  `registered_country_geoname_id` int,
  `represented_country_geoname_id` int,
  `is_anonymous_proxy` bit,
  `is_satellite_provider` bit,
  `postal_code` varchar(10),
  `latitude` decimal,
  `longitude` decimal
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'geoip_city_location'
CREATE TABLE `geoip_city_location` (
  `geoname_id` int(10) unsigned NOT NULL,
  `locale_code` char(2),
  `continent_code` char(2),
  `continent_name` varchar(50),
  `country_iso_code` char(2),
  `country_name` varchar(50),
  `subdivision_1_iso_code` varchar(3),
  `subdivision_1_name` varchar(50),
  `subdivision_2_iso_code` varchar(3),
  `subdivision_2_name` varchar(50),
  `city_name` varchar(50),
  `metro_code` int,
  `time_zone` int,
PRIMARY KEY (geoname_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'geoip_country_blocks_ipv4'
CREATE TABLE `geoip_country_blocks_ipv4` (
  `network` varchar(100),
  `geoname_id` int(10) unsigned,
  `registered_country_geoname_id` int,
  `represented_country_geoname_id` int,
  `is_anonymous_proxy` bit,
  `is_satellite_provider` bit
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'geoip_country_blocks_ipv6'
CREATE TABLE `geoip_country_blocks_ipv6` (
  `network` varchar(100),
  `geoname_id` int(10) unsigned,
  `registered_country_geoname_id` int,
  `represented_country_geoname_id` int,
  `is_anonymous_proxy` bit,
  `is_satellite_provider` bit
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'geoip_country_location'
CREATE TABLE `geoip_country_location` (
  `geoname_id` int(10) unsigned NOT NULL,
  `locale_code` char(2),
  `continent_code` char(2),
  `continent_name` varchar(50),
  `country_iso_code` char(2),
  `country_name` varchar(50),
PRIMARY KEY (geoname_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;