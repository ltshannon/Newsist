//
//  CovidCountries.swift
//  Newsist
//
//  Created by Larry Shannon on 3/23/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import UIKit

let countries = [
    "Andorra",
    "United Arab Emirates",
    "Afghanistan",
    "Antigua and Barbuda",
    "Anguilla",
    "Albania",
    "Armenia",
    "Angola",
    "Antarctica",
    "Argentina",
    "American Samoa",
    "Austria",
    "Australia",
    "Aruba",
    "Åland Islands",
    "Azerbaijan",
    "Bosnia and Herzegovina",
    "Barbados",
    "Bangladesh",
    "Belgium",
    "Burkina Faso",
    "Bulgaria",
    "Bahrain",
    "Burundi",
    "Benin",
    "Saint Barthélemy",
    "Bermuda",
    "Brunei",
    "Bolivia",
    "Bonaire, Sint Eustatius and Saba",
    "Brazil",
    "Bahamas",
    "Bhutan",
    "Bouvet Island",
    "Botswana",
    "Belarus",
    "Belize",
    "Canada",
    "Cocos (Keeling) Islands",
    "Congo (Kinshasa)",
    "Central African Republic",
    "Congo",
    "Switzerland",
    "Cote d'Ivoire",
    "Cook Islands",
    "Chile",
    "Cameroon",
    "China",
    "Colombia",
    "Costa Rica",
    "Cuba",
    "Cape Verde",
    "Curaçao",
    "Christmas Island",
    "Cyprus",
    "Czechia",
    "Germany",
    "Djibouti",
    "Denmark",
    "Dominica",
    "Dominican Republic",
    "Cruise Ship",
    "Algeria",
    "Ecuador",
    "Estonia",
    "Egypt",
    "Western Sahara",
    "Eritrea",
    "Spain",
    "Ethiopia",
    "European Union",
    "Finland",
    "Fiji",
    "Falkland Islands (Malvinas)",
    "Micronesia",
    "Faroe Islands",
    "France",
    "Gabon",
    "United Kingdom",
    "Grenada",
    "Georgia",
    "French Guiana",
    "Guernsey",
    "Ghana",
    "Gibraltar",
    "Greenland",
    "Gambia",
    "Guinea",
    "Guadeloupe",
    "Equatorial Guinea",
    "Greece",
    "South Georgia",
    "Guatemala",
    "Guam",
    "Guinea-Bissau",
    "Guyana",
    "Hong Kong",
    "Heard Island and Mcdonald Islands",
    "Honduras",
    "Croatia",
    "Haiti",
    "Hungary",
    "Indonesia",
    "Ireland",
    "Israel",
    "Isle of Man",
    "India",
    "British Indian Ocean Territory",
    "Iraq",
    "Iran",
    "Iceland",
    "Italy",
    "Jersey",
    "Jamaica",
    "Jordan",
    "Japan",
    "Kenya",
    "Kyrgyzstan",
    "Cambodia",
    "Kiribati",
    "Comoros",
    "Saint Kitts and Nevis",
    "North Korea",
    "Korea, South",
    "Kuwait",
    "Cayman Islands",
    "Kazakhstan",
    "Lao People's Democratic Republic",
    "Lebanon",
    "Saint Lucia",
    "Liechtenstein",
    "Sri Lanka",
    "Liberia",
    "Lesotho",
    "Lithuania",
    "Luxembourg",
    "Latvia",
    "Libya",
    "Morocco",
    "Monaco",
    "Moldova",
    "Montenegro",
    "Saint Martin (French Part)",
    "Madagascar",
    "Marshall Islands",
    "North Macedonia",
    "Mali",
    "Myanma",
    "Mongolia",
    "Macao",
    "Northern Mariana Islands",
    "Martinique",
    "Mauritania",
    "Montserrat",
    "Malta",
    "Mauritius",
    "Maldives",
    "Malawi",
    "Mexico",
    "Malaysia",
    "Mozambique",
    "Namibia",
    "New Caledonia",
    "Niger",
    "Norfolk Island",
    "Nigeria",
    "Nicaragua",
    "Netherlands",
    "Norway",
    "Nepal",
    "Nauru",
    "Niue",
    "New Zealand",
    "Oman",
    "Panama",
    "Peru",
    "French Polynesia",
    "Papua New Guinea",
    "Philippines",
    "Pakistan",
    "Poland",
    "Saint Pierre and Miquelon",
    "Pitcairn",
    "Puerto Rico",
    "Palestinian Territory",
    "Portugal",
    "Palau",
    "Paraguay",
    "Qatar",
    "Réunion",
    "Romania",
    "Serbia",
    "Russia",
    "Rwanda",
    "Saudi Arabia",
    "Solomon Islands",
    "Seychelles",
    "Sudan",
    "Sweden",
    "Singapore",
    "Saint Helena, Ascension and Tristan Da Cunha",
    "Slovenia",
    "Svalbard and Jan Mayen",
    "Slovakia",
    "Sierra Leone",
    "San Marino",
    "Senegal",
    "Somalia",
    "Suriname",
    "South Sudan",
    "Sao Tome and Principe",
    "El Salvador",
    "Sint Maarten (Dutch Part)",
    "Syrian Arab Republic",
    "Swaziland",
    "Turks and Caicos Islands",
    "Chad",
    "French Southern Territories",
    "Togo",
    "Thailand",
    "Tajikistan",
    "Tokelau",
    "Timor-Leste",
    "Turkmenistan",
    "Tunisia",
    "Tonga",
    "Turkey",
    "Trinidad and Tobago",
    "Tuvalu",
    "Taiwan*",
    "Tanzania",
    "Ukraine",
    "Uganda",
    "United States Minor Outlying Islands",
    "US",
    "Uruguay",
    "Uzbekistan",
    "Holy See",
    "Saint Vincent and The Grenadines",
    "Venezuela",
    "Virgin Islands, British",
    "Virgin Islands, U.S.",
    "Vietnam",
    "Vanuatu",
    "Wallis and Futuna",
    "Samoa",
    "Kosovo",
    "Yemen",
    "Mayotte",
    "South Africa",
    "Zambia",
    "Zimbabwe"
]

