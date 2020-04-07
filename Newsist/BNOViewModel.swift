//
//  BNOViewModel.swift
//  Newsist
//
//  Created by Larry Shannon on 3/26/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI
import SwiftSoup

enum SortType {
    case country
    case confirmed
    case newCases
    case deaths
    case newDeaths
    case deathRate
    case seriousCritical
    case recovered
}

struct BNOData: Decodable, Hashable {
    let country: String
    let confirmed: Int
    let newCases: Int
    let deaths: Int
    let newDeaths: Int
    let deathRate: Double
    let seriousCritical: Int
    let recovered: Int
    let yesterdayConfirmed: String
    let yesterdayDeaths: String
    let href: String
    
    init(country: String, confirmed: Int, newCases: Int, deaths: Int, newDeaths: Int, deathRate: Double, seriousCritical: Int, recovered: Int, yesterdayConfirmed: String, yesterdayDeaths: String, href: String) {
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
    @Published var countryArrow: Bool = true
    @Published var confirmedArrow: Bool = true
    @Published var newCasesArrow: Bool = true
    @Published var newDeathsArrow: Bool = true
    @Published var deathsArrow: Bool = true
    @Published var jhDataSet: [BNOData] = []
    @Published var womDataSet: [BNOData] = []

    var countryArray: [BNOData] = []
    var usaArray: [BNOData] = []
    var jhTempDataSet: [BNOData] = []
    var womTempDataSet: [BNOData] = []
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

        let urlString2 = "https://coronavirus.jhu.edu/data/mortality"
        guard let url2 = URL(string: urlString2) else {
            fatalError("Invalid URL")
        }
                    
        URLSession.shared.dataTask(with: url2) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            if let htmlContentString = String.init(data: data, encoding: String.Encoding(rawValue:String.Encoding.utf8.rawValue)) {
                do {
                    let doc : Document = try SwiftSoup.parse(htmlContentString)
                    var country: String = ""
                    var confirmed: Int = 0
                    var deaths: Int = 0
                    var caseFatality: Double = 0
//                    var deaths100KPop: Double = 0
                    let tableBody = try doc.select("table").array()
                    if tableBody.count > 0 {
                        let allRows = try tableBody[0].select("tr").array()
                        for i in 0...allRows.count - 1 {
                            let row = try allRows[i].text()
                            print("tr: \(try allRows[i].text())")
                            if row.contains("Case-Fatality") {
                                continue
                            }
                            let tdArray = try allRows[i].select("td").array()
                            if tdArray.count == 5 {
                                for i in 0...tdArray.count - 1 {
                                    if i == 0 {
                                        country = try tdArray[i].text()
                                    } else {
                                        switch i {
                                        case 1:
                                            var temp = try tdArray[i].text()
                                            temp = temp.replacingOccurrences(of: ",", with: "")
                                            if let num = Int(temp) {
                                                confirmed = num
                                            }
                                        case 2:
                                            var temp = try tdArray[i].text()
                                            temp = temp.replacingOccurrences(of: ",", with: "")
                                            if let num = Int(temp) {
                                                deaths = num
                                            }
                                        case 3:
                                            var temp = try tdArray[i].text()
                                            temp = temp.replacingOccurrences(of: "%", with: "")
                                            if let num = Double(temp) {
                                                caseFatality = num
                                            }
//                                        case 4:
//                                            let temp = try tdArray[i].text()
//                                            if let num = Double(temp) {
//                                                deaths100KPop = num
//                                            }
                                        default:
                                            print("extra data in JD data")
                                        }
                                    }
                                }
                            }
        //                            let d = JHData(country: country, confirmed: confirmed, deaths: deaths, caseFatality: caseFatality, deaths100KPop: deaths100KPop)
                            let d = BNOData(country: country, confirmed: confirmed, newCases: 0, deaths: deaths, newDeaths: 0, deathRate: caseFatality, seriousCritical: 0, recovered: 0, yesterdayConfirmed: "", yesterdayDeaths: "", href: "")

                            self.jhTempDataSet.append(d)
                        }
                    }
                                
                    self.jhTempDataSet.sort{$0.confirmed > $1.confirmed}
                    DispatchQueue.main.async {
                        self.jhDataSet = self.jhTempDataSet
                    }
                } catch {
                    print(error.localizedDescription)
                }
                            
            }
                        
        }.resume()
        
        let urlString3 = "https://www.worldometers.info/coronavirus/"
        guard let url3 = URL(string: urlString3) else {
            fatalError("Invalid URL")
        }
                    
