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
    @State private var newsCompanies: [NewsCompany] = []
    @State var expand = false
    @State var displaying: DisplayType = .popular
    
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
                    StatsView(item: item)
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
                List(newsCompanies, id: \.id) { details in
                    NavigationLink(destination: DetailedView(url: details.url!)) {
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
//        newsCompanies.removeAll()
        DispatchQueue.main.async {
            self.newsCompanies = self.item.newsCompany
        }
    }
    
    func makeButton(name: String, displaying: DisplayType) -> some View  {
        
        return AnyView(Button(action: {
            self.displaying = displaying
            self.expand.toggle()

            self.newsCompanies = self.item.newsCompany
            switch displaying {
                case .popular:
                    self.newsCompanies.sort {
                        $0.reading! < $1.reading!
                    }
                case .leastBiased:
                    self.newsCompanies.sort {
                        $0.biasedCount! < $1.biasedCount!
                    }
                case .balanced:
                    self.newsCompanies.sort {
                        $0.reading! < $1.reading!
                    }
                case .mostBiased:
                    self.newsCompanies.sort {
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