struct CovidCountries: Decodable {
    let US: [CovidData]?
    let Thailand: [CovidData]?
    let Andorra: [CovidData]?
    let Afghanistan: [CovidData]?
    let AntiguaandBarbuda: [CovidData]?
    let Anguilla: [CovidData]?
    let Albania: [CovidData]?
    let Armenia: [CovidData]?
    let Angola: [CovidData]?
    let Antarctica: [CovidData]?
    let Argentina: [CovidData]?
    let AmericanSamoa: [CovidData]?
    let Austria: [CovidData]?
    let Australia: [CovidData]?
    let Aruba: [CovidData]?
    let AlandIslands: [CovidData]?
    let Azerbaijan: [CovidData]?
    let BosniaandHerzegovina: [CovidData]?
    let Barbados: [CovidData]?
    let Bangladesh: [CovidData]?
    let Belgium: [CovidData]?
    let BurkinaFaso: [CovidData]?
    let Bulgaria: [CovidData]?
    let Bahrain: [CovidData]?
    let Burundi: [CovidData]?
    let Benin: [CovidData]?
    let SaintBarthelemy: [CovidData]?
    let Bermuda: [CovidData]?
    let Brunei: [CovidData]?
    let Bolivia: [CovidData]?
    let BonaireSintEustatiusandSaba: [CovidData]?
    let Brazil: [CovidData]?
    let Bahamas: [CovidData]?
    let Bhutan: [CovidData]?
    let BouvetIsland: [CovidData]?
    let Botswana: [CovidData]?
    let Belarus: [CovidData]?
    let Belize: [CovidData]?
    let Canada: [CovidData]?
    let CocosKeelingIslands: [CovidData]?
    let CongoKinshasa: [CovidData]?
    let CentralAfricanRepublic: [CovidData]?
    let Congo: [CovidData]?
    let Switzerland: [CovidData]?
    let CotedIvoire: [CovidData]?
    let CookIslands: [CovidData]?
    let Chile: [CovidData]?
    let Cameroon: [CovidData]?
    let China: [CovidData]?
    let Colombia: [CovidData]?
    let CostaRica: [CovidData]?
    let Cuba: [CovidData]?
    let CapeVerde: [CovidData]?
    let Curaçao: [CovidData]?
    let ChristmasIsland: [CovidData]?
    let Cyprus: [CovidData]?
    let Czechia: [CovidData]?
    let Germany: [CovidData]?
    let Djibouti: [CovidData]?
    let Denmark: [CovidData]?
    let Dominica: [CovidData]?
    let DominicanRepublic: [CovidData]?
    let CruiseShip: [CovidData]?
    let Algeria: [CovidData]?
    let Ecuador: [CovidData]?
    let Estonia: [CovidData]?
    let Egypt: [CovidData]?
    let WesternSahara: [CovidData]?
    let Eritrea: [CovidData]?
    let Spain: [CovidData]?
    let Ethiopia: [CovidData]?
    let EuropeanUnion: [CovidData]?
    let Finland: [CovidData]?
    let Fiji: [CovidData]?
    let FalklandIslandsMalvinas: [CovidData]?
    let Micronesia: [CovidData]?
    let FaroeIslands: [CovidData]?
    let France: [CovidData]?
    let Gabon: [CovidData]?
    let UnitedKingdom: [CovidData]?
    let Grenada: [CovidData]?
    let Georgia: [CovidData]?
    let FrenchGuiana: [CovidData]?
    let Guernsey: [CovidData]?
    let Ghana: [CovidData]?
    let Gibraltar: [CovidData]?
    let Greenland: [CovidData]?
    let Gambia: [CovidData]?
    let Guinea: [CovidData]?
    let Guadeloupe: [CovidData]?
    let EquatorialGuinea: [CovidData]?
    let Greece: [CovidData]?
    let SouthGeorgia: [CovidData]?
    let Guatemala: [CovidData]?
    let Guam: [CovidData]?
    let GuineaBissau: [CovidData]?
    let Guyana: [CovidData]?
    let HongKong: [CovidData]?
    let HeardIslandandMcdonaldIslands: [CovidData]?
    let Honduras: [CovidData]?
    let Croatia: [CovidData]?
    let Haiti: [CovidData]?
    let Hungary: [CovidData]?
    let Indonesia: [CovidData]?
    let Ireland: [CovidData]?
    let Israel: [CovidData]?
    let IsleofMan: [CovidData]?
    let India: [CovidData]?
    let BritishIndianOceanTerritory: [CovidData]?
    let Iraq: [CovidData]?
    let Iran: [CovidData]?
    let Iceland: [CovidData]?
    let Italy: [CovidData]?
    let Jersey: [CovidData]?
    let Jamaica: [CovidData]?
    let Jordan: [CovidData]?
    let Japan: [CovidData]?
    let Kenya: [CovidData]?
    let Kyrgyzstan: [CovidData]?
    let Cambodia: [CovidData]?
    let Kiribati: [CovidData]?
    let Comoros: [CovidData]?
    let SaintKittsandNevis: [CovidData]?
    let NorthKorea: [CovidData]?
    let KoreaSouth: [CovidData]?
    let Kuwait: [CovidData]?
    let CaymanIslands: [CovidData]?
    let Kazakhstan: [CovidData]?
    let LaoPeoplesDemocraticRepublic: [CovidData]?
    let Lebanon: [CovidData]?
    let SaintLucia: [CovidData]?
    let Liechtenstein: [CovidData]?
    let SriLanka: [CovidData]?
    let Liberia: [CovidData]?
    let Lesotho: [CovidData]?
    let Lithuania: [CovidData]?
    let Luxembourg: [CovidData]?
    let Latvia: [CovidData]?
    let Libya: [CovidData]?
    let Morocco: [CovidData]?
    let Monaco: [CovidData]?
    let Moldova: [CovidData]?
    let Montenegro: [CovidData]?
    let SaintMartinFrenchPart: [CovidData]?
    let Madagascar: [CovidData]?
    let MarshallIslands: [CovidData]?
    let NorthMacedonia: [CovidData]?
    let Mali: [CovidData]?
    let Myanma: [CovidData]?
    let Mongolia: [CovidData]?
    let Macao: [CovidData]?
    let NorthernMarianaIslands: [CovidData]?
    let Martinique: [CovidData]?
    let Mauritania: [CovidData]?
    let Montserrat: [CovidData]?
    let Malta: [CovidData]?
    let Mauritius: [CovidData]?
    let Maldives: [CovidData]?
    let Malawi: [CovidData]?
    let Mexico: [CovidData]?
    let Malaysia: [CovidData]?
    let Mozambique: [CovidData]?
    let Namibia: [CovidData]?
    let NewCaledonia: [CovidData]?
    let Niger: [CovidData]?
    let NorfolkIsland: [CovidData]?
    let Nigeria: [CovidData]?
    let Nicaragua: [CovidData]?
    let Netherlands: [CovidData]?
    let Norway: [CovidData]?
    let Nepal: [CovidData]?
    let Nauru: [CovidData]?
    let Niue: [CovidData]?
    let NewZealand: [CovidData]?
    let Oman: [CovidData]?
    let Panama: [CovidData]?
    let Peru: [CovidData]?
    let FrenchPolynesia: [CovidData]?
    let PapuaNewGuinea: [CovidData]?
    let Philippines: [CovidData]?
    let Pakistan: [CovidData]?
    let Poland: [CovidData]?
    let SaintPierreandMiquelon: [CovidData]?
    let Pitcairn: [CovidData]?
    let PuertoRico: [CovidData]?
    let PalestinianTerritory: [CovidData]?
    let Portugal: [CovidData]?
    let Palau: [CovidData]?
    let Paraguay: [CovidData]?
    let Qatar: [CovidData]?
    let Reunion: [CovidData]?
    let Romania: [CovidData]?
    let Serbia: [CovidData]?
    let Russia: [CovidData]?
    let Rwanda: [CovidData]?
    let SaudiArabia: [CovidData]?
    let SolomonIslands: [CovidData]?
    let Seychelles: [CovidData]?
    let Sudan: [CovidData]?
    let Sweden: [CovidData]?
    let Singapore: [CovidData]?
    let SaintHelenaAscensionandTristanDaCunha: [CovidData]?
    let Slovenia: [CovidData]?
    let SvalbardandJanMayen: [CovidData]?
    let Slovakia: [CovidData]?
    let SierraLeone: [CovidData]?
    let SanMarino: [CovidData]?
    let Senegal: [CovidData]?
    let Somalia: [CovidData]?
    let Suriname: [CovidData]?
    let SouthSudan: [CovidData]?
    let SaoTomeandPrincipe: [CovidData]?
    let ElSalvador: [CovidData]?
    let SintMaartenDutchPart: [CovidData]?
    let SyrianArabRepublic: [CovidData]?
    let Swaziland: [CovidData]?
    let TurksandCaicosIslands: [CovidData]?
    let Chad: [CovidData]?
    let FrenchSouthernTerritories: [CovidData]?
    let Togo: [CovidData]?
    let Tajikistan: [CovidData]?
    let Tokelau: [CovidData]?
    let TimorLeste: [CovidData]?
    let Turkmenistan: [CovidData]?
    let Tunisia: [CovidData]?
    let Tonga: [CovidData]?
    let Turkey: [CovidData]?
    let TrinidadandTobago: [CovidData]?
    let Tuvalu: [CovidData]?
    let Taiwan: [CovidData]?
    let Tanzania: [CovidData]?
    let Ukraine: [CovidData]?
    let Uganda: [CovidData]?
    let UnitedStatesMinorOutlyingIslands: [CovidData]?
    let Uruguay: [CovidData]?
    let Uzbekistan: [CovidData]?
    let HolySee: [CovidData]?
    let SaintVincentandTheGrenadines: [CovidData]?
    let Venezuela: [CovidData]?
    let VirginIslandsBritish: [CovidData]?
    let VirginIslandsUS: [CovidData]?
    let Vietnam: [CovidData]?
    let Vanuatu: [CovidData]?
    let WallisandFutuna: [CovidData]?
    let Samoa: [CovidData]?
    let Kosovo: [CovidData]?
    let Yemen: [CovidData]?
    let Mayotte: [CovidData]?
    let SouthAfrica: [CovidData]?
    let Zambia: [CovidData]?
    let Zimbabwe: [CovidData]?
    let UnitedArabEmirates: [CovidData]?

