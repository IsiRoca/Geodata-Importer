#!/bin/bash

#############################################
# Script that download & import Geonames.org & Geolite Maxmid.com data with advanced configuration options
# @author Isi Roca
# @site isiroca.com
# @license MIT License (MIT) (http://www.opensource.org/licenses/MIT)
# @Support https://github.com/IsiRoca/geodata-importer/issues
#############################################


# Default values for database variables.
dbhost="localhost"
dbport=3306
dbname="geodata"

# Get Data from
geonames_dumps="http://download.geonames.org/export/dump/"
geonames_zip="http://download.geonames.org/export/zip/"
geolite_geoip="http://geolite.maxmind.com/download/geoip/database/"

# Download folders
download_folder="`pwd`/download"
download_folder_geonames="$download_folder/geonames"
download_folder_zip="$download_folder_geonames/zip"
countries_folder="$download_folder_geonames/countries"
download_folder_geolite="$download_folder/geolite"

# SQL Files import
dir_db_geonames="`pwd`/db/geonames"
dir_db_geolite="`pwd`/db/geolite"


function header {
    source src/main/header.sh
}

function config_info {
	header
    source src/main/info.sh
}

function countries_code {
    source src/countries_info.sh
    exit -1
}

function languages_code {
    source src/languages_info.sh
    exit -1
}

function get_parameters {
    echo "----------------------------------------------------------"
    echo -e "\e[1;36m"
    echo "Database parameters used..."
    echo -e "\e[0;36m"
    echo "Action: " $action
    echo "DB Username: " $dbusername
    echo "DB Password: " $dbpassword
    echo "DB Name: " $dbname
    echo "DB Host: " $dbhost
    echo "DB Port: " $dbport
    echo -e "\e[0m"
    echo "----------------------------------------------------------"
}

function def_data_dump {
    data_dumps_countries="AD.zip AE.zip AF.zip AG.zip AI.zip AL.zip AM.zip AO.zip AQ.zip AR.zip AS.zip AT.zip AU.zip AW.zip AX.zip AZ.zip BA.zip BB.zip BD.zip BE.zip BF.zip BG.zip BH.zip BI.zip BJ.zip BL.zip BM.zip BN.zip BO.zip BQ.zip BR.zip BS.zip BT.zip BV.zip BW.zip BY.zip BZ.zip CA.zip CC.zip CD.zip CF.zip CG.zip CH.zip CI.zip CK.zip CL.zip CM.zip CN.zip CO.zip CR.zip CS.zip CU.zip CV.zip CW.zip CX.zip CY.zip CZ.zip DE.zip DJ.zip DK.zip DM.zip DO.zip DZ.zip EC.zip EE.zip EG.zip EH.zip ER.zip ES.zip ET.zip FI.zip FJ.zip FK.zip FM.zip FO.zip FR.zip GA.zip GB.zip GD.zip GE.zip GF.zip GG.zip GH.zip GI.zip GL.zip GM.zip GN.zip GP.zip GQ.zip GR.zip GS.zip GT.zip GU.zip GW.zip GY.zip HK.zip HM.zip HN.zip HR.zip HT.zip HU.zip ID.zip IE.zip IL.zip IM.zip IN.zip IO.zip IQ.zip IR.zip IS.zip IT.zip JE.zip JM.zip JO.zip JP.zip KE.zip KG.zip KH.zip KI.zip KM.zip KN.zip KP.zip KR.zip KW.zip KY.zip KZ.zip LA.zip LB.zip LC.zip LI.zip LK.zip LR.zip LS.zip LT.zip LU.zip LV.zip LY.zip MA.zip MC.zip MD.zip ME.zip MF.zip MG.zip MH.zip MK.zip ML.zip MM.zip MN.zip MO.zip MP.zip MQ.zip MR.zip MS.zip MT.zip MU.zip MV.zip MW.zip MX.zip MY.zip MZ.zip NA.zip NC.zip NE.zip NF.zip NG.zip NI.zip NL.zip NO.zip NP.zip NR.zip NU.zip NZ.zip OM.zip PA.zip PE.zip PF.zip PG.zip PH.zip PK.zip PL.zip PM.zip PN.zip PR.zip PS.zip PT.zip PW.zip PY.zip QA.zip RE.zip RO.zip RS.zip RU.zip RW.zip SA.zip SB.zip SC.zip SD.zip SE.zip SG.zip SH.zip SI.zip SJ.zip SK.zip SL.zip SM.zip SN.zip SO.zip SR.zip SS.zip ST.zip SV.zip SX.zip SY.zip SZ.zip TC.zip TD.zip TF.zip TG.zip TH.zip TJ.zip TK.zip TL.zip TM.zip TN.zip TO.zip TR.zip TT.zip TV.zip TW.zip TZ.zip UA.zip UG.zip UM.zip US.zip UY.zip UZ.zip VA.zip VC.zip VE.zip VG.zip VI.zip VN.zip VU.zip WF.zip WS.zip XK.zip YE.zip YT.zip YU.zip ZA.zip ZM.zip ZW.zip"
    data_dumps="alternateNames.zip hierarchy.zip admin1CodesASCII.txt admin2Codes.txt featureCodes_en.txt timeZones.txt countryInfo.txt"
    data_zip_codes="AD.zip AR.zip AS.zip AT.zip AU.zip AX.zip BD.zip BE.zip BG.zip BR.zip CA.zip CH.zip CZ.zip DE.zip DK.zip DO.zip DZ.zip ES.zip FI.zip FO.zip FR.zip GB.zip GB_full.csv.zip GF.zip GG.zip GL.zip GP.zip GT.zip GU.zip HR.zip HU.zip IE.zip IM.zip IN.zip IS.zip IT.zip JE.zip JP.zip LI.zip LK.zip LT.zip LU.zip MC.zip MD.zip MH.zip MK.zip MP.zip MQ.zip MT.zip MX.zip MY.zip NL.zip NO.zip NZ.zip PH.zip PK.zip PL.zip PM.zip PR.zip PT.zip RE.zip RO.zip RU.zip SE.zip SI.zip SJ.zip SK.zip SM.zip TH.zip TR.zip US.zip VA.zip VI.zip YT.zip ZA.zip"
    data_dumps_all="allCountries.zip alternateNames.zip hierarchy.zip admin1CodesASCII.txt admin2Codes.txt featureCodes_en.txt timeZones.txt countryInfo.txt"
    data_zip_codes_all="allCountries.zip"
    data_geolite2="GeoLite2-City-CSV.zip GeoLite2-Country-CSV.zip"
}

