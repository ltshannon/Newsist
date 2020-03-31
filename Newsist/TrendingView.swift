//
//  TrendingView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/3/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

class NewsCompanies: ObservableObject {
    @Published var newsCompanies: [NewsCompany] = []
    @Published var usersReading: Int = 0
    
    func initNewsCompanies(companies: [NewsCompany]) {
        newsCompanies = companies
        
        var count: Int = 0
        
        for c in companies {
            if let value = c.reading {
                count += value
            }
        }
        usersReading = count
        
    }
    
    func incrementUserCount(userCountId: String, count: Int) {
        var total: Int = 0
        for i in 0..<newsCompanies.count {
            if newsCompanies[i].id == userCountId {
                newsCompanies[i].reading = count
            }
            if let value = newsCompanies[i].reading {
                total += value
            }
        }
        usersReading = total
    }
}

enum DisplayType {
    case popular
    case leastBiased
    case balanced
    case mostBiased
}

struct TrendingView: View {
    var item: Article
    
    @Environment(\.presentationMode) var presentation
    @State private var showDetails = false
    @State var expand = false
    @State var displaying: DisplayType = .popular
    @ObservedObject var companies = NewsCompanies()
    @State var firstTimeFlag = false
    
    var body: some View {
        
        UITableView.appearance().backgroundColor = .clear
        return Form {
            Section(header: VStack(alignment: .center, spacing: 0)  {
                VStack {
                    Text(item.category!)
                        .font(.custom("Avenir Bold", size: 20))
                        .foregroundColor(Color.red)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }) {
                EmptyView()
            }.padding([.top], -6)
            Section (header: VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text(item.title!)
                        .font(.custom("Avenir Bold", size: 35))
                    HStack {
                        WebImage(url: URL(string:item.urlToImage!))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .scaledToFit()
                            .frame(width: 150, height: 150, alignment: .leading)
                        Text(item.description!)
                            .font(.custom("Avenir", size: 20))
                    }

                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Image("fire")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("\(companies.usersReading) users reading")
                        }
                        HStack {
                            Image("world")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Covered by \(item.coveredBy!)")
                        }
                        HStack {
                            Image("head")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Reporting is \(item.reportType!)")
                        }
                    }
                    HStack {
                        Text("REPORTS")
                            .font(.custom("Avenir Bold", size: 20))
                            .foregroundColor(.blue)
                        Spacer()
//                        DropDown()
                        VStack(alignment: .leading, content: {
                            
                            HStack {
                                Text(displayBiase(displaying: displaying))
                                    .font(.custom("Avenir Bold", size: 20))
                                    .foregroundColor(.blue)
                                Image(systemName: expand ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .frame(width: 15, height: 6)
                            }.onTapGesture {
                                self.expand.toggle()
                            }
                            
                            if expand {
                                makeButton(name: "POPULAR", displaying: .popular)
                                makeButton(name: "LEAST BIASED", displaying: .leastBiased)
                                makeButton(name: "BALANCED", displaying: .balanced)
                                makeButton(name: "MOST BIASED", displaying: .mostBiased)
                            }
                        })
                        .padding(10)
                        .animation(.spring())
                    }
                }
            }) {
                EmptyView()
            }.padding([.top], -6)
            Section {
                List(self.companies.newsCompanies, id: \.id) { details in
                    NavigationLink(destination: DetailedView(url: details.url != nil ? details.url! : "",  userCountId: details.id!, companies: self.companies)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(details.reporting!)
                                    .fontWeight(.heavy)
                                Text("\(details.reading!) users reading")
                            }
                            Spacer()
                            Image(self.getBiase(biase: details.biased!))
                                .scaledToFit()
                                .frame(width: 10, height: 10, alignment: .trailing)
                            if details.biasedCount != nil {
                                Text("+\(details.biasedCount!)")
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {self.loadData()})
        .navigationBarTitle("STORY", displayMode: .inline)
        .navigationBarItems(leading:
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image("chevron-right")
            }
        )
    }
    
    func loadData() {
        DispatchQueue.main.async {
//            self.companies.newsCompanies = self.item.newsCompany
            if !self.firstTimeFlag {
                self.companies.initNewsCompanies(companies: self.item.newsCompany)
                self.firstTimeFlag = true
            }
        }
    }
    
    func makeButton(name: String, displaying: DisplayType) -> some View  {
        
        return AnyView(Button(action: {
            self.displaying = displaying
            self.expand.toggle()

//            self.companies.newsCompanies = self.item.newsCompany
            switch displaying {
                case .popular:
                    self.companies.newsCompanies.sort {
                        $0.reading! > $1.reading!
                    }
                case .leastBiased:
                    self.companies.newsCompanies.sort {
                        $0.biasedCount! < $1.biasedCount!
                    }
                case .balanced:
                    self.companies.newsCompanies.sort {
                        $0.reading! < $1.reading!
                    }
                case .mostBiased:
                    self.companies.newsCompanies.sort {
                        $0.biasedCount! > $1.biasedCount!
                    }
            }

//            self.loadData()
            
        }) {
            Text(name).padding()
                .font(.custom("Avenir Bold", size: 20))
                .foregroundColor(.blue)
        })
    
    }
    
    func displayBiase(displaying: DisplayType) -> String {
        
        switch displaying {
            case .popular:
                return "POPULAR"
            case .leastBiased:
                return "LEAST BIASED"
            case .balanced:
                return "BALANCED"
            case .mostBiased:
                return "MOST BIASED"
        }
    }
    
    func getBiase(biase: String) -> String {
        
        switch biase {
            case "LEAST BIASED":
                return "donkey"
            case "Most Biased":
                return "elephant"
            default:
                return "head"
        }
    }
    
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {

        TrendingView(item: Article(category: "test", title: "test", description: "test", userCount: 100, coveredBy: "test", reportType: "test", url: "test", urlToImage: "test", newsCompany: []))

    }
}
