import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Window {
    property int screenWidth: Screen.width
    property int screenHeight: Screen.height

    width: screenWidth * 0.364
    height: screenHeight * 0.741
    visible: true
    title: qsTr("Namaz")

    property string currentTime: ""
    property string clockFormat: "12-hour" // Default clock format

    property int currentMethod: 3 // Default method

    property string fajrTime: ""
    property string sunriseTime: ""
    property string dhuhrTime: ""
    property string asrTime: ""
    property string sunsetTime: ""
    property string maghribTime: ""
    property string ishaTime: ""
    property string imsakTime: ""
    property string midnightTime: ""
    property string firstthirdTime: ""
    property string lastthirdTime: ""

    property int utcOffset: 0 // Default UTC offset

    property var timezones: [
        {
          "value": "Dateline Standard Time",
          "abbr": "DST",
          "offset": -12,
          "isdst": false,
          "text": "(UTC-12:00) International Date Line West",
          "utc": [
            "Etc/GMT+12"
          ],
          "cities": ["International Date Line West"]
        },
        {
          "value": "UTC-11",
          "abbr": "U",
          "offset": -11,
          "isdst": false,
          "text": "(UTC-11:00) Coordinated Universal Time-11",
          "utc": [
            "Etc/GMT+11",
            "Pacific/Midway",
            "Pacific/Niue",
            "Pacific/Pago_Pago"
          ],
          "cities": ["Midway", "Niue", "Pago Pago"]
        },
        {
          "value": "Hawaiian Standard Time",
          "abbr": "HST",
          "offset": -10,
          "isdst": false,
          "text": "(UTC-10:00) Hawaii",
          "utc": [
            "Etc/GMT+10",
            "Pacific/Honolulu",
            "Pacific/Johnston",
            "Pacific/Rarotonga",
            "Pacific/Tahiti"
          ],
          "cities": ["Honolulu", "Johnston", "Rarotonga", "Tahiti"]
        },
        {
          "value": "Alaskan Standard Time",
          "abbr": "AKDT",
          "offset": -8,
          "isdst": true,
          "text": "(UTC-09:00) Alaska",
          "utc": [
            "America/Anchorage",
            "America/Juneau",
            "America/Nome",
            "America/Sitka",
            "America/Yakutat"
          ],
          "cities": ["Anchorage", "Juneau", "Nome", "Sitka", "Yakutat"]
        },
        {
          "value": "Pacific Standard Time (Mexico)",
          "abbr": "PDT",
          "offset": -7,
          "isdst": true,
          "text": "(UTC-08:00) Baja California",
          "utc": [
            "America/Santa_Isabel"
          ],
          "cities": ["Baja California"]
        },
        {
          "value": "Pacific Daylight Time",
          "abbr": "PDT",
          "offset": -7,
          "isdst": true,
          "text": "(UTC-07:00) Pacific Daylight Time (US & Canada)",
          "utc": [
            "America/Los_Angeles",
            "America/Tijuana",
            "America/Vancouver"
          ],
          "cities": ["Los Angeles", "Tijuana", "Vancouver"]
        },
        {
          "value": "Pacific Standard Time",
          "abbr": "PST",
          "offset": -8,
          "isdst": false,
          "text": "(UTC-08:00) Pacific Standard Time (US & Canada)",
          "utc": [
            "America/Los_Angeles",
            "America/Tijuana",
            "America/Vancouver",
            "PST8PDT"
          ],
          "cities": ["Los Angeles", "Tijuana", "Vancouver"]
        },
        {
          "value": "US Mountain Standard Time",
          "abbr": "UMST",
          "offset": -7,
          "isdst": false,
          "text": "(UTC-07:00) Arizona",
          "utc": [
            "America/Creston",
            "America/Dawson",
            "America/Dawson_Creek",
            "America/Hermosillo",
            "America/Phoenix",
            "America/Whitehorse",
            "Etc/GMT+7"
          ],
          "cities": ["Creston", "Dawson", "Dawson Creek", "Hermosillo", "Phoenix", "Whitehorse"]
        },
        {
          "value": "Mountain Standard Time (Mexico)",
          "abbr": "MDT",
          "offset": -6,
          "isdst": true,
          "text": "(UTC-07:00) Chihuahua, La Paz, Mazatlan",
          "utc": [
            "America/Chihuahua",
            "America/Mazatlan"
          ],
          "cities": ["Chihuahua", "La Paz", "Mazatlan"]
        },
        {
          "value": "Mountain Standard Time",
          "abbr": "MDT",
          "offset": -6,
          "isdst": true,
          "text": "(UTC-07:00) Mountain Time (US & Canada)",
          "utc": [
            "America/Boise",
            "America/Cambridge_Bay",
            "America/Denver",
            "America/Edmonton",
            "America/Inuvik",
            "America/Ojinaga",
            "America/Yellowknife",
            "MST7MDT"
          ],
          "cities": ["Boise", "Cambridge Bay", "Denver", "Edmonton", "Inuvik", "Ojinaga", "Yellowknife"]
        },
        {
          "value": "Central America Standard Time",
          "abbr": "CAST",
          "offset": -6,
          "isdst": false,
          "text": "(UTC-06:00) Central America",
          "utc": [
            "America/Belize",
            "America/Costa_Rica",
            "America/El_Salvador",
            "America/Guatemala",
            "America/Managua",
            "America/Tegucigalpa",
            "Etc/GMT+6",
            "Pacific/Galapagos"
          ],
          "cities": ["Belize", "Costa Rica", "El Salvador", "Guatemala", "Managua", "Tegucigalpa"]
        },
        {
          "value": "Central Standard Time",
          "abbr": "CDT",
          "offset": -5,
          "isdst": true,
          "text": "(UTC-06:00) Central Time (US & Canada)",
          "utc": [
            "America/Chicago",
            "America/Indiana/Knox",
            "America/Indiana/Tell_City",
            "America/Matamoros",
            "America/Menominee",
            "America/North_Dakota/Beulah",
            "America/North_Dakota/Center",
            "America/North_Dakota/New_Salem",
            "America/Rainy_River",
            "America/Rankin_Inlet",
            "America/Resolute",
            "America/Winnipeg",
            "CST6CDT"
          ],
          "cities": ["Chicago", "Knox", "Tell City", "Matamoros", "Menominee", "Beulah", "Center", "New Salem", "Rainy River", "Rankin Inlet", "Resolute", "Winnipeg"]
        },
        {
          "value": "Central Standard Time (Mexico)",
          "abbr": "CDT",
          "offset": -5,
          "isdst": true,
          "text": "(UTC-06:00) Guadalajara, Mexico City, Monterrey",
          "utc": [
            "America/Bahia_Banderas",
            "America/Cancun",
            "America/Merida",
            "America/Mexico_City",
            "America/Monterrey"
          ],
          "cities": ["Bahia Banderas", "Cancun", "Merida", "Mexico City", "Monterrey"]
        },
        {
          "value": "Canada Central Standard Time",
          "abbr": "CCST",
          "offset": -6,
          "isdst": false,
          "text": "(UTC-06:00) Saskatchewan",
          "utc": [
            "America/Regina",
            "America/Swift_Current"
          ],
          "cities": ["Regina", "Swift Current"]
        },
        {
          "value": "SA Pacific Standard Time",
          "abbr": "SPST",
          "offset": -5,
          "isdst": false,
          "text": "(UTC-05:00) Bogota, Lima, Quito",
          "utc": [
            "America/Bogota",
            "America/Cayman",
            "America/Coral_Harbour",
            "America/Eirunepe",
            "America/Guayaquil",
            "America/Jamaica",
            "America/Lima",
            "America/Panama",
            "America/Rio_Branco",
            "Etc/GMT+5"
          ],
          "cities": ["Bogota", "Cayman", "Coral Harbour", "Eirunepe", "Guayaquil", "Jamaica", "Lima", "Panama", "Rio Branco"]
        },
        {
          "value": "Eastern Standard Time",
          "abbr": "EST",
          "offset": -5,
          "isdst": false,
          "text": "(UTC-05:00) Eastern Time (US & Canada)",
          "utc": [
            "America/Detroit",
            "America/Havana",
            "America/Indiana/Petersburg",
            "America/Indiana/Vincennes",
            "America/Indiana/Winamac",
            "America/Iqaluit",
            "America/Kentucky/Monticello",
            "America/Louisville",
            "America/Montreal",
            "America/Nassau",
            "America/New_York",
            "America/Nipigon",
            "America/Pangnirtung",
            "America/Port-au-Prince",
            "America/Thunder_Bay",
            "America/Toronto"
          ],
          "cities": ["Detroit", "Havana", "Petersburg", "Vincennes", "Winamac", "Iqaluit", "Monticello", "Louisville", "Montreal", "Nassau", "New York", "Nipigon", "Pangnirtung", "Port-au-Prince", "Thunder Bay", "Toronto"]
        },
        {
          "value": "Eastern Daylight Time",
          "abbr": "EDT",
          "offset": -4,
          "isdst": true,
          "text": "(UTC-04:00) Eastern Daylight Time (US & Canada)",
          "utc": [
            "America/Detroit",
            "America/Havana",
            "America/Indiana/Petersburg",
            "America/Indiana/Vincennes",
            "America/Indiana/Winamac",
            "America/Iqaluit",
            "America/Kentucky/Monticello",
            "America/Louisville",
            "America/Montreal",
            "America/Nassau",
            "America/New_York",
            "America/Nipigon",
            "America/Pangnirtung",
            "America/Port-au-Prince",
            "America/Thunder_Bay",
            "America/Toronto"
          ],
          "cities": ["Detroit", "Havana", "Petersburg", "Vincennes", "Winamac", "Iqaluit", "Monticello", "Louisville", "Montreal", "Nassau", "New York", "Nipigon", "Pangnirtung", "Port-au-Prince", "Thunder Bay", "Toronto"]
        },
        {
          "value": "US Eastern Standard Time",
          "abbr": "UEDT",
          "offset": -5,
          "isdst": false,
          "text": "(UTC-05:00) Indiana (East)",
          "utc": [
            "America/Indiana/Marengo",
            "America/Indiana/Vevay",
            "America/Indianapolis"
          ],
          "cities": ["Marengo", "Vevay", "Indianapolis"]
        },
        {
          "value": "Venezuela Standard Time",
          "abbr": "VST",
          "offset": -4.5,
          "isdst": false,
          "text": "(UTC-04:30) Caracas",
          "utc": [
            "America/Caracas"
          ],
          "cities": ["Caracas"]
        },
        {
          "value": "Paraguay Standard Time",
          "abbr": "PYT",
          "offset": -4,
          "isdst": false,
          "text": "(UTC-04:00) Asuncion",
          "utc": [
            "America/Asuncion"
          ],
          "cities": ["Asuncion"]
        },
        {
          "value": "Atlantic Standard Time",
          "abbr": "ADT",
          "offset": -3,
          "isdst": true,
          "text": "(UTC-04:00) Atlantic Time (Canada)",
          "utc": [
            "America/Glace_Bay",
            "America/Goose_Bay",
            "America/Halifax",
            "America/Moncton",
            "America/Thule",
            "Atlantic/Bermuda"
          ],
          "cities": ["Glace Bay", "Goose Bay", "Halifax", "Moncton", "Thule", "Bermuda"]
        },
        {
          "value": "Central Brazilian Standard Time",
          "abbr": "CBST",
          "offset": -4,
          "isdst": false,
          "text": "(UTC-04:00) Cuiaba",
          "utc": [
            "America/Campo_Grande",
            "America/Cuiaba"
          ],
          "cities": ["Campo Grande", "Cuiaba"]
        },
        {
          "value": "SA Western Standard Time",
          "abbr": "SWST",
          "offset": -4,
          "isdst": false,
          "text": "(UTC-04:00) Georgetown, La Paz, Manaus, San Juan",
          "utc": [
            "America/Anguilla",
            "America/Antigua",
            "America/Aruba",
            "America/Barbados",
            "America/Blanc-Sablon",
            "America/Boa_Vista",
            "America/Curacao",
            "America/Dominica",
            "America/Grand_Turk",
            "America/Grenada",
            "America/Guadeloupe",
            "America/Guyana",
            "America/Kralendijk",
            "America/La_Paz",
            "America/Lower_Princes",
            "America/Manaus",
            "America/Marigot",
            "America/Martinique",
            "America/Montserrat",
            "America/Port_of_Spain",
            "America/Porto_Velho",
            "America/Puerto_Rico",
            "America/Santo_Domingo",
            "America/St_Barthelemy",
            "America/St_Kitts",
            "America/St_Lucia",
            "America/St_Thomas",
            "America/St_Vincent",
            "America/Tortola",
            "Etc/GMT+4"
          ],
          "cities": ["Anguilla", "Antigua", "Aruba", "Barbados", "Blanc-Sablon", "Boa Vista", "Curacao", "Dominica", "Grand Turk", "Grenada", "Guadeloupe", "Guyana", "Kralendijk", "La Paz", "Lower Princes", "Manaus", "Marigot", "Martinique", "Montserrat", "Port of Spain", "Porto Velho", "Puerto Rico", "Santo Domingo", "St Barthelemy", "St Kitts", "St Lucia", "St Thomas", "St Vincent", "Tortola"]
        },
        {
          "value": "Pacific SA Standard Time",
          "abbr": "PSST",
          "offset": -4,
          "isdst": false,
          "text": "(UTC-04:00) Santiago",
          "utc": [
            "America/Santiago",
            "Antarctica/Palmer"
          ],
          "cities": ["Santiago", "Palmer"]
        },
        {
          "value": "Newfoundland Standard Time",
          "abbr": "NDT",
          "offset": -2.5,
          "isdst": true,
          "text": "(UTC-03:30) Newfoundland",
          "utc": [
            "America/St_Johns"
          ],
          "cities": ["St Johns"]
        },
        {
          "value": "E. South America Standard Time",
          "abbr": "ESAST",
          "offset": -3,
          "isdst": false,
          "text": "(UTC-03:00) Brasilia",
          "utc": [
            "America/Sao_Paulo"
          ],
          "cities": ["Sao Paulo"]
        },
        {
          "value": "Argentina Standard Time",
          "abbr": "AST",
          "offset": -3,
          "isdst": false,
          "text": "(UTC-03:00) Buenos Aires",
          "utc": [
            "America/Argentina/La_Rioja",
            "America/Argentina/Rio_Gallegos",
            "America/Argentina/Salta",
            "America/Argentina/San_Juan",
            "America/Argentina/San_Luis",
            "America/Argentina/Tucuman",
            "America/Argentina/Ushuaia",
            "America/Buenos_Aires",
            "America/Catamarca",
            "America/Cordoba",
            "America/Jujuy",
            "America/Mendoza"
          ],
          "cities": ["La Rioja", "Rio Gallegos", "Salta", "San Juan", "San Luis", "Tucuman", "Ushuaia", "Buenos Aires", "Catamarca", "Cordoba", "Jujuy", "Mendoza"]
        },
        {
          "value": "SA Eastern Standard Time",
          "abbr": "SEST",
          "offset": -3,
          "isdst": false,
          "text": "(UTC-03:00) Cayenne, Fortaleza",
          "utc": [
            "America/Araguaina",
            "America/Belem",
            "America/Cayenne",
            "America/Fortaleza",
            "America/Maceio",
            "America/Paramaribo",
            "America/Recife",
            "America/Santarem",
            "Antarctica/Rothera",
            "Atlantic/Stanley",
            "Etc/GMT+3"
          ],
          "cities": ["Araguaina", "Belem", "Cayenne", "Fortaleza", "Maceio", "Paramaribo", "Recife", "Santarem", "Rothera", "Stanley"]
        },
        {
          "value": "Greenland Standard Time",
          "abbr": "GDT",
          "offset": -3,
          "isdst": true,
          "text": "(UTC-03:00) Greenland",
          "utc": [
            "America/Godthab"
          ],
          "cities": ["Godthab"]
        },
        {
          "value": "Montevideo Standard Time",
          "abbr": "MST",
          "offset": -3,
          "isdst": false,
          "text": "(UTC-03:00) Montevideo",
          "utc": [
            "America/Montevideo"
          ],
          "cities": ["Montevideo"]
        },
        {
          "value": "Bahia Standard Time",
          "abbr": "BST",
          "offset": -3,
          "isdst": false,
          "text": "(UTC-03:00) Salvador",
          "utc": [
            "America/Bahia"
          ],
          "cities": ["Bahia"]
        },
        {
          "value": "UTC-02",
          "abbr": "U",
          "offset": -2,
          "isdst": false,
          "text": "(UTC-02:00) Coordinated Universal Time-02",
          "utc": [
            "America/Noronha",
            "Atlantic/South_Georgia",
            "Etc/GMT+2"
          ],
          "cities": ["Noronha", "South Georgia"]
        },
        {
          "value": "Mid-Atlantic Standard Time",
          "abbr": "MDT",
          "offset": -1,
          "isdst": true,
          "text": "(UTC-02:00) Mid-Atlantic - Old",
          "utc": [],
          "cities": []
        },
        {
          "value": "Azores Standard Time",
          "abbr": "ADT",
          "offset": 0,
          "isdst": true,
          "text": "(UTC-01:00) Azores",
          "utc": [
            "America/Scoresbysund",
            "Atlantic/Azores"
          ],
          "cities": ["Scoresbysund", "Azores"]
        },
        {
          "value": "Cape Verde Standard Time",
          "abbr": "CVST",
          "offset": -1,
          "isdst": false,
          "text": "(UTC-01:00) Cape Verde Is.",
          "utc": [
            "Atlantic/Cape_Verde",
            "Etc/GMT+1"
          ],
          "cities": ["Cape Verde"]
        },
        {
          "value": "Morocco Standard Time",
          "abbr": "MDT",
          "offset": 1,
          "isdst": true,
          "text": "(UTC) Casablanca",
          "utc": [
            "Africa/Casablanca",
            "Africa/El_Aaiun"
          ],
          "cities": ["Casablanca", "El Aaiun"]
        },
        {
          "value": "UTC",
          "abbr": "UTC",
          "offset": 0,
          "isdst": false,
          "text": "(UTC) Coordinated Universal Time",
          "utc": [
            "America/Danmarkshavn",
            "Etc/GMT"
          ],
          "cities": ["Danmarkshavn"]
        },
        {
          "value": "GMT Standard Time",
          "abbr": "GMT",
          "offset": 0,
          "isdst": false,
          "text": "(UTC) Edinburgh, London",
          "utc": [
            "Europe/Isle_of_Man",
            "Europe/Guernsey",
            "Europe/Jersey",
            "Europe/London"
          ],
          "cities": ["Isle of Man", "Guernsey", "Jersey", "London"]
        },
        {
          "value": "British Summer Time",
          "abbr": "BST",
          "offset": 1,
          "isdst": true,
          "text": "(UTC+01:00) Edinburgh, London",
          "utc": [
            "Europe/Isle_of_Man",
            "Europe/Guernsey",
            "Europe/Jersey",
            "Europe/London"
          ],
          "cities": ["Isle of Man", "Guernsey", "Jersey", "London"]
        },
        {
          "value": "GMT Standard Time",
          "abbr": "GDT",
          "offset": 1,
          "isdst": true,
          "text": "(UTC) Dublin, Lisbon",
          "utc": [
            "Atlantic/Canary",
            "Atlantic/Faeroe",
            "Atlantic/Madeira",
            "Europe/Dublin",
            "Europe/Lisbon"
          ],
          "cities": ["Canary", "Faeroe", "Madeira", "Dublin", "Lisbon"]
        },
        {
          "value": "Greenwich Standard Time",
          "abbr": "GST",
          "offset": 0,
          "isdst": false,
          "text": "(UTC) Monrovia, Reykjavik",
          "utc": [
            "Africa/Abidjan",
            "Africa/Accra",
            "Africa/Bamako",
            "Africa/Banjul",
            "Africa/Bissau",
            "Africa/Conakry",
            "Africa/Dakar",
            "Africa/Freetown",
            "Africa/Lome",
            "Africa/Monrovia",
            "Africa/Nouakchott",
            "Africa/Ouagadougou",
            "Africa/Sao_Tome",
            "Atlantic/Reykjavik",
            "Atlantic/St_Helena"
          ],
          "cities": ["Abidjan", "Accra", "Bamako", "Banjul", "Bissau", "Conakry", "Dakar", "Freetown", "Lome", "Monrovia", "Nouakchott", "Ouagadougou", "Sao Tome", "Reykjavik", "St Helena"]
        },
        {
          "value": "W. Europe Standard Time",
          "abbr": "WEDT",
          "offset": 2,
          "isdst": true,
          "text": "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna",
          "utc": [
            "Arctic/Longyearbyen",
            "Europe/Amsterdam",
            "Europe/Andorra",
            "Europe/Berlin",
            "Europe/Busingen",
            "Europe/Gibraltar",
            "Europe/Luxembourg",
            "Europe/Malta",
            "Europe/Monaco",
            "Europe/Oslo",
            "Europe/Rome",
            "Europe/San_Marino",
            "Europe/Stockholm",
            "Europe/Vaduz",
            "Europe/Vatican",
            "Europe/Vienna",
            "Europe/Zurich"
          ],
          "cities": ["Longyearbyen", "Amsterdam", "Andorra", "Berlin", "Busingen", "Gibraltar", "Luxembourg", "Malta", "Monaco", "Oslo", "Rome", "San Marino", "Stockholm", "Vaduz", "Vatican", "Vienna", "Zurich"]
        },
        {
          "value": "Central Europe Standard Time",
          "abbr": "CEDT",
          "offset": 2,
          "isdst": true,
          "text": "(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague",
          "utc": [
            "Europe/Belgrade",
            "Europe/Bratislava",
            "Europe/Budapest",
            "Europe/Ljubljana",
            "Europe/Podgorica",
            "Europe/Prague",
            "Europe/Tirane"
          ],
          "cities": ["Belgrade", "Bratislava", "Budapest", "Ljubljana", "Podgorica", "Prague", "Tirane"]
        },
        {
          "value": "Romance Standard Time",
          "abbr": "RDT",
          "offset": 2,
          "isdst": true,
          "text": "(UTC+01:00) Brussels, Copenhagen, Madrid, Paris",
          "utc": [
            "Africa/Ceuta",
            "Europe/Brussels",
            "Europe/Copenhagen",
            "Europe/Madrid",
            "Europe/Paris"
          ],
          "cities": ["Ceuta", "Brussels", "Copenhagen", "Madrid", "Paris"]
        },
        {
          "value": "Central European Standard Time",
          "abbr": "CEDT",
          "offset": 2,
          "isdst": true,
          "text": "(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb",
          "utc": [
            "Europe/Sarajevo",
            "Europe/Skopje",
            "Europe/Warsaw",
            "Europe/Zagreb"
          ],
          "cities": ["Sarajevo", "Skopje", "Warsaw", "Zagreb"]
        },
        {
          "value": "W. Central Africa Standard Time",
          "abbr": "WCAST",
          "offset": 1,
          "isdst": false,
          "text": "(UTC+01:00) West Central Africa",
          "utc": [
            "Africa/Algiers",
            "Africa/Bangui",
            "Africa/Brazzaville",
            "Africa/Douala",
            "Africa/Kinshasa",
            "Africa/Lagos",
            "Africa/Libreville",
            "Africa/Luanda",
            "Africa/Malabo",
            "Africa/Ndjamena",
            "Africa/Niamey",
            "Africa/Porto-Novo",
            "Africa/Tunis",
            "Etc/GMT-1"
          ],
          "cities": ["Algiers", "Bangui", "Brazzaville", "Douala", "Kinshasa", "Lagos", "Libreville", "Luanda", "Malabo", "Ndjamena", "Niamey", "Porto-Novo", "Tunis"]
        },
        {
          "value": "Namibia Standard Time",
          "abbr": "NST",
          "offset": 1,
          "isdst": false,
          "text": "(UTC+01:00) Windhoek",
          "utc": [
            "Africa/Windhoek"
          ],
          "cities": ["Windhoek"]
        },
        {
          "value": "GTB Standard Time",
          "abbr": "GDT",
          "offset": 3,
          "isdst": true,
          "text": "(UTC+02:00) Athens, Bucharest",
          "utc": [
            "Asia/Nicosia",
            "Europe/Athens",
            "Europe/Bucharest",
            "Europe/Chisinau"
          ],
          "cities": ["Nicosia", "Athens", "Bucharest", "Chisinau"]
        },
        {
          "value": "Middle East Standard Time",
          "abbr": "MEDT",
          "offset": 3,
          "isdst": true,
          "text": "(UTC+02:00) Beirut",
          "utc": [
            "Asia/Beirut"
          ],
          "cities": ["Beirut"]
        },
        {
          "value": "Egypt Standard Time",
          "abbr": "EST",
          "offset": 2,
          "isdst": false,
          "text": "(UTC+02:00) Cairo",
          "utc": [
            "Africa/Cairo"
          ],
          "cities": ["Cairo"]
        },
        {
          "value": "Syria Standard Time",
          "abbr": "SDT",
          "offset": 3,
          "isdst": true,
          "text": "(UTC+02:00) Damascus",
          "utc": [
            "Asia/Damascus"
          ],
          "cities": ["Damascus"]
        },
        {
          "value": "E. Europe Standard Time",
          "abbr": "EEDT",
          "offset": 3,
          "isdst": true,
          "text": "(UTC+02:00) E. Europe",
          "utc": [
            "Asia/Nicosia",
            "Europe/Athens",
            "Europe/Bucharest",
            "Europe/Chisinau",
            "Europe/Helsinki",
            "Europe/Kiev",
            "Europe/Mariehamn",
            "Europe/Nicosia",
            "Europe/Riga",
            "Europe/Sofia",
            "Europe/Tallinn",
            "Europe/Uzhgorod",
            "Europe/Vilnius",
            "Europe/Zaporozhye"
          ],
          "cities": ["Nicosia", "Athens", "Bucharest", "Chisinau", "Helsinki", "Kiev", "Mariehamn", "Riga", "Sofia", "Tallinn", "Uzhgorod", "Vilnius", "Zaporozhye"]
        },
        {
          "value": "South Africa Standard Time",
          "abbr": "SAST",
          "offset": 2,
          "isdst": false,
          "text": "(UTC+02:00) Harare, Pretoria",
          "utc": [
            "Africa/Blantyre",
            "Africa/Bujumbura",
            "Africa/Gaborone",
            "Africa/Harare",
            "Africa/Johannesburg",
            "Africa/Kigali",
            "Africa/Lubumbashi",
            "Africa/Lusaka",
            "Africa/Maputo",
            "Africa/Maseru",
            "Africa/Mbabane",
            "Etc/GMT-2"
          ],
          "cities": ["Blantyre", "Bujumbura", "Gaborone", "Harare", "Johannesburg", "Kigali", "Lubumbashi", "Lusaka", "Maputo", "Maseru", "Mbabane"]
        },
        {
          "value": "FLE Standard Time",
          "abbr": "FDT",
          "offset": 3,
          "isdst": true,
          "text": "(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius",
          "utc": [
            "Europe/Helsinki",
            "Europe/Kiev",
            "Europe/Mariehamn",
            "Europe/Riga",
            "Europe/Sofia",
            "Europe/Tallinn",
            "Europe/Uzhgorod",
            "Europe/Vilnius",
            "Europe/Zaporozhye"
          ],
          "cities": ["Helsinki", "Kiev", "Mariehamn", "Riga", "Sofia", "Tallinn", "Uzhgorod", "Vilnius", "Zaporozhye"]
        },
        {
          "value": "Turkey Standard Time",
          "abbr": "TDT",
          "offset": 3,
          "isdst": false,
          "text": "(UTC+03:00) Istanbul",
          "utc": [
            "Europe/Istanbul"
          ],
          "cities": ["Istanbul"]
        },
        {
          "value": "Israel Standard Time",
          "abbr": "JDT",
          "offset": 3,
          "isdst": true,
          "text": "(UTC+02:00) Jerusalem",
          "utc": [
            "Asia/Jerusalem"
          ],
          "cities": ["Jerusalem"]
        },
        {
          "value": "Libya Standard Time",
          "abbr": "LST",
          "offset": 2,
          "isdst": false,
          "text": "(UTC+02:00) Tripoli",
          "utc": [
            "Africa/Tripoli"
          ],
          "cities": ["Tripoli"]
        },
        {
          "value": "Jordan Standard Time",
          "abbr": "JST",
          "offset": 3,
          "isdst": false,
          "text": "(UTC+03:00) Amman",
          "utc": [
            "Asia/Amman"
          ],
          "cities": ["Amman"]
        },
        {
          "value": "Arabic Standard Time",
          "abbr": "AST",
          "offset": 3,
          "isdst": false,
          "text": "(UTC+03:00) Baghdad",
          "utc": [
            "Asia/Baghdad"
          ],
          "cities": ["Baghdad"]
        },
        {
          "value": "Kaliningrad Standard Time",
          "abbr": "KST",
          "offset": 3,
          "isdst": false,
          "text": "(UTC+02:00) Kaliningrad",
          "utc": [
            "Europe/Kaliningrad"
          ],
          "cities": ["Kaliningrad"]
        },
        {
          "value": "Arab Standard Time",
          "abbr": "AST",
          "offset": 3,
          "isdst": false,
          "text": "(UTC+03:00) Kuwait, Riyadh",
          "utc": [
            "Asia/Aden",
            "Asia/Bahrain",
            "Asia/Kuwait",
            "Asia/Qatar",
            "Asia/Riyadh"
          ],
          "cities": ["Aden", "Bahrain", "Kuwait", "Qatar", "Riyadh"]
        },
        {
          "value": "E. Africa Standard Time",
          "abbr": "EAST",
          "offset": 3,
          "isdst": false,
          "text": "(UTC+03:00) Nairobi",
          "utc": [
            "Africa/Addis_Ababa",
            "Africa/Asmera",
            "Africa/Dar_es_Salaam",
            "Africa/Djibouti",
            "Africa/Juba",
            "Africa/Kampala",
            "Africa/Khartoum",
            "Africa/Mogadishu",
            "Africa/Nairobi",
            "Antarctica/Syowa",
            "Etc/GMT-3",
            "Indian/Antananarivo",
            "Indian/Comoro",
            "Indian/Mayotte"
          ],
          "cities": ["Addis Ababa", "Asmera", "Dar es Salaam", "Djibouti", "Juba", "Kampala", "Khartoum", "Mogadishu", "Nairobi", "Syowa", "Antananarivo", "Comoro", "Mayotte"]
        },
        {
          "value": "Moscow Standard Time",
          "abbr": "MSK",
          "offset": 3,
          "isdst": false,
          "text": "(UTC+03:00) Moscow, St. Petersburg, Volgograd, Minsk",
          "utc": [
            "Europe/Kirov",
            "Europe/Moscow",
            "Europe/Simferopol",
            "Europe/Volgograd",
            "Europe/Minsk"
          ],
          "cities": ["Kirov", "Moscow", "Simferopol", "Volgograd", "Minsk"]
        },
        {
          "value": "Samara Time",
          "abbr": "SAMT",
          "offset": 4,
          "isdst": false,
          "text": "(UTC+04:00) Samara, Ulyanovsk, Saratov",
          "utc": [
            "Europe/Astrakhan",
            "Europe/Samara",
            "Europe/Ulyanovsk"
          ],
          "cities": ["Astrakhan", "Samara", "Ulyanovsk"]
        },
        {
          "value": "Iran Standard Time",
          "abbr": "IDT",
          "offset": 4.5,
          "isdst": true,
          "text": "(UTC+03:30) Tehran",
          "utc": [
            "Asia/Tehran"
          ],
          "cities": ["Tehran"]
        },
        {
          "value": "Arabian Standard Time",
          "abbr": "AST",
          "offset": 4,
          "isdst": false,
          "text": "(UTC+04:00) Abu Dhabi, Muscat",
          "utc": [
            "Asia/Dubai",
            "Asia/Muscat",
            "Etc/GMT-4"
          ],
          "cities": ["Dubai", "Muscat"]
        },
        {
          "value": "Azerbaijan Standard Time",
          "abbr": "ADT",
          "offset": 5,
          "isdst": true,
          "text": "(UTC+04:00) Baku",
          "utc": [
            "Asia/Baku"
          ],
          "cities": ["Baku"]
        },
        {
          "value": "Mauritius Standard Time",
          "abbr": "MST",
          "offset": 4,
          "isdst": false,
          "text": "(UTC+04:00) Port Louis",
          "utc": [
            "Indian/Mahe",
            "Indian/Mauritius",
            "Indian/Reunion"
          ],
          "cities": ["Mahe", "Mauritius", "Reunion"]
        },
        {
          "value": "Georgian Standard Time",
          "abbr": "GET",
          "offset": 4,
          "isdst": false,
          "text": "(UTC+04:00) Tbilisi",
          "utc": [
            "Asia/Tbilisi"
          ],
          "cities": ["Tbilisi"]
        },
        {
          "value": "Caucasus Standard Time",
          "abbr": "CST",
          "offset": 4,
          "isdst": false,
          "text": "(UTC+04:00) Yerevan",
          "utc": [
            "Asia/Yerevan"
          ],
          "cities": ["Yerevan"]
        },
        {
          "value": "Afghanistan Standard Time",
          "abbr": "AST",
          "offset": 4.5,
          "isdst": false,
          "text": "(UTC+04:30) Kabul",
          "utc": [
            "Asia/Kabul"
          ],
          "cities": ["Kabul"]
        },
        {
          "value": "West Asia Standard Time",
          "abbr": "WAST",
          "offset": 5,
          "isdst": false,
          "text": "(UTC+05:00) Ashgabat, Tashkent",
          "utc": [
            "Antarctica/Mawson",
            "Asia/Aqtau",
            "Asia/Aqtobe",
            "Asia/Ashgabat",
            "Asia/Dushanbe",
            "Asia/Oral",
            "Asia/Samarkand",
            "Asia/Tashkent",
            "Etc/GMT-5",
            "Indian/Kerguelen",
            "Indian/Maldives"
          ],
          "cities": ["Mawson", "Aqtau", "Aqtobe", "Ashgabat", "Dushanbe", "Oral", "Samarkand", "Tashkent", "Kerguelen", "Maldives"]
        },
        {
          "value": "Yekaterinburg Time",
          "abbr": "YEKT",
          "offset": 5,
          "isdst": false,
          "text": "(UTC+05:00) Yekaterinburg",
          "utc": [
            "Asia/Yekaterinburg"
          ],
          "cities": ["Yekaterinburg"]
        },
        {
          "value": "Pakistan Standard Time",
          "abbr": "PKT",
          "offset": 5,
          "isdst": false,
          "text": "(UTC+05:00) Islamabad, Karachi",
          "utc": [
            "Asia/Karachi"
          ],
          "cities": ["Islamabad", "Karachi"]
        },
        {
          "value": "India Standard Time",
          "abbr": "IST",
          "offset": 5.5,
          "isdst": false,
          "text": "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi",
          "utc": [
            "Asia/Kolkata",
            "Asia/Calcutta"
          ],
          "cities": ["Chennai", "Kolkata", "Mumbai", "New Delhi"]
        },
        {
          "value": "Sri Lanka Standard Time",
          "abbr": "SLST",
          "offset": 5.5,
          "isdst": false,
          "text": "(UTC+05:30) Sri Jayawardenepura",
          "utc": [
            "Asia/Colombo"
          ],
          "cities": ["Sri Jayawardenepura"]
        },
        {
          "value": "Nepal Standard Time",
          "abbr": "NST",
          "offset": 5.75,
          "isdst": false,
          "text": "(UTC+05:45) Kathmandu",
          "utc": [
            "Asia/Kathmandu"
          ],
          "cities": ["Kathmandu"]
        },
        {
          "value": "Central Asia Standard Time",
          "abbr": "CAST",
          "offset": 6,
          "isdst": false,
          "text": "(UTC+06:00) Nur-Sultan (Astana)",
          "utc": [
            "Antarctica/Vostok",
            "Asia/Almaty",
            "Asia/Bishkek",
            "Asia/Qyzylorda",
            "Asia/Urumqi",
            "Etc/GMT-6",
            "Indian/Chagos"
          ],
          "cities": ["Vostok", "Almaty", "Bishkek", "Qyzylorda", "Urumqi", "Chagos"]
        },
        {
          "value": "Bangladesh Standard Time",
          "abbr": "BST",
          "offset": 6,
          "isdst": false,
          "text": "(UTC+06:00) Dhaka",
          "utc": [
            "Asia/Dhaka",
            "Asia/Thimphu"
          ],
          "cities": ["Dhaka", "Thimphu"]
        },
        {
          "value": "Myanmar Standard Time",
          "abbr": "MST",
          "offset": 6.5,
          "isdst": false,
          "text": "(UTC+06:30) Yangon (Rangoon)",
          "utc": [
            "Asia/Rangoon",
            "Indian/Cocos"
          ],
          "cities": ["Yangon", "Rangoon", "Cocos"]
        },
        {
          "value": "SE Asia Standard Time",
          "abbr": "SAST",
          "offset": 7,
          "isdst": false,
          "text": "(UTC+07:00) Bangkok, Hanoi, Jakarta",
          "utc": [
            "Antarctica/Davis",
            "Asia/Bangkok",
            "Asia/Hovd",
            "Asia/Jakarta",
            "Asia/Phnom_Penh",
            "Asia/Pontianak",
            "Asia/Saigon",
            "Asia/Vientiane",
            "Etc/GMT-7",
            "Indian/Christmas"
          ],
          "cities": ["Davis", "Bangkok", "Hovd", "Jakarta", "Phnom Penh", "Pontianak", "Saigon", "Vientiane", "Christmas"]
        },
        {
          "value": "N. Central Asia Standard Time",
          "abbr": "NCAST",
          "offset": 7,
          "isdst": false,
          "text": "(UTC+07:00) Novosibirsk",
          "utc": [
            "Asia/Novokuznetsk",
            "Asia/Novosibirsk",
            "Asia/Omsk"
          ],
          "cities": ["Novokuznetsk", "Novosibirsk", "Omsk"]
        },
        {
          "value": "China Standard Time",
          "abbr": "CST",
          "offset": 8,
          "isdst": false,
          "text": "(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi",
          "utc": [
            "Asia/Hong_Kong",
            "Asia/Macau",
            "Asia/Shanghai"
          ],
          "cities": ["Hong Kong", "Macau", "Shanghai"]
        },
        {
          "value": "North Asia Standard Time",
          "abbr": "NAST",
          "offset": 8,
          "isdst": false,
          "text": "(UTC+08:00) Krasnoyarsk",
          "utc": [
            "Asia/Krasnoyarsk"
          ],
          "cities": ["Krasnoyarsk"]
        },
        {
          "value": "Singapore Standard Time",
          "abbr": "MPST",
          "offset": 8,
          "isdst": false,
          "text": "(UTC+08:00) Kuala Lumpur, Singapore",
          "utc": [
            "Asia/Brunei",
            "Asia/Kuala_Lumpur",
            "Asia/Kuching",
            "Asia/Makassar",
            "Asia/Manila",
            "Asia/Singapore",
            "Etc/GMT-8"
          ],
          "cities": ["Brunei", "Kuala Lumpur", "Kuching", "Makassar", "Manila", "Singapore"]
        },
        {
          "value": "W. Australia Standard Time",
          "abbr": "WAST",
          "offset": 8,
          "isdst": false,
          "text": "(UTC+08:00) Perth",
          "utc": [
            "Antarctica/Casey",
            "Australia/Perth"
          ],
          "cities": ["Casey", "Perth"]
        },
        {
          "value": "Taipei Standard Time",
          "abbr": "TST",
          "offset": 8,
          "isdst": false,
          "text": "(UTC+08:00) Taipei",
          "utc": [
            "Asia/Taipei"
          ],
          "cities": ["Taipei"]
        },
        {
          "value": "Ulaanbaatar Standard Time",
          "abbr": "UST",
          "offset": 8,
          "isdst": false,
          "text": "(UTC+08:00) Ulaanbaatar",
          "utc": [
            "Asia/Choibalsan",
            "Asia/Ulaanbaatar"
          ],
          "cities": ["Choibalsan", "Ulaanbaatar"]
        },
        {
          "value": "North Asia East Standard Time",
          "abbr": "NAEST",
          "offset": 8,
          "isdst": false,
          "text": "(UTC+08:00) Irkutsk",
          "utc": [
            "Asia/Irkutsk"
          ],
          "cities": ["Irkutsk"]
        },
        {
          "value": "Japan Standard Time",
          "abbr": "JST",
          "offset": 9,
          "isdst": false,
          "text": "(UTC+09:00) Osaka, Sapporo, Tokyo",
          "utc": [
            "Asia/Dili",
            "Asia/Jayapura",
            "Asia/Tokyo",
            "Etc/GMT-9",
            "Pacific/Palau"
          ],
          "cities": ["Dili", "Jayapura", "Tokyo", "Palau"]
        },
        {
          "value": "Korea Standard Time",
          "abbr": "KST",
          "offset": 9,
          "isdst": false,
          "text": "(UTC+09:00) Seoul",
          "utc": [
            "Asia/Pyongyang",
            "Asia/Seoul"
          ],
          "cities": ["Pyongyang", "Seoul"]
        },
        {
          "value": "Cen. Australia Standard Time",
          "abbr": "CAST",
          "offset": 9.5,
          "isdst": false,
          "text": "(UTC+09:30) Adelaide",
          "utc": [
            "Australia/Adelaide",
            "Australia/Broken_Hill"
          ],
          "cities": ["Adelaide", "Broken Hill"]
        },
        {
          "value": "AUS Central Standard Time",
          "abbr": "ACST",
          "offset": 9.5,
          "isdst": false,
          "text": "(UTC+09:30) Darwin",
          "utc": [
            "Australia/Darwin"
          ],
          "cities": ["Darwin"]
        },
        {
          "value": "E. Australia Standard Time",
          "abbr": "EAST",
          "offset": 10,
          "isdst": false,
          "text": "(UTC+10:00) Brisbane",
          "utc": [
            "Australia/Brisbane",
            "Australia/Lindeman"
          ],
          "cities": ["Brisbane", "Lindeman"]
        },
        {
          "value": "AUS Eastern Standard Time",
          "abbr": "AEST",
          "offset": 10,
          "isdst": false,
          "text": "(UTC+10:00) Canberra, Melbourne, Sydney",
          "utc": [
            "Australia/Melbourne",
            "Australia/Sydney"
          ],
          "cities": ["Melbourne", "Sydney"]
        },
        {
          "value": "West Pacific Standard Time",
          "abbr": "WPST",
          "offset": 10,
          "isdst": false,
          "text": "(UTC+10:00) Guam, Port Moresby",
          "utc": [
            "Antarctica/DumontDUrville",
            "Etc/GMT-10",
            "Pacific/Guam",
            "Pacific/Port_Moresby",
            "Pacific/Saipan",
            "Pacific/Truk"
          ],
          "cities": ["DumontDUrville", "Guam", "Port Moresby", "Saipan", "Truk"]
        },
        {
          "value": "Tasmania Standard Time",
          "abbr": "TST",
          "offset": 10,
          "isdst": false,
          "text": "(UTC+10:00) Hobart",
          "utc": [
            "Australia/Currie",
            "Australia/Hobart"
          ],
          "cities": ["Currie", "Hobart"]
        },
        {
          "value": "Yakutsk Standard Time",
          "abbr": "YST",
          "offset": 9,
          "isdst": false,
          "text": "(UTC+09:00) Yakutsk",
          "utc": [
            "Asia/Chita",
            "Asia/Khandyga",
            "Asia/Yakutsk"
          ],
          "cities": ["Chita", "Khandyga", "Yakutsk"]
        },
        {
          "value": "Central Pacific Standard Time",
          "abbr": "CPST",
          "offset": 11,
          "isdst": false,
          "text": "(UTC+11:00) Solomon Is., New Caledonia",
          "utc": [
            "Antarctica/Macquarie",
            "Etc/GMT-11",
            "Pacific/Efate",
            "Pacific/Guadalcanal",
            "Pacific/Kosrae",
            "Pacific/Noumea",
            "Pacific/Ponape"
          ],
          "cities": ["Macquarie", "Efate", "Guadalcanal", "Kosrae", "Noumea", "Ponape"]
        },
        {
          "value": "Vladivostok Standard Time",
          "abbr": "VST",
          "offset": 11,
          "isdst": false,
          "text": "(UTC+11:00) Vladivostok",
          "utc": [
            "Asia/Sakhalin",
            "Asia/Ust-Nera",
            "Asia/Vladivostok"
          ],
          "cities": ["Sakhalin", "Ust-Nera", "Vladivostok"]
        },
        {
          "value": "New Zealand Standard Time",
          "abbr": "NZST",
          "offset": 12,
          "isdst": false,
          "text": "(UTC+12:00) Auckland, Wellington",
          "utc": [
            "Antarctica/McMurdo",
            "Pacific/Auckland"
          ],
          "cities": ["McMurdo", "Auckland"]
        },
        {
          "value": "UTC+12",
          "abbr": "U",
          "offset": 12,
          "isdst": false,
          "text": "(UTC+12:00) Coordinated Universal Time+12",
          "utc": [
            "Etc/GMT-12",
            "Pacific/Funafuti",
            "Pacific/Kwajalein",
            "Pacific/Majuro",
            "Pacific/Nauru",
            "Pacific/Tarawa",
            "Pacific/Wake",
            "Pacific/Wallis"
          ],
          "cities": ["Funafuti", "Kwajalein", "Majuro", "Nauru", "Tarawa", "Wake", "Wallis"]
        },
        {
          "value": "Fiji Standard Time",
          "abbr": "FST",
          "offset": 12,
          "isdst": false,
          "text": "(UTC+12:00) Fiji",
          "utc": [
            "Pacific/Fiji"
          ],
          "cities": ["Fiji"]
        },
        {
          "value": "Magadan Standard Time",
          "abbr": "MST",
          "offset": 12,
          "isdst": false,
          "text": "(UTC+12:00) Magadan",
          "utc": [
            "Asia/Anadyr",
            "Asia/Kamchatka",
            "Asia/Magadan",
            "Asia/Srednekolymsk"
          ],
          "cities": ["Anadyr", "Kamchatka", "Magadan", "Srednekolymsk"]
        },
        {
          "value": "Kamchatka Standard Time",
          "abbr": "KDT",
          "offset": 13,
          "isdst": true,
          "text": "(UTC+12:00) Petropavlovsk-Kamchatsky - Old",
          "utc": [
            "Asia/Kamchatka"
          ],
          "cities": ["Kamchatka"]
        },
        {
          "value": "Tonga Standard Time",
          "abbr": "TST",
          "offset": 13,
          "isdst": false,
          "text": "(UTC+13:00) Nuku'alofa",
          "utc": [
            "Etc/GMT-13",
            "Pacific/Enderbury",
            "Pacific/Fakaofo",
            "Pacific/Tongatapu"
          ],
          "cities": ["Enderbury", "Fakaofo", "Tongatapu"]
        },
        {
          "value": "Samoa Standard Time",
          "abbr": "SST",
          "offset": 13,
          "isdst": false,
          "text": "(UTC+13:00) Samoa",
          "utc": [
            "Pacific/Apia"
          ],
          "cities": ["Apia"]
        }
      ]

    property string currentTimezone: timezones[0].text // Default to the first timezone
    property string currentUtc: timezones[0].utc[0] // Default to the first UTC in the first timezone
    property string currentCity: timezones[0].cities[0] // Default to the first city in the first timezone

    property string tempClockFormat: clockFormat
    property string tempTimezone: currentTimezone
    property string tempUtc: currentUtc
    property string tempCity: currentCity
    property int tempMethod: currentMethod
    property int tempUtcOffset: utcOffset

    property string lastFetchedTime: ""

    property var missedPrayers: {
        "Fajr": 0,
        "Dhuhr": 0,
        "Asr": 0,
        "Maghrib": 0,
        "Isha": 0
    }

    property var prayerDialogShown: {
        "Fajr": false,
        "Dhuhr": false,
        "Asr": false,
        "Maghrib": false,
        "Isha": false
    }

    function loadSettings() {
        clockFormat = settingsWrapper.value("clockFormat", "12-hour").toString()
        currentTimezone = settingsWrapper.value("currentTimezone", timezones[0].text).toString()
        currentUtc = settingsWrapper.value("currentUtc", timezones[0].utc[0]).toString()
        currentCity = settingsWrapper.value("currentCity", timezones[0].cities[0]).toString()
        currentMethod = Number(settingsWrapper.value("currentMethod", 3))
        utcOffset = Number(settingsWrapper.value("utcOffset", 0))
        lastFetchedTime = settingsWrapper.value("lastFetchedTime", "").toString()

        missedPrayers = JSON.parse(settingsWrapper.value("missedPrayers", JSON.stringify(missedPrayers)))
        prayerDialogShown = JSON.parse(settingsWrapper.value("prayerDialogShown", JSON.stringify(prayerDialogShown)))

        tempClockFormat = clockFormat
        tempTimezone = currentTimezone
        tempUtc = currentUtc
        tempCity = currentCity
        tempMethod = currentMethod
        tempUtcOffset = utcOffset
    }

    function saveSettings() {
        settingsWrapper.setValue("clockFormat", tempClockFormat)
        settingsWrapper.setValue("currentTimezone", tempTimezone)
        settingsWrapper.setValue("currentUtc", tempUtc)
        settingsWrapper.setValue("currentCity", tempCity)
        settingsWrapper.setValue("currentMethod", tempMethod)
        settingsWrapper.setValue("utcOffset", tempUtcOffset)
        settingsWrapper.setValue("lastFetchedTime", lastFetchedTime)
        settingsWrapper.setValue("missedPrayers", JSON.stringify(missedPrayers))
        settingsWrapper.setValue("prayerDialogShown", JSON.stringify(prayerDialogShown))

        clockFormat = tempClockFormat
        currentTimezone = tempTimezone
        currentUtc = tempUtc
        currentCity = tempCity
        currentMethod = tempMethod
        utcOffset = tempUtcOffset

        fetchPrayerTimings()
    }

    function updateTime() {
        var now = new Date()
        var localTime = new Date(now.getTime() + (now.getTimezoneOffset() * 60000) + (utcOffset * 3600000))

        if (clockFormat === "12-hour") {
            currentTime = Qt.formatTime(localTime, "hh:mm:ss AP")
        } else {
            currentTime = Qt.formatTime(localTime, "HH:mm:ss")
        }

        // Check each prayer time
        checkPrayer("Fajr", fajrTime)
        checkPrayer("Dhuhr", dhuhrTime)
        checkPrayer("Asr", asrTime)
        checkPrayer("Maghrib", maghribTime)
        checkPrayer("Isha", ishaTime)
    }

    function formatTime(time) {
        // Parse the time from the API response
        var [hours, minutes] = time.split(":").map(Number);

        // Create a new Date object for the parsed time
        var date = new Date();
        date.setHours(hours, minutes, 0, 0);
        date.setMinutes(date.getMinutes());

        // Format the time according to the user's clock format preference
        if (clockFormat === "12-hour") {
            return Qt.formatTime(date, "hh:mm AP");
        } else {
            return Qt.formatTime(date, "HH:mm");
        }
    }

    function fetchPrayerTimings() {
        var now = new Date();
        var dateString = now.getDate().toString().padStart(2, '0') + "-" + (now.getMonth() + 1).toString().padStart(2, '0') + "-" + now.getFullYear();
        var timezoneData = timezones.find(tz => tz.text === currentTimezone);
        if (timezoneData) {
            var region = timezoneData.utc[0].split('/')[0]; // Extract the region from the utc field
            var apiUrl = `http://api.aladhan.com/v1/timingsByCity/${dateString}?city=${currentCity}&country=${region}&method=${currentMethod}&adjustment=1`;

            console.log("API URL:", apiUrl);

            var xhr = new XMLHttpRequest();
            xhr.open("GET", apiUrl, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        var timings = response.data.timings;
                        fajrTime = formatTime(timings.Fajr);
                        sunriseTime = formatTime(timings.Sunrise);
                        dhuhrTime = formatTime(timings.Dhuhr);
                        asrTime = formatTime(timings.Asr);
                        sunsetTime = formatTime(timings.Sunset);
                        maghribTime = formatTime(timings.Maghrib);
                        ishaTime = formatTime(timings.Isha);
                        imsakTime = formatTime(timings.Imsak);
                        midnightTime = formatTime(timings.Midnight);
                        firstthirdTime = formatTime(timings.Firstthird);
                        lastthirdTime = formatTime(timings.Lastthird);

                        lastFetchedTime = now.toISOString();
                    } else {
                        console.error("Failed to fetch prayer timings");
                    }
                }
            };
            xhr.send();
        }
    }

    function checkPrayer(prayerName, prayerTime) {
        var currentTime = new Date()
        var prayerDateTime = new Date("1970-01-01T" + prayerTime + "Z")
        prayerDateTime.setHours(prayerDateTime.getHours() + utcOffset)

        if (currentTime >= prayerDateTime && !prayerDialogShown[prayerName]) {
            // Increase missed prayer count
            missedPrayers[prayerName] += 1
            prayerDialogShown[prayerName] = true
            saveSettings()
        }
    }

    Timer {
        id: timer
        interval: 1000 // Update every second
        running: true
        repeat: true
        onTriggered: {
            updateTime()
        }
    }

    Drawer {
        id: emptyDrawer
        width: parent.width * 0.3
        height: parent.height
        edge: Qt.LeftEdge

        Rectangle {
            color: "#2a2e32"
            anchors.fill: parent

            Column {
                anchors.centerIn: parent
                spacing: 10

                Text {
                    text: "Version: Rel1"
                    color: "white"
                    font.pixelSize: 16
                }

                Text {
                    text: "Author: Ikhlasulov"
                    color: "white"
                    font.pixelSize: 16
                }

                Text {
                    id: programPageLink
                    text: "GitHub"
                    color: "white"
                    font.pixelSize: 16
                    font.underline: true

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Qt.openUrlExternally("https://github.com/Ikhlasulov/Namaz")
                        cursorShape: Qt.PointingHandCursor
                    }
                }

                Button {
                    text: "Donate"
                    onClicked: Qt.openUrlExternally("https://pay.cloudtips.ru/p/693e007a")  // Replace with your donation link
                }
            }
        }
    }


    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainPage

        Component {
            id: mainPage
            Rectangle {
                color: "#2a2e32"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Text {
                        id: timeDisplay
                        text: currentTime
                        font.pointSize: Math.max(24, stackView.height / 20)
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    GridLayout {
                        columns: 2
                        rowSpacing: 10
                        columnSpacing: 50 // Increased spacing between columns
                        Layout.alignment: Qt.AlignHCenter
                        Layout.bottomMargin: 80 // Adjust this value if needed

                        Text {
                            text: "Fajr:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: fajrTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Sunrise:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: sunriseTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Dhuhr:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: dhuhrTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Asr:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: asrTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Sunset:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: sunsetTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Maghrib:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: maghribTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Isha:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: ishaTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Imsak:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: imsakTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Midnight:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: midnightTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Firstthird:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: firstthirdTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: "Lastthird:"
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }

                        Text {
                            text: lastthirdTime
                            font.pointSize: Math.max(18, stackView.height / 40)
                            color: "white"
                        }
                    }
                }

                Button {
                    text: qsTr("Settings")
                    anchors {
                        right: parent.right
                        rightMargin: parent.width * 0.05
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.05
                    }
                    onClicked: stackView.push(settingsPage)
                }

                Button {
                    text: qsTr("About")
                    anchors {
                        left: parent.left
                        leftMargin: parent.width * 0.05
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.05
                    }
                    onClicked: emptyDrawer.open()
                }

                Button {
                    text: qsTr("Missed Prayers")
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.05
                    }
                    onClicked: stackView.push(missedPrayersPage)
                }

                Component.onCompleted: {
                    loadSettings()
                    fetchPrayerTimings()
                }
            }
        }

        Component {
            id: settingsPage
            Rectangle {
                color: "#2a2e32"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Text {
                        text: qsTr("Settings")
                        font.pointSize: Math.max(24, stackView.height / 20)
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    GridLayout {
                        columns: 2
                        rowSpacing: 10
                        columnSpacing: 20
                        Layout.fillWidth: true

                        Text {
                            text: qsTr("Clock Format")
                            color: "white"
                            font.pointSize: Math.max(18, stackView.height / 40)
                        }

                        ComboBox {
                            id: settingsClockFormatSelector
                            model: [ "12-hour", "24-hour" ]
                            currentIndex: settingsClockFormatSelector.model.indexOf(tempClockFormat)
                            onCurrentTextChanged: {
                                tempClockFormat = settingsClockFormatSelector.currentText
                            }
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("Timezone")
                            color: "white"
                            font.pointSize: Math.max(18, stackView.height / 40)
                        }

                        ComboBox {
                            id: settingsTimezoneSelector
                            model: timezones.map(tz => tz.text)
                            currentIndex: timezones.map(tz => tz.text).indexOf(tempTimezone)
                            onCurrentTextChanged: {
                                tempTimezone = settingsTimezoneSelector.currentText
                                var timezoneData = timezones.find(tz => tz.text === tempTimezone)
                                if (timezoneData) {
                                    settingsCitySelector.model = timezoneData.cities
                                    settingsCitySelector.currentIndex = timezoneData.cities.indexOf(tempCity)
                                    tempCity = timezoneData.cities[settingsCitySelector.currentIndex]
                                    tempUtc = timezoneData.utc[0]
                                    tempUtcOffset = timezoneData.offset
                                }
                            }
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("City")
                            color: "white"
                            font.pointSize: Math.max(18, stackView.height / 40)
                        }

                        ComboBox {
                            id: settingsCitySelector
                            model: timezones.find(tz => tz.text === tempTimezone).cities
                            currentIndex: timezones.find(tz => tz.text === tempTimezone).cities.indexOf(tempCity)
                            onCurrentTextChanged: {
                                tempCity = settingsCitySelector.currentText
                            }
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr("Method")
                            color: "white"
                            font.pointSize: Math.max(18, stackView.height / 40)
                        }

                        ComboBox {
                            id: settingsMethodSelector
                            model: [
                                "University of Islamic Sciences, Karachi",
                                "Islamic Society of North America (ISNA)",
                                "Muslim World League",
                                "Umm Al-Qura University, Makkah",
                                "Egyptian General Authority of Survey",
                                "Islamic Society of North America (ISNA)",
                                "Institute of Geophysics, University of Tehran",
                                "Gulf Region",
                                "Kuwait",
                                "Qatar",
                                "Majlis Ugama Islam Singapura, Singapore",
                                "Union Organization Islamic de France",
                                "Diyanet İşleri Başkanlığı, Turkey (experimental)",
                                "Spiritual Administration of Muslims of Russia",
                                "Moonsighting Committee Worldwide (Moonsighting.com)",
                                "Dubai (experimental)",
                                "Jabatan Kemajuan Islam Malaysia (JAKIM)",
                                "Tunisia",
                                "Algeria",
                                "Kementerian Agama Republik Indonesia",
                                "Morocco",
                                "Comunidade Islamica de Lisboa",
                                "Ministry of Awqaf, Islamic Affairs and Holy Places, Jordan"
                            ]
                            currentIndex: tempMethod - 1
                            onCurrentIndexChanged: {
                                tempMethod = settingsMethodSelector.currentIndex + 1
                            }
                            Layout.fillWidth: true
                        }
                    }
                }
                RowLayout {
                    anchors {
                        right: parent.right
                        rightMargin: parent.width * 0.05
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.05
                    }
                    Button {
                        text: qsTr("Save Changes")
                        onClicked: {
                            saveSettings()
                            stackView.pop()
                        }
                    }

                    Button {
                        text: qsTr("Back")
                        onClicked: {
                            stackView.pop()
                        }
                    }
                }
            }
        }

        Component {
            id: missedPrayersPage
            Rectangle {
                color: "#2a2e32"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Text {
                        text: qsTr("Missed Prayers")
                        font.pointSize: Math.max(24, stackView.height / 20)
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Repeater {
                            model: missedPrayersModel

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 10

                                Text {
                                    text: model.prayerName
                                    font.pointSize: Math.max(18, stackView.height / 30)
                                    color: "white"
                                    Layout.fillWidth: true
                                }

                                RowLayout {
                                    spacing: 20
                                    Button {
                                        text: "-"
                                        onClicked: {
                                            if (model.prayerCount > 0) {
                                                model.prayerCount -= 1
                                            }
                                        }
                                    }

                                    Text {
                                        text: model.prayerCount
                                        font.pointSize: Math.max(18, stackView.height / 30)
                                        color: "white"
                                        Layout.alignment: Qt.AlignHCenter
                                    }

                                    Button {
                                        text: "+"
                                        onClicked: {
                                            model.prayerCount += 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Button {
                    text: qsTr("Back")
                    anchors {
                        right: parent.right
                        rightMargin: parent.width * 0.05
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.05
                    }
                    onClicked: stackView.pop()
                }
            }
        }

        ListModel {
            id: missedPrayersModel
            ListElement { prayerName: "Fajr"; prayerCount: 0 }
            ListElement { prayerName: "Dhuhr"; prayerCount: 0 }
            ListElement { prayerName: "Asr"; prayerCount: 0 }
            ListElement { prayerName: "Maghrib"; prayerCount: 0 }
            ListElement { prayerName: "Isha"; prayerCount: 0 }
        }
    }
}
