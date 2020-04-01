//
//  BNOViewModel.swift
//  Newsist
//
//  Created by Larry Shannon on 3/26/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI
import SwiftSoup

struct BNOData: Decodable, Hashable {
    let country: String
    let confirmed: Int
    let newCases: String
    let deaths: String
    let newDeaths: String
    let deathRate: String
    let seriousCritical: String
    let recovered: String
    let yesterdayConfirmed: String
    let yesterdayDeaths: String
    let href: String
    
    init(country: String, confirmed: Int, newCases: String, deaths: String, newDeaths: String, deathRate: String, seriousCritical: String, recovered: String, yesterdayConfirmed: String, yesterdayDeaths: String, href: String) {
        self.country = country
        self.confirmed = confirmed
        self.newCases = newCases
        self.deaths = deaths
        self.newDeaths = newDeaths
        self.deathRate = deathRate
        self.seriousCritical = seriousCritical
        self.recovered = recovered
        self.yesterdayConfirmed = yesterdayConfirmed
        self.yesterdayDeaths = yesterdayDeaths
        self.href = href
    }
}

class BNOViewModel: ObservableObject {
@Published var countryDataSet: [BNOData] = []
@Published var usaDataSet: [BNOData] = []

    var countryArray: [BNOData] = []
    var usaArray: [BNOData] = []
    var html: String = ""

    init() {
        
        fetchData()

    }
    
