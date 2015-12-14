# GeoData Importer #


## Description ##
Download and Import Geonames (Geonames.org) & Geolite (Maxmind.com) in a MySQL Database


## Databases ([Services](#services)) ##

* [Geonames](http://geonames.org/)
* [Maxmind](https://www.maxmind.com/)


## Services ##

### Geonames ###

The [GeoNames](http://geonames.org/) geographical database is available for download free of charge under a creative commons attribution license. It contains over 10 million geographical names and consists of over 9 million unique features whereof 2.8 million populated places and 5.5 million alternate names. All features are categorized into one out of nine feature classes and further subcategorized into one out of 645 feature codes.

GeoNames is integrating geographical data such as names of places in various languages, elevation, population and others from various sources.

The GeoLite2 databases are distributed under the Creative Commons Attributions License.

### Maxmind ###

GeoLite2 databases are free IP geolocation databases. Includes the GeoNames IDs for localization and pairing outside data.

The GeoLite2 databases are distributed under the [Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/).

This product includes GeoLite2 data created by MaxMind, available from [http://www.maxmind.com](http://www.maxmind.com).


## How to ##

### Getting GeoData Importer ###
Clone or Download GeoData Importer

#### Git Clone ####
```php
git clone https://github.com/IsiRoca/Geodata-Importer.git

```

#### Zip Download ####
```php
https://github.com/IsiRoca/Geodata-Importer/archive/master.zip

```

### Download Data ###

#### 1) Download All ####
Download all data

#### Example ####
```php
./geodata_importer.sh --download-data

```

#### 2) Download All by Country ####
Download all data in separated files by country

#### Example ####
```php
./geodata_importer.sh --download-data all

```

#### 3) Download One by One ####
Download one country by country code. You can get all code countries with --country-info

#### Example ####
```php
./geodata_importer.sh --download-data cn

```

### Import Data ###

#### 1) Create Database ####
Create your local database

#### Example ####
```php
./geodata_importer.sh -a create-db -uYOURUSER -pYOURPASSWORD

```

#### 2) Import Data ####
Import data in your database

#### Import All (Geonames & Geolite) Example ####
```php
./geodata_importer.sh -a import-all -uYOURUSER -pYOURPASSWORD

```

#### AllCountries Example ####
```php
./geodata_importer.sh -a import-geonames -uYOURUSER -pYOURPASSWORD

```

#### One Country by Code Example ####
```php
./geodata_importer.sh -a import-geonames -uYOURUSER -pYOURPASSWORD cn

```

#### Geolite Example ####
```php
./geodata_importer.sh -a import-geolite -uYOURUSER -pYOURPASSWORD

```

#### 3) Drop Database ####
Drop your database

#### Example ####
```php
./geodata_importer.sh -a drop-db -uYOURUSER -pYOURPASSWORD

```

#### 4) Truncate Database ####
Drop your database

#### Truncate All Example ####
```php
./geodata_importer.sh -a truncate-db -uYOURUSER -pYOURPASSWORD

```

#### Truncate only Geonames Example ####
```php
./geodata_importer.sh -a truncate-db-geonames -uYOURUSER -pYOURPASSWORD

```

#### Truncate only Geolite Example ####
```php
./geodata_importer.sh -a truncate-db-geolite -uYOURUSER -pYOURPASSWORD

```

### Remove Data ###

#### Description ####
Remove download folder

#### Example ####
```php
./geodata_importer.sh --remove-data

```

### Country Info ###

#### Description ####
Get countries codes info

#### Example ####
```php
./geodata_importer.sh --country-info

```

### Language Info ###

#### Description ####
Get languages codes info

#### Example ####
```php
./geodata_importer.sh --language-info

```

### Download Info ###

#### Description ####
Check all downloaded files info

#### Example ####
```php
./geodata_importer.sh --download-info

```

## Contributing to GeoData Importer ##
If you have a patch, or stumbled upon an issue with GeoData Importer, you can contribute this back to the code


## Copyright and License ##
This is free software, licensed under the [MIT License (MIT)](http://www.opensource.org/licenses/MIT).

## Credits & Contact ##
@Author: [Isi Roca](http://isiroca.com)
@Support: [Issues & Support](https://github.com/IsiRoca/Geodata-Importer/issues)