//
//  CoronaVirusView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/23/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

class CovidViewModel: ObservableObject {
    @Published var dataSet: [String: [CovidData]] = [:]
    
    
    init() {
        
        let urlString = "Https://pomber.github.io/covid19/timeseries.json"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
        
            do {
                let data = try JSONDecoder().decode(CovidCountries.self, from: data)

                var tempDataSet: [String: [CovidData]] = [:]
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd"
                df.locale = Locale(identifier: "en_US_POSIX")
                df.timeZone = TimeZone(identifier: "UTC")!
                
                for country in countries {

                    var dataCovid: [CovidData]
                    
                    switch country {
                    case "Andorra":
                        dataCovid = data.Andorra != nil ? data.Andorra! : []
                    case "United Arab Emirates":
                        dataCovid = data.UnitedArabEmirates != nil ? data.UnitedArabEmirates! : []
                    case "Afghanistan":
                        dataCovid = data.Afghanistan != nil ? data.Afghanistan! : []
                    case "Antigua and Barbuda":
                        dataCovid = data.AntiguaandBarbuda != nil ? data.AntiguaandBarbuda! : []
                    case "Anguilla":
                        dataCovid = data.Anguilla != nil ? data.Anguilla! : []
                    case "Albania":
                        dataCovid = data.Albania != nil ? data.Albania! : []
                    case "Armenia":
                        dataCovid = data.Armenia != nil ? data.Armenia! : []
                    case "Angola":
                        dataCovid = data.Angola != nil ? data.Angola! : []
                    case "Antarctica":
                        dataCovid = data.Antarctica != nil ? data.Antarctica! : []
                    case "Argentina":
                        dataCovid = data.Argentina != nil ? data.Argentina! : []
                    case "American Samoa":
                        dataCovid = data.AmericanSamoa != nil ? data.AmericanSamoa! : []
                    case "Austria":
                        dataCovid = data.Austria != nil ? data.Austria! : []
                    case "Australia":
                        dataCovid = data.Australia != nil ? data.Australia! : []
                    case "Aruba":
                        dataCovid = data.Aruba != nil ? data.Aruba! : []
                    case "Åland Islands":
                        dataCovid = data.AlandIslands != nil ? data.AlandIslands! : []
                    case "Azerbaijan":
                        dataCovid = data.Azerbaijan != nil ? data.Azerbaijan! : []
                    case "Bosnia and Herzegovina":
                        dataCovid = data.BosniaandHerzegovina != nil ? data.BosniaandHerzegovina! : []
                    case "Barbados":
                        dataCovid = data.Barbados != nil ? data.Barbados! : []
                    case "Bangladesh":
                        dataCovid = data.Bangladesh != nil ? data.Bangladesh! : []
                    case "Belgium":
                        dataCovid = data.Belgium != nil ? data.Belgium! : []
                    case "Burkina Faso":
                        dataCovid = data.BurkinaFaso != nil ? data.BurkinaFaso! : []
                    case "Bulgaria":
                        dataCovid = data.Bulgaria != nil ? data.Bulgaria! : []
                    case "Bahrain":
                        dataCovid = data.Bahrain != nil ? data.Bahrain! : []
                    case "Burundi":
                        dataCovid = data.Burundi != nil ? data.Burundi! : []
                    case "Benin":
                        dataCovid = data.Benin != nil ? data.Benin! : []
                    case "Saint Barthélemy":
                        dataCovid = data.SaintBarthelemy != nil ? data.SaintBarthelemy! : []
                    case "Bermuda":
                        dataCovid = data.Bermuda != nil ? data.Bermuda! : []
                    case "Brunei":
                        dataCovid = data.Brunei != nil ? data.Brunei! : []
                    case "Bolivia":
                        dataCovid = data.Bolivia != nil ? data.Bolivia! : []
                    case "Bonaire, Sint Eustatius and Saba":
                        dataCovid = data.BonaireSintEustatiusandSaba != nil ? data.BonaireSintEustatiusandSaba! : []
                    case "Brazil":
                        dataCovid = data.Brazil != nil ? data.Brazil! : []
                    case "Bahamas":
                        dataCovid = data.Bahamas != nil ? data.Bahamas! : []
                    case "Bhutan":
                        dataCovid = data.Bhutan != nil ? data.Bhutan! : []
                    case "Bouvet Island":
                        dataCovid = data.BouvetIsland != nil ? data.BouvetIsland! : []
                    case "Botswana":
                        dataCovid = data.Botswana != nil ? data.Botswana! : []
                    case "Belarus":
                        dataCovid = data.Belarus != nil ? data.Belarus! : []
                    case "Belize":
                        dataCovid = data.Belize != nil ? data.Belize! : []
                    case "Canada":
                        dataCovid = data.Canada != nil ? data.Canada! : []
                    case "Cocos (Keeling) Islands":
                        dataCovid = data.CocosKeelingIslands != nil ? data.CocosKeelingIslands! : []
                    case "Congo (Kinshasa)":
                        dataCovid = data.CongoKinshasa != nil ? data.CongoKinshasa! : []
                    case "Central African Republic":
                        dataCovid = data.CentralAfricanRepublic != nil ? data.CentralAfricanRepublic! : []
                    case "Congo":
                        dataCovid = data.Congo != nil ? data.Congo! : []
                    case "Switzerland":
                        dataCovid = data.Switzerland != nil ? data.Switzerland! : []
                    case "Cote d'Ivoire":
                        dataCovid = data.CotedIvoire != nil ? data.CotedIvoire! : []
                    case "Cook Islands":
                        dataCovid = data.CookIslands != nil ? data.CookIslands! : []
                    case "Chile":
                        dataCovid = data.Chile != nil ? data.Chile! : []
                    case "Cameroon":
                        dataCovid = data.Cameroon != nil ? data.Cameroon! : []
                    case "China":
                        dataCovid = data.China != nil ? data.China! : []
                    case "Colombia":
                        dataCovid = data.Colombia != nil ? data.Colombia! : []
                    case "Costa Rica":
                        dataCovid = data.CostaRica != nil ? data.CostaRica! : []
                    case "Cuba":
                        dataCovid = data.Cuba != nil ? data.Cuba! : []
                    case "Cape Verde":
                        dataCovid = data.CapeVerde != nil ? data.CapeVerde! : []
                    case "Curaçao":
                        dataCovid = data.Curaçao != nil ? data.Curaçao! : []
                    case "Christmas Island":
                        dataCovid = data.ChristmasIsland != nil ? data.ChristmasIsland! : []
                    case "Cyprus":
                        dataCovid = data.Cyprus != nil ? data.Cyprus! : []
                    case "Czechia":
                        dataCovid = data.Czechia != nil ? data.Czechia! : []
                    case "Germany":
                        dataCovid = data.Germany != nil ? data.Germany! : []
                    case "Djibouti":
                        dataCovid = data.Djibouti != nil ? data.Djibouti! : []
                    case "Denmark":
                        dataCovid = data.Denmark != nil ? data.Denmark! : []
                    case "Dominica":
                        dataCovid = data.Dominica != nil ? data.Dominica! : []
                    case "Dominican Republic":
                        dataCovid = data.DominicanRepublic != nil ? data.DominicanRepublic! : []
                    case "Cruise Ship":
                        dataCovid = data.CruiseShip != nil ? data.CruiseShip! : []
                    case "Algeria":
                        dataCovid = data.Algeria != nil ? data.Algeria! : []
                    case "Ecuador":
                        dataCovid = data.Ecuador != nil ? data.Ecuador! : []
                    case "Estonia":
                        dataCovid = data.Estonia != nil ? data.Estonia! : []
                    case "Egypt":
                        dataCovid = data.Egypt != nil ? data.Egypt! : []
                    case "Western Sahara":
                        dataCovid = data.WesternSahara != nil ? data.WesternSahara! : []
                    case "Eritrea":
                        dataCovid = data.Eritrea != nil ? data.Eritrea! : []
                    case "Spain":
                        dataCovid = data.Spain != nil ? data.Spain! : []
                    case "Ethiopia":
                        dataCovid = data.Ethiopia != nil ? data.Ethiopia! : []
                    case "European Union":
                        dataCovid = data.EuropeanUnion != nil ? data.EuropeanUnion! : []
                    case "Finland":
                        dataCovid = data.Finland != nil ? data.Finland! : []
                    case "Fiji":
                        dataCovid = data.Fiji != nil ? data.Fiji! : []
                    case "Falkland Islands (Malvinas)":
                        dataCovid = data.FalklandIslandsMalvinas != nil ? data.FalklandIslandsMalvinas! : []
                    case "Micronesia":
                        dataCovid = data.Micronesia != nil ? data.Micronesia! : []
                    case "Faroe Islands":
                        dataCovid = data.FaroeIslands != nil ? data.FaroeIslands! : []
                    case "France":
                        dataCovid = data.France != nil ? data.France! : []
                    case "Gabon":
                        dataCovid = data.Gabon != nil ? data.Gabon! : []
                    case "United Kingdom":
                        dataCovid = data.UnitedKingdom != nil ? data.UnitedKingdom! : []
                    case "Grenada":
                        dataCovid = data.Grenada != nil ? data.Grenada! : []
                    case "Georgia":
                        dataCovid = data.Georgia != nil ? data.Georgia! : []
                    case "French Guiana":
                        dataCovid = data.Guinea != nil ? data.Guinea! : []
                    case "Guernsey":
                        dataCovid = data.Guernsey != nil ? data.Guernsey! : []
                    case "Ghana":
                        dataCovid = data.Ghana != nil ? data.Ghana! : []
                    case "Gibraltar":
                        dataCovid = data.Gibraltar != nil ? data.Gibraltar! : []
                    case "Greenland":
                        dataCovid = data.Greenland != nil ? data.Greenland! : []
                    case "Gambia":
                        dataCovid = data.Gambia != nil ? data.Gambia! : []
                    case "Guinea":
                        dataCovid = data.Guinea != nil ? data.Guinea! : []
                    case "Guadeloupe":
                        dataCovid = data.Guadeloupe != nil ? data.Guadeloupe! : []
                    case "Equatorial Guinea":
                        dataCovid = data.EquatorialGuinea != nil ? data.EquatorialGuinea! :[]
                    case "Greece":
                        dataCovid = data.Greece !=  nil ? data.Greece! : []
                    case "South Georgia":
                        dataCovid = data.Georgia != nil ? data.Georgia! : []
                    case "Guatemala":
                        dataCovid = data.Guatemala != nil ? data.Georgia! : []
                    case "Guam":
                        dataCovid = data.Guam != nil ? data.Guam! : []
                    case "Guinea-Bissau":
                        dataCovid = data.GuineaBissau != nil ? data.GuineaBissau! : []
                    case "Guyana":
                        dataCovid = data.Guyana != nil ? data.Guyana! : []
                    case "Hong Kong":
                        dataCovid = data.HongKong != nil ? data.HongKong! : []
                    case "Heard Island and Mcdonald Islands":
                        dataCovid = data.HeardIslandandMcdonaldIslands != nil ? data.HeardIslandandMcdonaldIslands! : []
                    case "Honduras":
                        dataCovid = data.Honduras != nil ? data.Honduras! : []
                    case "Croatia":
                        dataCovid = data.Croatia != nil ? data.Croatia! : []
                    case "Haiti":
                        dataCovid = data.Haiti != nil ? data.Haiti! : []
                    case "Hungary":
                        dataCovid = data.Hungary != nil ? data.Hungary! : []
                    case "Indonesia":
                        dataCovid = data.Indonesia != nil ? data.Indonesia! : []
                    case "Ireland":
                        dataCovid = data.Ireland != nil ? data.Ireland! : []
                    case "Israel":
                        dataCovid = data.Israel != nil ? data.Israel! : []
                    case "Isle of Man":
                        dataCovid = data.IsleofMan != nil ? data.IsleofMan! : []
                    case "India":
                        dataCovid = data.India != nil ? data.India! : []
                    case "British Indian Ocean Territory":
                        dataCovid = data.BritishIndianOceanTerritory != nil ? data.BritishIndianOceanTerritory! : []
                    case "Iraq":
                        dataCovid = data.Iraq != nil ? data.Iraq! : []
                    case "Iran":
                        dataCovid = data.Iran != nil ? data.Iran! : []
                    case "Iceland":
                        dataCovid = data.Iceland != nil ? data.Iceland! : []
                    case "Italy":
                        dataCovid = data.Italy != nil ? data.Italy! : []
                    case "Jersey":
                        dataCovid = data.Jersey != nil ? data.Jersey! : []
                    case "Jamaica":
                        dataCovid = data.Jamaica != nil ? data.Jamaica! : []
                    case "Jordan":
                        dataCovid = data.Jordan != nil ? data.Jordan! : []
                    case "Japan":
                        dataCovid = data.Japan != nil ? data.Japan! : []
                    case "Kenya":
                        dataCovid = data.Kenya != nil ? data.Kenya! : []
                    case "Kyrgyzstan":
                        dataCovid = data.Kyrgyzstan != nil ? data.Kyrgyzstan! : []
                    case "Cambodia":
                        dataCovid = data.Cambodia != nil ? data.Cambodia! : []
                    case "Kiribati":
                        dataCovid = data.Kiribati != nil ? data.Kiribati! : []
                    case "Comoros":
                        dataCovid = data.Comoros != nil ? data.Comoros! : []
                    case "Saint Kitts and Nevis":
                        dataCovid = data.SaintKittsandNevis != nil ? data.SaintKittsandNevis! : []
                    case "North Korea":
                        dataCovid = data.NorthKorea != nil ? data.NorthKorea! : []
                    case "Korea, South":
                        dataCovid = data.KoreaSouth != nil ? data.KoreaSouth! : []
                    case "Kuwait":
                        dataCovid = data.Kuwait != nil ? data.Kuwait! : []
                    case "Cayman Islands":
                        dataCovid = data.CaymanIslands != nil ? data.CaymanIslands! : []
                    case "Kazakhstan":
                        dataCovid = data.Kazakhstan != nil ? data.Kazakhstan! : []
                    case "Lao People's Democratic Republic":
                        dataCovid = data.LaoPeoplesDemocraticRepublic != nil ? data.LaoPeoplesDemocraticRepublic! : []
                    case "Lebanon":
                        dataCovid = data.Lebanon != nil ? data.Lebanon! : []
                    case "Saint Lucia":
                        dataCovid = data.SaintLucia != nil ? data.SaintLucia! : []
                    case "Liechtenstein":
                        dataCovid = data.Liechtenstein != nil ? data.Liechtenstein! : []
                    case "Sri Lanka":
                        dataCovid = data.SriLanka != nil ? data.SriLanka! : []
                    case "Liberia":
                        dataCovid = data.Liberia != nil ? data.Liberia! : []
                    case "Lesotho":
                        dataCovid = data.Lesotho != nil ? data.Lesotho! : []
                    case "Lithuania":
                        dataCovid = data.Lithuania != nil ? data.Lithuania! : []
                    case "Luxembourg":
                        dataCovid = data.Luxembourg != nil ? data.Luxembourg! : []
                    case "Latvia":
                        dataCovid = data.Latvia != nil ? data.Latvia! : []
                    case "Libya":
                        dataCovid = data.Libya != nil ? data.Libya! : []
                    case "Morocco":
                        dataCovid = data.Morocco != nil ? data.Morocco! : []
                    case "Monaco":
                        dataCovid = data.Monaco != nil ? data.Monaco! : []
                    case "Moldova":
                        dataCovid = data.Moldova != nil ? data.Moldova! : []
                    case "Montenegro":
                        dataCovid = data.Montenegro != nil ? data.Montenegro! : []
                    case "Saint Martin (French Part)":
                        dataCovid = data.SaintMartinFrenchPart != nil ? data.SaintMartinFrenchPart! : []
                    case "Madagascar":
                        dataCovid = data.Madagascar != nil ? data.Madagascar! : []
                    case "Marshall Islands":
                        dataCovid = data.MarshallIslands != nil ? data.MarshallIslands! : []
                    case "North Macedonia":
                        dataCovid = data.NorthMacedonia != nil ? data.NorthMacedonia! : []
                    case "Mali":
                        dataCovid = data.Mali != nil ? data.Mali! : []
                    case "Myanma":
                        dataCovid = data.Myanma != nil ? data.Myanma! : []
                    case "Mongolia":
                        dataCovid = data.Mongolia != nil ? data.Mongolia! : []
                    case "Macao":
                        dataCovid = data.Macao != nil ? data.Macao! : []
                    case "Northern Mariana Islands":
                        dataCovid = data.NorthernMarianaIslands != nil ? data.NorthernMarianaIslands! : []
                    case "Martinique":
                        dataCovid = data.Martinique != nil ? data.Martinique! : []
                    case "Mauritania":
                        dataCovid = data.Mauritania != nil ? data.Mauritania! : []
                    case "Montserrat":
                        dataCovid = data.Montserrat != nil ? data.Montserrat! : []
                    case "Malta":
                        dataCovid = data.Malta != nil ? data.Malta! : []
                    case "Mauritius":
                        dataCovid = data.Mauritius != nil ? data.Mauritius! : []
                    case "Maldives":
                        dataCovid = data.Maldives != nil ? data.Maldives! : []
                    case "Malawi":
                        dataCovid = data.Malawi != nil ? data.Malawi! : []
                    case "Mexico":
                        dataCovid = data.Mexico != nil ? data.Mexico! : []
                    case "Malaysia":
                        dataCovid = data.Malaysia != nil ? data.Malaysia! : []
                    case "Mozambique":
                        dataCovid = data.Mozambique != nil ? data.Mozambique! : []
                    case "Namibia":
                        dataCovid = data.Namibia != nil ? data.Namibia! : []
                    case "New Caledonia":
                        dataCovid = data.NewCaledonia != nil ? data.NewCaledonia! : []
                    case "Niger":
                        dataCovid = data.Niger != nil ? data.Niger! : []
                    case "Norfolk Island":
                        dataCovid = data.NorfolkIsland != nil ? data.NorfolkIsland! : []
                    case "Nigeria":
                        dataCovid = data.Niger != nil ? data.Niger! : []
                    case "Nicaragua":
                        dataCovid = data.Nicaragua != nil ? data.Nicaragua! : []
                    case "Netherlands":
                        dataCovid = data.Netherlands != nil ? data.Netherlands! : []
                    case "Norway":
                        dataCovid = data.Norway != nil ? data.Norway! : []
                    case "Nepal":
                        dataCovid = data.Nepal != nil ? data.Nepal! : []
                    case "Nauru":
                        dataCovid = data.Nauru != nil ? data.Nauru! : []
                    case "Niue":
                        dataCovid = data.Niue != nil ? data.Niue! : []
                    case "New Zealand":
                        dataCovid = data.NewZealand != nil ? data.NewZealand! : []
                    case "Oman":
                        dataCovid = data.Oman != nil ? data.Oman! : []
                    case "Panama":
                        dataCovid = data.Panama != nil ? data.Panama! : []
                    case "Peru":
                        dataCovid = data.Peru != nil ? data.Peru! : []
                    case "French Polynesia":
                        dataCovid = data.FrenchPolynesia != nil ? data.FrenchPolynesia! : []
                    case "Papua New Guinea":
                        dataCovid = data.PapuaNewGuinea != nil ? data.PapuaNewGuinea! : []
                    case "Philippines":
                        dataCovid = data.Philippines != nil ? data.Philippines! : []
                    case "Pakistan":
                        dataCovid = data.Pakistan != nil ? data.Pakistan! : []
                    case "Poland":
                        dataCovid = data.Poland != nil ? data.Poland! : []
                    case "Saint Pierre and Miquelon":
                        dataCovid = data.SaintPierreandMiquelon != nil ? data.SaintPierreandMiquelon! : []
                    case "Pitcairn":
                        dataCovid = data.Pitcairn != nil ? data.Pitcairn! : []
                    case "Puerto Rico":
                        dataCovid = data.PuertoRico != nil ? data.PuertoRico! : []
                    case "Palestinian Territory":
                        dataCovid = data.PalestinianTerritory != nil ? data.PalestinianTerritory! : []
                    case "Portugal":
                        dataCovid = data.Portugal != nil ? data.Portugal! : []
                    case "Palau":
                        dataCovid = data.Palau != nil ? data.Palau! : []
                    case "Paraguay":
                        dataCovid = data.Paraguay != nil ? data.Paraguay! : []
                    case "Qatar":
                        dataCovid = data.Qatar != nil ? data.Qatar! : []
                    case "Réunion":
                        dataCovid = data.Reunion != nil ? data.Reunion! : []
                    case "Romania":
                        dataCovid = data.Romania != nil ? data.Romania! : []
                    case "Serbia":
                        dataCovid = data.Serbia != nil ? data.Serbia! : []
                    case "Russia":
                        dataCovid = data.Russia != nil ? data.Russia! : []
                    case "Rwanda":
                        dataCovid = data.Rwanda != nil ? data.Rwanda! : []
                    case "Saudi Arabia":
                        dataCovid = data.SaudiArabia != nil ? data.SaudiArabia! : []
                    case "Solomon Islands":
                        dataCovid = data.SolomonIslands != nil ? data.SolomonIslands! : []
                    case "Seychelles":
                        dataCovid = data.Seychelles != nil ? data.Seychelles! : []
                    case "Sudan":
                        dataCovid = data.Sudan != nil ? data.Sudan! : []
                    case "Sweden":
                        dataCovid = data.Sweden != nil ? data.Sweden! : []
                    case "Singapore":
                        dataCovid = data.Singapore != nil ? data.Singapore! : []
                    case "Saint Helena, Ascension and Tristan Da Cunha":
                        dataCovid = data.SaintHelenaAscensionandTristanDaCunha != nil ? data.SaintHelenaAscensionandTristanDaCunha! : []
                    case "Slovenia":
                        dataCovid = data.Slovenia != nil ? data.Slovenia! : []
                    case "Svalbard and Jan Mayen":
                        dataCovid = data.SvalbardandJanMayen != nil ? data.SvalbardandJanMayen! : []
                    case "Slovakia":
                        dataCovid = data.Slovakia != nil ? data.Slovakia! : []
                    case "Sierra Leone":
                        dataCovid = data.SierraLeone != nil ? data.SierraLeone! : []
                    case "San Marino":
                        dataCovid = data.SanMarino != nil ? data.SanMarino! : []
                    case "Senegal":
                        dataCovid = data.Senegal != nil ? data.Senegal! : []
                    case "Somalia":
                        dataCovid = data.Somalia != nil ? data.Somalia! : []
                    case "Suriname":
                        dataCovid = data.Suriname != nil ? data.Suriname! : []
                    case "South Sudan":
                        dataCovid = data.SouthSudan != nil ? data.SouthSudan! : []
                    case "Sao Tome and Principe":
                        dataCovid = data.SaoTomeandPrincipe != nil ? data.SaoTomeandPrincipe! : []
                    case "El Salvador":
                        dataCovid = data.ElSalvador != nil ? data.ElSalvador! : []
                    case "Sint Maarten (Dutch Part)":
                        dataCovid = data.SintMaartenDutchPart != nil ? data.SintMaartenDutchPart! : []
                    case "Syrian Arab Republic":
                        dataCovid = data.SyrianArabRepublic != nil ? data.SyrianArabRepublic! : []
                    case "Swaziland":
                        dataCovid = data.Swaziland != nil ? data.Swaziland! : []
                    case "Turks and Caicos Islands":
                        dataCovid = data.TurksandCaicosIslands != nil ? data.TurksandCaicosIslands! : []
                    case "Chad":
                        dataCovid = data.Chad != nil ? data.Chad! : []
                    case "French Southern Territories":
                        dataCovid = data.FrenchSouthernTerritories != nil ? data.FrenchSouthernTerritories! : []
                    case "Togo":
                        dataCovid = data.Togo != nil ? data.Togo! : []
                    case "Thailand":
                        dataCovid = data.Thailand != nil ? data.Thailand! : []
                    case "Tajikistan":
                        dataCovid = data.Tajikistan != nil ? data.Tajikistan! : []
                    case "Tokelau":
                        dataCovid = data.Tokelau != nil ? data.Tokelau! : []
                    case "Timor-Leste":
                        dataCovid = data.TimorLeste != nil ? data.TimorLeste! : []
                    case "Turkmenistan":
                        dataCovid = data.Turkmenistan != nil ? data.Turkmenistan! : []
                    case "Tunisia":
                        dataCovid = data.Tunisia != nil ? data.Tunisia! : []
                    case "Tonga":
                        dataCovid = data.Tonga != nil ? data.Tonga! : []
                    case "Turkey":
                        dataCovid = data.Turkey != nil ? data.Turkey! : []
                    case "Trinidad and Tobago":
                        dataCovid = data.TrinidadandTobago != nil ? data.TrinidadandTobago! : []
                    case "Tuvalu":
                        dataCovid = data.Tuvalu != nil ? data.Tuvalu! : []
                    case "Taiwan*":
                        dataCovid = data.Taiwan != nil ? data.Taiwan! : []
                    case "Tanzania":
                        dataCovid = data.Tanzania != nil ? data.Tanzania! : []
                    case "Ukraine":
                        dataCovid = data.Ukraine != nil ? data.Ukraine! : []
                    case "Uganda":
                        dataCovid = data.Uganda != nil ? data.Uganda! : []
                    case "United States Minor Outlying Islands":
                        dataCovid = data.UnitedStatesMinorOutlyingIslands != nil ? data.UnitedStatesMinorOutlyingIslands! : []
                    case "US":
                        dataCovid = data.US != nil ? data.US! : []
                    case "Uruguay":
                        dataCovid = data.Uruguay != nil ? data.Uruguay! : []
                    case "Uzbekistan":
                        dataCovid = data.Uzbekistan != nil ? data.Uzbekistan! : []
                    case "Holy See":
                        dataCovid = data.HolySee != nil ? data.HolySee! : []
                    case "Saint Vincent and The Grenadines":
                        dataCovid = data.SaintVincentandTheGrenadines != nil ? data.SaintVincentandTheGrenadines! : []
                    case "Venezuela":
                        dataCovid = data.Venezuela != nil ? data.Venezuela! : []
                    case "Virgin Islands, British":
                        dataCovid = data.VirginIslandsBritish != nil ? data.VirginIslandsBritish! : []
                    case "Virgin Islands, U.S.":
                        dataCovid = data.VirginIslandsUS != nil ? data.VirginIslandsUS! : []
                    case "Vietnam":
                        dataCovid = data.Vietnam != nil ? data.Vietnam! : []
                    case "Vanuatu":
                        dataCovid = data.Vanuatu != nil ? data.Vanuatu! : []
                    case "Wallis and Futuna":
                        dataCovid = data.WallisandFutuna != nil ? data.WallisandFutuna! : []
                    case "Samoa":
                        dataCovid = data.Samoa != nil ? data.Samoa! : []
                    case "Kosovo":
                        dataCovid = data.Kosovo != nil ? data.Kosovo! : []
                    case "Yemen":
                        dataCovid = data.Yemen != nil ? data.Yemen! : []
                    case "Mayotte":
                        dataCovid = data.Mayotte != nil ? data.Mayotte! : []
                    case "South Africa":
                        dataCovid = data.SouthAfrica != nil ? data.SouthAfrica! : []
                    case "Zambia":
                        dataCovid = data.Zambia != nil ? data.Zambia! : []
                    case "Zimbabwe":
                        dataCovid = data.Zimbabwe != nil ? data.Zimbabwe! : []
                    default:
                        dataCovid = []
                    }
                    
                    var temp = [CovidData]()
                    
                    for item in dataCovid {
                        let date = item.date != nil ? item.date! : ""
                        let confirmed1 = item.confirmed != nil ? item.confirmed : 0
                        let deaths = item.deaths != nil ? item.deaths! : 0
                        let recovered = item.recovered != nil ? item.recovered! : 0
                        if confirmed1 != 0 || deaths != 0 || recovered != 0 {
                            let t = CovidData.init(date: date, confirmed: confirmed1!, deaths: deaths, recovered: recovered)
                            temp.append(t)
                        }
                    }
                    
                    temp.sort{df.date(from: $0.date!)! > df.date(from: $1.date!)!}
                    tempDataSet[country] = temp
                }
                
                DispatchQueue.main.async {
                    self.dataSet = tempDataSet
                }

            } catch {
                print("JSON Decode failed, error")
            }
        
        }.resume()
    }
    
}

struct CoronaVirusView: View {
    
    @ObservedObject var covidData = CovidViewModel()
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Text("Date")
                Spacer()
                Text("Confirmed")
                Spacer()
                Text("Deaths")
                Spacer()
                Text("Recovered")
                Spacer()
            }

            List {
                ForEach(covidData.dataSet["US"]!, id: \.self) { values in
                    HStack {
                        Text(values.date!)
                        Spacer()
                        Text("\(values.confirmed!)")
                        Spacer()
                        Text("\(values.deaths!)")
                        Spacer()
                        Text("\(values.recovered!)")
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("United States", displayMode: .inline)

        }
    }
}

struct CoronaVirusView_Previews: PreviewProvider {
    static var previews: some View {
        CoronaVirusView()
    }
}