    func fetchData() {
        
        let urlString = "https://docs.google.com/spreadsheets/d/e/2PACX-1vR30F8lYP3jG7YOq8es0PBpJIE5yvRVZffOyaqC0GgMBN6yt0Q-NI8pxS7hd1F9dYXnowSC6zpZmW9D/pubhtml?gid=1902046093&amp;single=true&amp;widget=true&amp;headers=false&amp;range=A1:I68"
    
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            if let htmlContentString = String.init(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                do {
                    let doc : Document = try SwiftSoup.parse(htmlContentString)
                    let tableBody = try doc.select("tbody").array()
                    var index = 0
                    for bodyContent in tableBody {
                        switch index {
                        case 0:
                            self.parseTable(bodyContent: bodyContent, table: "WORLD")
                            self.countryArray.sort{$0.confirmed > $1.confirmed}
                            DispatchQueue.main.async {
                                self.countryDataSet = self.countryArray
                            }
                        case 1:
                            self.parseTable(bodyContent: bodyContent, table: "UNITED STATES")
                            self.usaArray.sort{$0.confirmed > $1.confirmed}
                            DispatchQueue.main.async {
                                self.usaDataSet = self.usaArray
                            }
                        default:
                            print("extra body content")
                        }
                        
                        index += 1
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            else {
                print("Could not create html content string from data")
            }

        }.resume()

    }
    
    func clear() {
        
        countryDataSet.removeAll()
        countryArray.removeAll()
        usaDataSet.removeAll()
        usaArray.removeAll()
        
    }
    
    func parseTable(bodyContent: Element, table: String) {
        
        do {
            let allRows = try bodyContent.select("tr").array()
            for i in 0...allRows.count - 1 {
                print(try allRows[i].text())
                
                var linkHref = ""
                if let link = try? allRows[i].select("a").array() {
                    if link.count > 0 {
                        linkHref = try link[0].attr("href")
                        print(linkHref)
                    }
                }
                                
                let divEntries = try allRows[i].select("div").array()
                if divEntries.count > 0 {
                    let divText = try divEntries[0].text()
                    if let lineNum = Int(divText) {
                        if table == "WORLD" && lineNum > 6 ||  table == "UNITED STATES" && lineNum > 5 {
                            let tdArray = try allRows[i].select("td").array()
                            parseTD(tdArray: tdArray, table: table, href: linkHref)
                        }
                    }
                }
            }

        } catch Exception.Error( _, let message) {
            print(message)
        } catch {
            print("error")
        }
        
    }
    
    func parseTD(tdArray: [Element], table: String, href: String) {
        
        var country = ""
        var cases = 0
        var newCases = ""
        var deaths = ""
        var newDeaths = ""
        var deathRate = ""
        var seriousCritical = ""
        var recovered = ""
        var yesterdayConfirmed = ""
        var yesterdayDeaths = ""
        
        var index = 0
        do {
            for str in tdArray {
                let text = try str.text()
                switch index {
                case 0:
                    country = text
                case 1:
                    let item = text.replacingOccurrences(of: ",", with: "")
                    cases = Int(item) != nil ? Int(item)! : 0
                case 2:
                    newCases = text
                case 3:
                    deaths = text
                case 4:
                    newDeaths = text
                case 5:
                    deathRate = text
                case 6:
                    seriousCritical = text
                case 7:
                    recovered = text
                case 8:
                    yesterdayConfirmed = text
                case 9:
                    yesterdayDeaths = text
                default:
                    print(text)
                }
                index += 1
            }
            let c = BNOData(country: country, confirmed: cases, newCases: newCases, deaths: deaths, newDeaths: newDeaths, deathRate: deathRate, seriousCritical: seriousCritical, recovered: recovered, yesterdayConfirmed: yesterdayConfirmed, yesterdayDeaths: yesterdayDeaths, href: href)
            
            if country != "TBD" && country != "" {
                switch table {
                    case "WORLD":
                        countryArray.append(c)
                    case "UNITED STATES":
                        usaArray.append(c)
                    default:
                        print("Can not save array")
                }
            }
            
        } catch Exception.Error( _, let message) {
            print(message)
        } catch {
            print("error")
        }
        
    }
/*
    func parseHTML(countryClass: String, valuesClass: String, html: String) {
        
        var countryArray: [String] = []

        do {
            var doc: Document = try SwiftSoup.parse(html)
            let elementsCountry = try doc.getElementsByClass(countryClass)
            for i in 0...elementsCountry.count-1 {
                let element = elementsCountry.get(i)
                let td : Elements = try element.select("td")
                let country = try td[0].text()
//                print(country)
                countryArray.append(country)
            }
            doc = try SwiftSoup.parse(html)
            let elementsCases = try doc.getElementsByClass(valuesClass)
            
            var index = 1
            var cases = 0
            var deaths = ""
            var yesterdayCases = ""
            var yesterdayDeaths = ""
            var countryCount = 0
            for i in 0...elementsCases.count-1 {
                let element = elementsCases.get(i)
                let td : Elements = try element.select("td")
                var item = try td[0].text()
//                print("index:  \(index) item: \(item)")
                if item == "Source" {
                    continue
                } else if index == 1 {
                    item = item.replacingOccurrences(of: ",", with: "")
                    cases = Int(item) != nil ? Int(item)! : 0
                } else if index == 2 {
                    deaths = item
                } else if index == 3 {
                    yesterdayCases = item
                    if countryArray[countryCount] == "Vatican City"  {
                        let c = BNOData(country: countryArray[countryCount], confirmed: cases, newCases: "", deaths: deaths, newDeaths: "", deathRate: "", seriousCritical: "", recovered: "", yesterdayConfirmed: yesterdayCases, yesterdayDeaths: "0", href: "")
//                        let c = BNOData(country: countryArray[countryCount], confirmed: cases, deaths: deaths, recovered: "", yesterdayConfirmed: yesterdayCases, yesterdayDeaths: "0")
//                        casesArray.append(c)
                        index = 0
                        countryCount += 1
                    }
                } else if index == 4 {
                    yesterdayDeaths = item
                    let c = BNOData(country: countryArray[countryCount], confirmed: cases, newCases: "", deaths: deaths, newDeaths: "", deathRate: "", seriousCritical: "", recovered: "", yesterdayConfirmed: yesterdayCases, yesterdayDeaths: yesterdayDeaths, href: "")
//                    let c = BNOData(country: countryArray[countryCount], confirmed: cases, deaths: deaths, recovered: "", yesterdayConfirmed: yesterdayCases, yesterdayDeaths: yesterdayDeaths)
//                    casesArray.append(c)
                    index = 0
                    countryCount += 1
                }
                index += 1
            }
        } catch Exception.Error( _, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
*/
}
