LOAD DATA LOCAL INFILE './././db/geonames/continentCodes.txt'
INTO TABLE continentCodes
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ','
(code, name, geonameId);

LOAD DATA LOCAL INFILE './././download/geonames/admin1CodesASCII.txt'
INTO TABLE admin1CodesAscii
CHARACTER SET 'UTF8'
(code, name, nameAscii, geonameid);

LOAD DATA LOCAL INFILE './././download/geonames/iso-languagecodes.txt'
INTO TABLE iso_languagecodes
CHARACTER SET 'UTF8'
IGNORE 1 LINES
(iso_639_3, iso_639_2, iso_639_1, language_name);

LOAD DATA LOCAL INFILE './././download/geonames/admin2Codes.txt'
INTO TABLE admin2Codes
CHARACTER SET 'UTF8'
(code, name, nameAscii, geonameid);

LOAD DATA LOCAL INFILE './././download/geonames/hierarchy.txt'
INTO TABLE hierarchy
CHARACTER SET 'UTF8'
(parentId, childId, type);

LOAD DATA LOCAL INFILE './././download/geonames/featureCodes_en.txt'
INTO TABLE featureCodes
CHARACTER SET 'UTF8'
(code, name, description);

LOAD DATA LOCAL INFILE './././download/geonames/timeZones.txt'
INTO TABLE timeZones
CHARACTER SET 'UTF8'
IGNORE 1 LINES
(timeZoneId, GMT_offset, DST_offset);

LOAD DATA LOCAL INFILE './././download/geonames/countryInfo.txt'
INTO TABLE countryinfo
CHARACTER SET 'UTF8'
IGNORE 51 LINES
(iso_alpha2, iso_alpha3, iso_numeric, fips_code, name, capital, areaInSqKm, population, continent, tld, currency, currencyName, phone, postalCodeFormat, postalCodeRegex, languages, geonameid, neighbours, equivalentFipsCode);

LOAD DATA LOCAL INFILE './././download/geonames/zip/allCountries.txt'
INTO TABLE postalCodes
CHARACTER SET 'UTF8'
(country, postal_code, name, admin1_name, admin1_code, admin2_name, admin2_code, admin3_name, admin3_code, latitude, longitude, accuracy);

LOAD DATA LOCAL INFILE './././download/geonames/alternateNames.txt'
INTO TABLE alternatename
CHARACTER SET 'UTF8'
(alternatenameid, geonameid, isoLanguage, alternateName, isPreferredName, isShortName, isColloquial, isHistoric);

LOAD DATA LOCAL INFILE './././download/geonames/allCountries.txt'
INTO TABLE geoname
CHARACTER SET 'UTF8'
(geonameid, name, asciiname, alternatenames, latitude, longitude, fclass, fcode, country, cc2, admin1, admin2, admin3, admin4, population, elevation, gtopo30, timezone, moddate);