        URLSession.shared.dataTask(with: url3) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            if let htmlContentString = String.init(data: data, encoding: String.Encoding(rawValue:String.Encoding.utf8.rawValue)) {
                do {
                    let doc : Document = try SwiftSoup.parse(htmlContentString)
                    var country = ""
                    var cases = 0
                    var newCases = 0
                    var deaths = 0
                    var newDeaths = 0
                    var recovered = 0
                    let tableBody = try doc.select("table").array()
                    if tableBody.count > 0 {
                        let allRows = try tableBody[0].select("tr").array()
                        for i in 0...allRows.count - 1 {
                            let row = try allRows[i].text()
                            print("tr: \(try allRows[i].text())")
                            if row.contains("Country, Other") || row.contains("World") {
                                continue
                            }
                            let tdArray = try allRows[i].select("td").array()
                            if tdArray.count == 12 {
                                for i in 0...tdArray.count - 1 {
                                    switch i {
                                    case 0:
                                        country = try tdArray[i].text()
                                    case 1:
                                        var temp = try tdArray[i].text()
                                        temp = temp.replacingOccurrences(of: ",", with: "")
                                        if let num = Int(temp) {
                                            cases = num
                                        }
                                    case 2:
                                        var temp = try tdArray[i].text()
                                        temp = temp.replacingOccurrences(of: ",", with: "")
                                        if let num = Int(temp) {
                                            newCases = num
                                        }
                                    case 3:
                                        var temp = try tdArray[i].text()
                                        temp = temp.replacingOccurrences(of: ",", with: "")
                                        if let num = Int(temp) {
                                            deaths = num
                                        }
                                    case 4:
                                        var temp = try tdArray[i].text()
                                        temp = temp.replacingOccurrences(of: ",", with: "")
                                        temp = temp.replacingOccurrences(of: "+", with: "")
                                        if let num = Int(temp) {
                                            newDeaths = num
                                        }
                                    case 5:
                                        var temp = try tdArray[i].text()
                                        temp = temp.replacingOccurrences(of: ",", with: "")
                                        if let num = Int(temp) {
                                            recovered = num
                                        }
                                    case 6, 7, 8, 9, 10, 11:
                                        _ = try tdArray[i].text()
                                    default:
                                        print("extra data in WOM data")
                                    }
                                }
                            }
                            let d = BNOData(country: country, confirmed: cases, newCases: newCases, deaths: deaths, newDeaths: newDeaths, deathRate: 0, seriousCritical: 0, recovered: recovered, yesterdayConfirmed: "", yesterdayDeaths: "", href: "")

                            self.womTempDataSet.append(d)
                        }
                    }
                                
                    self.womTempDataSet.sort{$0.confirmed > $1.confirmed}
                    DispatchQueue.main.async {
                        self.womDataSet = self.womTempDataSet
                    }
                } catch {
                    print(error.localizedDescription)
                }
                            
            }
                        
        }.resume()
    }
    
    func clear() {
        
        countryDataSet.removeAll()
        countryArray.removeAll()
        usaDataSet.removeAll()
        usaArray.removeAll()
        jhTempDataSet.removeAll()
        jhDataSet.removeAll()
        womTempDataSet.removeAll()
        womDataSet.removeAll()
        
    }
    
    func sort(sortBy: SortType) {
        
        switch sortBy {
        case .country:
            if countryArrow {
                self.countryArray.sort{$0.country < $1.country}
                self.usaArray.sort{$0.country < $1.country}
                self.jhTempDataSet.sort{$0.country < $1.country}
                self.womTempDataSet.sort{$0.country < $1.country}
            } else {
                self.countryArray.sort{$0.country > $1.country}
                self.usaArray.sort{$0.country > $1.country}
                self.jhTempDataSet.sort{$0.country > $1.country}
                self.womTempDataSet.sort{$0.country > $1.country}
            }
            countryArrow.toggle()
        case .confirmed:
            if confirmedArrow {
                self.countryArray.sort{$0.confirmed > $1.confirmed}
                self.usaArray.sort{$0.confirmed > $1.confirmed}
                self.jhTempDataSet.sort{$0.confirmed > $1.confirmed}
                self.womTempDataSet.sort{$0.confirmed > $1.confirmed}
            } else {
                self.countryArray.sort{$0.confirmed < $1.confirmed}
                self.usaArray.sort{$0.confirmed < $1.confirmed}
                self.jhTempDataSet.sort{$0.confirmed < $1.confirmed}
                self.womTempDataSet.sort{$0.confirmed < $1.confirmed}
            }
            confirmedArrow.toggle()
        case .newCases:
            if newCasesArrow {
                self.countryArray.sort{$0.newCases > $1.newCases}
                self.usaArray.sort{$0.newCases > $1.newCases}
                self.jhTempDataSet.sort{$0.newCases > $1.newCases}
                self.womTempDataSet.sort{$0.newCases > $1.newCases}
            }
            else {
                self.countryArray.sort{$0.newCases < $1.newCases}
                self.usaArray.sort{$0.newCases < $1.newCases}
                self.jhTempDataSet.sort{$0.newCases < $1.newCases}
                self.womTempDataSet.sort{$0.newCases < $1.newCases}
            }
            newCasesArrow.toggle()
        case .deaths:
            if deathsArrow {
                self.countryArray.sort{$0.deaths > $1.deaths}
                self.usaArray.sort{$0.deaths > $1.deaths}
                self.jhTempDataSet.sort{$0.deaths > $1.deaths}
                self.womTempDataSet.sort{$0.deaths > $1.deaths}
            } else {
                self.countryArray.sort{$0.deaths < $1.deaths}
                self.usaArray.sort{$0.deaths < $1.deaths}
                self.jhTempDataSet.sort{$0.deaths < $1.deaths}
                self.womTempDataSet.sort{$0.deaths < $1.deaths}
            }
            deathsArrow.toggle()
        case .newDeaths:
            if newDeathsArrow {
                self.countryArray.sort{$0.newDeaths > $1.newDeaths}
                self.usaArray.sort{$0.newDeaths > $1.newDeaths}
                self.jhTempDataSet.sort{$0.newDeaths > $1.newDeaths}
                self.womTempDataSet.sort{$0.newDeaths > $1.newDeaths}
            } else {
                self.countryArray.sort{$0.newDeaths < $1.newDeaths}
                self.usaArray.sort{$0.newDeaths < $1.newDeaths}
                self.jhTempDataSet.sort{$0.newDeaths < $1.newDeaths}
                self.womTempDataSet.sort{$0.newDeaths < $1.newDeaths}
            }
            newDeathsArrow.toggle()
        case .deathRate:
            self.countryArray.sort{$0.deathRate > $1.deathRate}
            self.usaArray.sort{$0.deathRate > $1.deathRate}
            self.jhTempDataSet.sort{$0.deathRate > $1.deathRate}
            self.womTempDataSet.sort{$0.deathRate > $1.deathRate}
        case .seriousCritical:
            self.countryArray.sort{$0.seriousCritical > $1.seriousCritical}
            self.usaArray.sort{$0.seriousCritical > $1.seriousCritical}
            self.jhTempDataSet.sort{$0.seriousCritical > $1.seriousCritical}
            self.womTempDataSet.sort{$0.seriousCritical > $1.seriousCritical}
        case .recovered:
            self.countryArray.sort{$0.recovered > $1.recovered}
            self.usaArray.sort{$0.recovered > $1.recovered}
            self.jhTempDataSet.sort{$0.recovered > $1.recovered}
            self.womTempDataSet.sort{$0.recovered > $1.recovered}
        }
        
        DispatchQueue.main.async {
            self.countryDataSet = self.countryArray
            self.usaDataSet = self.usaArray
            self.jhDataSet = self.jhTempDataSet
            self.womDataSet = self.womTempDataSet
        }
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
        var newCases = 0
        var deaths = 0
        var newDeaths = 0
        var deathRate = 0.0
        var seriousCritical = 0
        var recovered = 0
        var yesterdayConfirmed = ""
        var yesterdayDeaths = ""
        
        var index = 0
        do {
            for str in tdArray {
                let text = try str.text()
                var item = text.replacingOccurrences(of: ",", with: "")
                item = item.replacingOccurrences(of: "%", with: "")
                switch index {
                case 0:
                    country = text
                case 1:
                    cases = Int(item) != nil ? Int(item)! : 0
                case 2:
                    newCases = Int(item) != nil ? Int(item)! : 0
                case 3:
                    deaths = Int(item) != nil ? Int(item)! : 0
                case 4:
                    newDeaths = Int(item) != nil ? Int(item)! : 0
                case 5:
                    deathRate = Double(item) != nil ? Double(item)! : 0
                case 6:
                    seriousCritical = Int(item) != nil ? Int(item)! : 0
                case 7:
                    recovered = Int(item) != nil ? Int(item)! : 0
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