    enum CodingKeys : String, CodingKey {
        case US
        case Thailand
        case Andorra
        case Afghanistan
        case AntiguaandBarbuda = "Antigua and Barbuda"
        case Anguilla
        case Albania
        case Armenia
        case Angola
        case Antarctica
        case Argentina
        case AmericanSamoa = "American Samoa"
        case Austria
        case Australia
        case Aruba
        case AlandIslands = "Aland Islands"
        case Azerbaijan
        case BosniaandHerzegovina = "Bosnia and Herzegovina"
        case Barbados
        case Bangladesh
        case Belgium
        case BurkinaFaso = "Burkina Faso"
        case Bulgaria
        case Bahrain
        case Burundi
        case Benin
        case SaintBarthelemy = "Saint Barthélemy"
        case Bermuda
        case Brunei
        case Bolivia
        case BonaireSintEustatiusandSaba = "Bonaire, Sint Eustatius and Saba"
        case Brazil
        case Bahamas
        case Bhutan
        case BouvetIsland
        case Botswana
        case Belarus
        case Belize
        case Canada
        case CocosKeelingIslands = "Cocos (Keeling) Islands"
        case CongoKinshasa = "Congo (Kinshasa)"
        case CentralAfricanRepublic = "Central African Republic"
        case Congo
        case Switzerland
        case CotedIvoire = "Cote d'Ivoire"
        case CookIslands = "Cook Islands"
        case Chile
        case Cameroon
        case China
        case Colombia
        case CostaRica = "Costa Rica"
        case Cuba
        case CapeVerde = "Cape Verde"
        case Curaçao
        case ChristmasIsland = "Christmas Island"
        case Cyprus
        case Czechia
        case Germany
        case Djibouti
        case Denmark
        case Dominica
        case DominicanRepublic = "Dominican Republic"
        case CruiseShip = "Cruise Ship"
        case Algeria
        case Ecuador
        case Estonia
        case Egypt
        case WesternSahara = "Western Sahara"
        case Eritrea
        case Spain
        case Ethiopia
        case EuropeanUnion = "European Union"
        case Finland
        case Fiji
        case FalklandIslandsMalvinas = "Falkland Islands (Malvinas)"
        case Micronesia
        case FaroeIslands = "Faroe Islands"
        case France
        case Gabon
        case UnitedKingdom = "United Kingdom"
        case Grenada
        case Georgia
        case FrenchGuiana = "French Guiana"
        case Guernsey
        case Ghana
        case Gibraltar
        case Greenland
        case Gambia
        case Guinea
        case Guadeloupe
        case EquatorialGuinea = "Equatorial Guinea"
        case Greece
        case SouthGeorgia = "South Georgia"
        case Guatemala
        case Guam
        case GuineaBissau = "Guinea-Bissau"
        case Guyana
        case HongKong = "Hong Kong"
        case HeardIslandandMcdonaldIslands = "Heard Island and Mcdonald Islands"
        case Honduras
        case Croatia
        case Haiti
        case Hungary
        case Indonesia
        case Ireland
        case Israel
        case IsleofMan = "Isle of Man"
        case India
        case BritishIndianOceanTerritory = "British Indian Ocean Territory"
        case Iraq
        case Iran
        case Iceland
        case Italy
        case Jersey
        case Jamaica
        case Jordan
        case Japan
        case Kenya
        case Kyrgyzstan
        case Cambodia
        case Kiribati
        case Comoros
        case SaintKittsandNevis = "Saint Kitts and Nevis"
        case NorthKorea = "North Korea"
        case KoreaSouth = "Korea, South"
        case Kuwait
        case CaymanIslands = "Cayman Islands"
        case Kazakhstan
        case LaoPeoplesDemocraticRepublic = "Lao People's Democratic Republic"
        case Lebanon
        case SaintLucia = "Saint Lucia"
        case Liechtenstein
        case SriLanka = "Sri Lanka"
        case Liberia
        case Lesotho
        case Lithuania
        case Luxembourg
        case Latvia
        case Libya
        case Morocco
        case Monaco
        case Moldova
        case Montenegro
        case SaintMartinFrenchPart = "Saint Martin (French Part)"
        case Madagascar
        case MarshallIslands = "Marshall Islands"
        case NorthMacedonia = "North Macedonia"
        case Mali
        case Myanma
        case Mongolia
        case Macao
        case NorthernMarianaIslands = "Northern Mariana Islands"
        case Martinique
        case Mauritania
        case Montserrat
        case Malta
        case Mauritius
        case Maldives
        case Malawi
        case Mexico
        case Malaysia
        case Mozambique
        case Namibia
        case NewCaledonia = "New Caledonia"
        case Niger
        case NorfolkIsland = "Norfolk Island"
        case Nigeria
        case Nicaragua
        case Netherlands
        case Norway
        case Nepal
        case Nauru
        case Niue
        case NewZealand = "New Zealand"
        case Oman
        case Panama
        case Peru
        case FrenchPolynesia = "French Polynesia"
        case PapuaNewGuinea = "Papua New Guinea"
        case Philippines
        case Pakistan
        case Poland
        case SaintPierreandMiquelon = "Saint Pierre and Miquelon"
        case Pitcairn
        case PuertoRico = "Puerto Rico"
        case PalestinianTerritory = "Palestinian Territory"
        case Portugal
        case Palau
        case Paraguay
        case Qatar
        case Reunion
        case Romania
        case Serbia
        case Russia
        case Rwanda
        case SaudiArabia = "Saudi Arabia"
        case SolomonIslands = "Solomon Islands"
        case Seychelles
        case Sudan
        case Sweden
        case Singapore
        case SaintHelenaAscensionandTristanDaCunha = "Helena, Ascension and Tristan Da Cunha"
        case Slovenia
        case SvalbardandJanMayen = "Svalbard and Jan Mayen"
        case Slovakia
        case SierraLeone = "Sierra Leone"
        case SanMarino = "San Marino"
        case Senegal
        case Somalia
        case Suriname
        case SouthSudan = "South Sudan"
        case SaoTomeandPrincipe = "Sao Tome and Principe"
        case ElSalvador = "El Salvador"
        case SintMaartenDutchPart = "Sint Maarten (Dutch Part)"
        case SyrianArabRepublic = "Syrian Arab Republic"
        case Swaziland
        case TurksandCaicosIslands = "Turks and Caicos Islands"
        case Chad
        case FrenchSouthernTerritories = "French Southern Territories"
        case Togo
        case Tajikistan
        case Tokelau
        case TimorLeste = "Timor-Leste"
        case Turkmenistan
        case Tunisia
        case Tonga
        case Turkey
        case TrinidadandTobago = "Trinidad and Tobago"
        case Tuvalu
        case Taiwan = "Taiwan*"
        case Tanzania
        case Ukraine
        case Uganda
        case UnitedStatesMinorOutlyingIslands = "United States Minor Outlying Islands"
        case Uruguay
        case Uzbekistan
        case HolySee = "Holy See"
        case SaintVincentandTheGrenadines = "Saint Vincent and The Grenadines"
        case Venezuela
        case VirginIslandsBritish = "Virgin Islands, British"
        case VirginIslandsUS = "Virgin Islands, U.S."
        case Vietnam
        case Vanuatu
        case WallisandFutuna = "Wallis and Futuna"
        case Samoa
        case Kosovo
        case Yemen
        case Mayotte
        case SouthAfrica = "South Africa"
        case Zambia
        case Zimbabwe
        case UnitedArabEmirates = "United Arab Emirates"

    }
}

struct CovidData: Decodable, Hashable {
    let date: String?
    let confirmed: Int?
    let deaths: Int?
    let recovered: Int?
    
    init(date: String, confirmed: Int, deaths: Int, recovered: Int) {
        self.date = date
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
    }
}