function load_files_dir {
    if [ -d $download_folder ]; then
        echo -e "\e[0;32m"
        echo "Loading all Files & Folders in $download_folder"
        echo -e "\e[0m"

            if dpkg-query -s tree; then
                tree $download_folder
            else
                    echo -e "\e[0;32m"
                    find $download_folder -type f
                    find $download_folder -type d
                    echo -e "\e[0m"
            fi
    else
        echo -e "\e[0;31m"
        echo $download_folder "not exist"
        echo -e "\e[0m"
    fi
}

function remove_data {
    msg_remove
    if [ -d $download_folder ]; then
        load_files_dir
        echo -e "\e[0;32m"
        echo "Removing All Data in '$download_folder'"
        echo -e "\e[0m"
        echo -e "\e[0;34m"
        rm -rfv $download_folder/*
        rm -r $download_folder
        echo -e "\e[0m"
    else
        echo -e "\e[0;32m"
        echo "Download folder '$download_folder' not exist"
        echo -e "\e[0m"
    fi
}

function check_data {
    if [ -d $download_folder ]; then
        remove_data
    fi
}

function get_data {
    def_data_dump
    check_data
    get_geonames_data
    get_geolite_data
    load_files_dir
}

function get_geonames_data {
    echo -e "\e[0;32m"
    echo "--------------------------------------------"
    echo "      Downloading GeoNames.org data...      "
    echo "--------------------------------------------"
    echo -e "\e[0m"
    if { [ "$country" != "" ]; } then
        echo -e "\e[0;32m"
        echo "Get Country ==> '${country^^}'"
        echo -e "\e[0m"
        if { [ "$country" == "all" ]; } then
            echo "Downloading all countries by country"
            dumps_countries=$data_dumps_countries
            dumps=$data_dumps
            zip_codes=$data_zip_codes
        else
            country_codes ${country^^} && msg_country_codes_ok || msg_country_codes_error
        fi
        download_geonames_by_country
    else
        echo -e "\e[0;32m"
        echo "Downloading all countries"
        echo -e "\e[0m"
        dumps=$data_dumps_all
        zip_codes=$data_zip_codes_all
        download_geonames_all_countries
    fi
}

function get_geolite_data {
    echo -e "\e[0;32m"
    echo "-------------------------------------------"
    echo "      Downloading Maxmind.com data...      "
    echo "-------------------------------------------"
    echo -e "\e[0m"
    geolite2=$data_geolite2
    download_geolite_data
}

function download_geonames_all_countries {
    echo -e "\e[1;35m"
    for dump in $dumps; do
        wget -c -P "$download_folder_geonames" $geonames_dumps$dump
    done

    for zip in $zip_codes; do
        wget -c -P "$download_folder_zip" $geonames_zip$zip
    done
    echo -e "\e[0m"

    msg_unzip
    echo -e "\e[0;35m"
    unzip -o "$download_folder_geonames/*.zip" -d "$download_folder_geonames"
    unzip -o "$download_folder_zip/*.zip" -d "$download_folder_zip"
    echo -e "\e[0m"

    msg_remove
    rm $download_folder_geonames/*.zip
    rm $download_folder_geonames/readme.txt
    rm $download_folder_zip/*.zip
    rm $download_folder_zip/readme.txt
    echo -e "\e[0m"
}

function download_geonames_by_country {
    echo -e "\e[1;35m"
    for dump in $dumps_countries; do
        wget -c -P "$countries_folder" $geonames_dumps$dump
    done

    for dump in $dumps; do
        wget -c -P "$download_folder_geonames" $geonames_dumps$dump
    done

    for zip in $zip_codes; do
        wget -c -P "$download_folder_zip" $geonames_zip$zip
    done
    echo -e "\e[0m"

    msg_unzip
    echo -e "\e[0;35m"
    unzip -o "$countries_folder/*.zip" -d "$countries_folder"
    unzip -o "$download_folder_geonames/*.zip" -d "$download_folder_geonames"
    unzip -o "$download_folder_zip/*.zip" -d "$download_folder_zip"
    echo -e "\e[0m"

    msg_remove
    echo -e "\e[0;34m"
    rm $countries_folder/*.zip
    rm $countries_folder/readme.txt
    rm $download_folder_geonames/*.zip
    rm $download_folder_geonames/readme.txt
    rm $download_folder_zip/*.zip
    rm $download_folder_zip/readme.txt
    echo -e "\e[0m"
}

function download_geolite_data {
    echo -e "\e[1;35m"
    for geolite in $geolite2; do
        wget -c -P "$download_folder_geolite" $geolite_geoip$geolite
    done
    echo -e "\e[0m"

    msg_unzip
    echo -e "\e[0;35m"
    unzip -o "$download_folder_geolite/*.zip" -d "$download_folder_geolite"
    echo -e "\e[0m"

    msg_remove
    echo -e "\e[0;34m"
    rm $download_folder_geolite/*.zip
    echo -e "\e[0m"

    rename_geolite_folder
}

function create_db_action {
    echo -e "\e[0;32m"
    echo "Creating database $dbname..."
    echo -e "\e[0m"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "DROP DATABASE IF EXISTS $dbname;"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "CREATE DATABASE $dbname DEFAULT CHARACTER SET utf8;"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "USE $dbname;"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword $dbname < $dir_db_geonames/geonames_db_struct.sql
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword $dbname < $dir_db_geolite/geolite_db_struct.sql
}

function import_geonames_all_countries {
    echo -e "\e[0;32m"
    echo "Importing all countries into database $dbname"
    echo -e "\e[0m"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geonames/geonames_import_data_all.sql
}

function import_geonames_country_by_country_countries {
    echo -e "\e[0;32m"
    echo "Importing countries by country into database $dbname"
    echo -e "\e[0m"

    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geonames/geonames_import_data_by_country.sql

    files=$(find $countries_folder -type f -name '*.txt')
    #files=$(find "`pwd`/download/geonames/countries/" -type f -name '*.txt')

    for file in $files; do
        filename=$(basename "$file")
        nameCode="${filename%.*}"

        echo -e "\e[0;32m"
        echo "Import MySQL files"
        echo $file
        echo "Country Code ==> $nameCode"
        echo -e "\e[0m"

        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geonames/countries/$nameCode.sql
    done
}

function import_geonames_country_by_country_zip {
    echo -e "\e[0;32m"
    echo "Importing zips by country into database $dbname"
    echo -e "\e[0m"
    files=$(find $countries_folder -type f -name '*.txt')
    #files=$(find "`pwd`/download/geonames/zip/" -type f -name '*.txt')

    for file in $files; do
        filename=$(basename "$file")
        nameCode="${filename%.*}"

        echo -e "\e[0;32m"
        echo "Import MySQL files"
        echo $file
        echo "Zip Country Code ==> $nameCode"
        echo -e "\e[0m"

        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geonames/zip/$nameCode.sql
    done
}

function import_geonames_one_country {
    local countryCode=$1
    country_codes $countryCode && msg_country_codes_ok || msg_country_codes_error
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geonames/countries/$countryCode.sql
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geonames/geonames_import_data_by_country.sql
}

function import_geonames_one_country_zip {
    local countryCode=$1
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geonames/zip/$countryCode.sql
}

function import_geolite {
    echo -e "\e[0;32m"
    echo "Language Code (by Default) ==> EN"
    echo -e "\e[0m"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geolite/geolite_import_data.sql
}

function import_geolite_language {
    languageCode=$1
    echo -e "\e[0;32m"
    echo "Language Code ==> $languageCode"
    echo -e "\e[0m"
    language_codes $languageCode && msg_language_codes_ok || msg_language_codes_error
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < $dir_db_geolite/languages/geolite_import_data_$languageCode.sql
}

function truncate_db_action {
    echo -e "\e[0;32m"
    echo "Truncating all data in $dbname database"
    echo -e "\e[0m"
    truncate_db_geonames_action
    truncate_db_geolite_action
}

function truncate_db_geonames_action {
    echo -e "\e[0;32m"
    echo "Truncating geonames data in $dbname database"
    echo -e "\e[0m"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword $dbname < $dir_db_geonames/geonames_truncate_db.sql
}

function truncate_db_geolite_action {
    echo -e "\e[0;32m"
    echo "Truncating geolite data in $dbname database"
    echo -e "\e[0m"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword $dbname < $dir_db_geolite/geolite_truncate_db.sql
}

function drop_db_action {
    echo -e "\e[0;32m"
    echo "Dropping $dbname database"
    echo -e "\e[0m"
    mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "DROP DATABASE IF EXISTS $dbname;"
}

function rename_geolite_folder {
    files=$(find $download_folder_geolite -type d -name 'GeoLite2-City-CSV_*')
    for file in $files; do
        echo -e "\e[0;32m"
        echo "Renaming $file ==> $download_folder_geolite/city"
        echo -e "\e[0m"
        mv $file $download_folder_geolite/city
    done

    files=$(find $download_folder_geolite -type d -name 'GeoLite2-Country-CSV_*')
    for file in $files; do
        echo -e "\e[0;32m"
        echo "Renaming $file ==> $download_folder_geolite/country"
        echo -e "\e[0m"
        mv $file $download_folder_geolite/country
    done
}

function country_codes {
    source src/countries_code.sh

    if [[ -z "$country" ]]; then
        country=$1
    fi

    in=1
    for i in "${countries_array[@]}"
    do
        if [ "$i" == "${country^^}" ] ; then
            dumps_countries="${country^^}.zip"
            dumps=$data_dumps
            zip_codes="${country^^}.zip"
            in=0
            break
        fi
    done
    return $in
}

function language_codes {
    source src/language_code.sh

    if [[ -z "$language" ]]; then
        language=$1
    fi

    in=1
    for i in "${languages_array[@]}"
    do
        if [ "$i" == "$language" ] ; then
            in=0
            break
        fi
    done
    return $in
}

function msg_country_codes_ok {
    echo -e "\e[0;32m"
    echo "${country^^} country code valid"
    echo "Get country code ==> ${country^^} data"
    echo -e "\e[0m"
}

function msg_country_codes_error {
    echo -e "\e[1;31m"
    echo "----------------------------------------------------------"
    echo "                       ERROR ! ! !                        "
    echo "----------------------------------------------------------"
    echo ""
    echo "[ERROR]: Country Code '${country^^}' NOT found"
    echo "[ERROR]: Please, type a valid Country Code."
    echo "[ERROR]: More Info about Country Codes typing --country-info"
    echo ""
    echo "----------------------------------------------------------"
    echo -e "\e[0m"
    echo -e "\e[1;33m"
    echo "================================================================================================"
    echo -e "\e[0m"
    exit
}

function msg_language_codes_ok {
    echo -e "\e[0;32m"
    echo "$language language code valid"
    echo "Get language code ==> $language "
    echo -e "\e[0m"
}

function msg_language_codes_error {
    echo -e "\e[1;31m"
    echo "----------------------------------------------------------"
    echo "                       ERROR ! ! !                        "
    echo "----------------------------------------------------------"
    echo ""
    echo "[ERROR]: Language Code '$language' NOT found"
    echo "[ERROR]: Please, type a valid Language Code."
    echo "[ERROR]: More Info about Language Codes typing --language-info"
    echo ""
    echo "----------------------------------------------------------"
    echo -e "\e[0m"
    echo -e "\e[1;33m"
    echo "================================================================================================"
    echo -e "\e[0m"
    exit
}

function msg_unzip {
    echo -e "\e[0;32m"
    echo "----------------------------------"
    echo "      U N Z I P    F I L E S      "
    echo "----------------------------------"
    echo -e "\e[0m"
}

function msg_remove {
    echo -e "\e[0;32m"
    echo "------------------------------------"
    echo "      R E M O V E    F I L E S      "
    echo "------------------------------------"
    echo -e "\e[0m"
}

function more_info {
    source src/main/more_info.sh
}

function success_fail {
    if [ $? == 0 ]; then
        echo -e "\e[1;32m"
        echo "--------------------------------------------------------------"
        echo "--------------------------------------------------------------"
        echo "    [ [  S U C C E S S F U L L Y    P R O C E S S E D  ] ]    "
        echo "--------------------------------------------------------------"
        echo "--------------------------------------------------------------"
        echo -e "\e[0m"
    else
        echo -e "\e[1;31m"
        echo "-------------------------------------------------"
        echo "-------------------------------------------------"
        echo "    [ [  F A I L E D    P R O C E S S E D  ] ]   "
        echo "-------------------------------------------------"
        echo "-------------------------------------------------"
        echo -e "\e[0m"
    fi
}


if [ $# -lt 1 ]; then
	config_info
	exit 1
fi

header


if { [ "$1" == "--download-data" ]; } then
	if { [ "$2" != "" ]; } then
        if [ ! -d "$countries_folder" ]; then
           echo -e "\e[0;32m"
           echo "Folder '$countries_folder' doesn't exists."
           echo "Creating '$countries_folder'..."
           echo -e "\e[0m"
           mkdir -p "$countries_folder"
        fi
        country="$2"
	fi

	get_data "$country"

elif { [ "$1" == "--country-info" ]; } then
    countries_code
elif { [ "$1" == "--language-info" ]; } then
    languages_code
elif { [ "$1" == "--download-info" ]; } then
    load_files_dir
elif { [ "$1" == "--remove-data" ]; } then
    remove_data
elif { [ "$1" == "--more-info" ]; } then
    more_info
else
    echo ""
fi


while getopts "a:u:p:" opt;
do
    case $opt in
        a) action=$OPTARG ;;
        u) dbusername=$OPTARG ;;
        p) dbpassword=$OPTARG ;;
    esac
done


case $action in
    download-data)
        get_data
        exit 0
    ;;
esac


if { [ "$1" == "-a" ]; } then
    if [ -z $dbusername ]; then
        echo -e "\e[0;31m"
        echo "No user name provided for accessing the database."
        echo -e "\e[0;32m"
        echo "Please type your USER value in parameter -uYOURUSER"
        echo -e "\e[0m"
        exit 1
    fi

    if [ -z $dbpassword ]; then
        echo -e "\e[0;31m"
        echo "No user password provided for accessing the database."
        echo -e "\e[0;32m"
        echo "Please type your PASSWORD in parameter -pYOURPASSWORD"
        echo -e "\e[0m"
        exit 1
    fi

    get_parameters
fi


case "$action" in
    create-db)
        create_db_action
    ;;

    import-all)
        if [ -f $download_folder_geonames/allCountries.txt ]; then
            import_geonames_all_countries
            import_geolite
        else
            import_geonames_country_by_country_countries
            import_geonames_country_by_country_zip
            import_geolite
        fi
    ;;

    import-geonames)
        echo -e "\e[0;32m"
        echo "Importing geonames data into database $dbname"
        echo -e "\e[0m"
        if [ -f $download_folder_geonames/allCountries.txt ]; then
            import_geonames_all_countries
        else
            if { [ "$5" != "" ]; } then
                echo -e "\e[0;32m"
                echo "Country Code to import ==> ${5^^}"
                echo -e "\e[0m"
                countryCode=$5
                import_geonames_one_country $countryCode
                import_geonames_one_country_zip $countryCode
            else
                import_geonames_country_by_country_countries
                import_geonames_country_by_country_zip
            fi
        fi
    ;;

    import-geolite)
        echo -e "\e[0;32m"
        echo "Importing geolite data into database $dbname"
        echo -e "\e[0m"

        if [[ -z "$5" ]]; then
            import_geolite
        else
            languageCode=$5
            import_geolite_language $languageCode
        fi

    ;;

    truncate-db)
        truncate_db_action
    ;;

    truncate-db-geonames)
        truncate_db_geonames_action
    ;;

    truncate-db-geolite)
        truncate_db_geolite_action
    ;;

    drop-db)
        drop_db_action
    ;;
esac


success_fail

exit 0