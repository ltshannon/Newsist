//
//  SDViewModel.swift
//  Newsist
//
//  Created by Larry Shannon on 4/3/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import Foundation
import SwiftSoup

struct SDData: Decodable, Hashable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

struct SDStats {
    let statement: String
    let cases: Int
    let years_0_9: Int
    let years_10_19: Int
    let years_20_29: Int
    let years_30_39: Int
    let years_40_49: Int
    let years_50_59: Int
    let years_60_69: Int
    let years_70_79: Int
    let years_80_Plus: Int
    let unknown: Int
    let hospitalization: Int
    let intensiveCare: Int
    let deaths: Int
    
    init(statement: String,
         cases: Int,
         years_0_9: Int,
         years_10_19: Int,
         years_20_29: Int,
         years_30_39: Int,
         years_40_49: Int,
         years_50_59: Int,
         years_60_69: Int,
         years_70_79: Int,
         years_80_Plus: Int,
         unknown: Int,
         hospitalization: Int,
         intensiveCare: Int,
         deaths: Int
         ) {
        self.statement = statement
        self.cases = cases
        self.years_0_9 = years_0_9
        self.years_10_19 = years_10_19
        self.years_20_29 = years_20_29
        self.years_30_39 = years_30_39
        self.years_40_49 = years_40_49
        self.years_50_59 = years_50_59
        self.years_60_69 = years_60_69
        self.years_70_79 = years_70_79
        self.years_80_Plus = years_80_Plus
        self.unknown = unknown
        self.hospitalization = hospitalization
        self.intensiveCare = intensiveCare
        self.deaths = deaths
    }
    
}

class SDViewModel: ObservableObject {
    @Published var sdDataSet: [SDData] = []
    @Published var sdDataStats: SDStats = SDStats(statement: "", cases: 0, years_0_9: 0, years_10_19: 0, years_20_29: 0, years_30_39: 0, years_40_49: 0, years_50_59: 0, years_60_69: 0, years_70_79: 0, years_80_Plus: 0, unknown: 0, hospitalization: 0, intensiveCare: 0, deaths: 0)
    var tempDataSet: [SDData] = []
    
    init() {
        
        fetchData()

    }
    
    func fetchData() {
        
//        let urlString = "https://www.worldometers.info/coronavirus/"
    
        let urlString = "https://www.sandiegocounty.gov/content/sdc/hhsa/programs/phs/community_epidemiology/dc/2019-nCoV/status.html"
    
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
                    
                    var statement = ""
                    var cases = 0
                    var deaths = 0
                    let tableBody = try doc.select("table").array()
                    if tableBody.count > 0 {
                        let allRows = try tableBody[0].select("tr").array()
                        for i in 0...allRows.count - 1 {
                            let row = try allRows[i].text()
                            print("tr: \(try allRows[i].text())")
                            if row.contains("Positive Cases in San Diego County") {
                                    statement = row
                            }
                            if row.contains("Total Positives") {
                                let tdArray = try allRows[i].select("td").array()
                                if tdArray.count == 2 {
                                    var temp = try tdArray[1].text()
                                    temp = temp.replacingOccurrences(of: ",", with: "")
                                    if let num = Int(temp) {
                                        cases = num
                                    }
                                }
                            }
                            if row.contains("Deaths") {
                                let tdArray = try allRows[i].select("td").array()
                                if tdArray.count == 2 {
                                    var temp = try tdArray[1].text()
                                    temp = temp.replacingOccurrences(of: ",", with: "")
                                    if let num = Int(temp) {
                                        deaths = num
                                    }
                                }
                            }
                        }
                    }
                    
                    let d = SDStats(statement: statement, cases: cases, years_0_9: 0, years_10_19: 0, years_20_29: 0, years_30_39: 0, years_40_49: 0, years_50_59: 0, years_60_69: 0, years_70_79: 0, years_80_Plus: 0, unknown: 0, hospitalization: 0, intensiveCare: 0, deaths: deaths)
                    
//                    print(try doc.text())
                    let links: [Element] = try doc.select("a").array()
                    
                    for link in links {
                        let linkHref: String = try link.attr("href")
                        if linkHref.contains(".pdf") {
                            print("href: \(linkHref)")
                            let linkText: String = try link.text()
                            print(linkText)
                            if linkText.contains("Discrimination by the County") {
                                continue
                            }
                            let item = SDData(name: linkText, url: linkHref)
                            self.tempDataSet.append(item)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.sdDataSet = self.tempDataSet
                        self.sdDataStats = d
                    }
                    

                    } catch {
                        print(error.localizedDescription)
                    }
                
            }
            
        }.resume()
        
    }
    
    func clear() {
        
        tempDataSet.removeAll()
        
    }
}
