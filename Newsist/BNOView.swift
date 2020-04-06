//
//  BNOView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/26/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

struct BNOView: View {
    @ObservedObject var model = BNOViewModel()
    @ObservedObject var sdModel = SDViewModel()
    
    var body : some View{
        VStack {
            Home(covidData: model, sdData: sdModel)
                .navigationBarItems(trailing:
                    Button("Refresh") {
                        self.model.clear()
                        self.model.fetchData()
                        self.sdModel.clear()
                        self.sdModel.fetchData()
                    }
                    .foregroundColor(.white)
                )
            .navigationBarTitle("Covid-19 Update", displayMode: .inline)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = .red
                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
            })
        }
//            .navigationBarTitle("Covid-19 Update", displayMode: .inline)

    }
    
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

struct Home : View {
    @ObservedObject var covidData: BNOViewModel
    @ObservedObject var sdData: SDViewModel
    @State var index = 0
    @State var show = true
    
    var body : some View{
        
        VStack(spacing: 0){
            
//            appBar(model: covidData, index: self.$index, show: self.$show)
            appBar(index: self.$index)
            
            ZStack{
                DisplayData(type: "World", model: covidData).opacity(self.index == 0 ? 1.0 : 0.0)
                
                DisplayData(type: "USA", model: covidData).opacity(self.index == 1 ? 1.0 : 0.0)
                
                SanDiegoData(model: sdData).opacity(self.index == 2 ? 1.0 : 0.0)
                
                DisplayData(type: "J Hopkins", model: covidData).opacity(self.index == 3 ? 1.0 : 0.0)
            }

            
        }
            .edgesIgnoringSafeArea(.top)
    }
}

struct appBar : View {
//    @ObservedObject var model: BNOViewModel
    @Binding var index : Int
//    @Binding var show : Bool
    
    var body : some View{

        VStack(alignment: .leading) {
            HStack{
                Button(action: {
                    self.index = 0
                }) {
                    VStack{
                        Text("World")
                            .foregroundColor(.white)
                            .fontWeight(self.index == 0 ? .bold : .none)
                        Capsule().fill(self.index == 0 ? Color.white : Color.clear)
                        .frame(height: 4)
                    }
                }
                
                Button(action: {
                    self.index = 1
                }) {
                    VStack{
                        Text("USA")
                            .foregroundColor(.white)
                            .fontWeight(self.index == 1 ? .bold : .none)
                        Capsule().fill(self.index == 1 ? Color.white : Color.clear)
                        .frame(height: 4)
                    }
                }
                
                Button(action: {
                    self.index = 2
                }) {
                    VStack{
                        Text("San Diego")
                            .foregroundColor(.white)
                            .fontWeight(self.index == 2 ? .bold : .none)
                        Capsule().fill(self.index == 2 ? Color.white : Color.clear)
                        .frame(height: 4)
                    }
                }
                Button(action: {
                    self.index = 3
                }) {
                    VStack{
                        Text("J Hopkins")
                            .foregroundColor(.white)
                            .fontWeight(self.index == 3 ? .bold : .none)
                            .padding(.trailing, 20)
                        Capsule().fill(self.index == 3 ? Color.white : Color.clear)
                        .frame(height: 4)
                    }
                }
            }
                .padding(.bottom, 10)
        }
//            .padding(.horizontal)
            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 10)
            .background(Color("Color"))
            .frame(alignment: .leading)
    }
}

struct DisplayData: View {
    let type: String
    @ObservedObject var model: BNOViewModel
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State var index = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                self.model.sort(sortBy: .country)
                    self.index = 0
                }) {
                    HStack {
                        Text("Country")
                            .padding()
                            .frame(width: 95, height: 25, alignment: .leading)
//                            .background(Color.pink)
                        if index == 0 {
                            Image(systemName: model.countryArrow ? "arrow.up" : "arrow.down")
                                .resizable()
                                .frame(width: 15, height: 15, alignment: .leading)
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 130)
                }
                Button(action: {
                    self.model.sort(sortBy: .confirmed)
                    self.index = 1
                }) {
                    HStack {
                        Text("Confirmed")
                            .frame(width: 90, alignment: .leading)
//                            .background(Color.pink)
                        if index == 1 {
                            Image(systemName: model.confirmedArrow ? "arrow.up" : "arrow.down")
                                .resizable()
                                .frame(width: 15, height: 15, alignment: .leading)
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 120)

                }
                Button(action: {
                    self.model.sort(sortBy: .deaths)
                    self.index = 2
                }) {
                    HStack {
                        Text("Deaths")
                            .frame(width: 60, alignment: .leading)
//                            .background(Color.pink)
                        if index == 2 {
                            Image(systemName: model.deathsArrow ? "arrow.up" : "arrow.down")
                                .resizable()
                                .frame(width: 15, height: 15, alignment: .leading)
                                .foregroundColor(.black)
                            }
                        }
                    .frame(width: 80)
                }
                Button(action: {
                    self.model.sort(sortBy: .newDeaths)
                    self.index = 3
                }) {
                    HStack {
                        Text("New")
                            .frame(width: 40, alignment: .leading)
//                            .background(Color.pink)
                        if index == 3 {
                            Image(systemName: model.newDeathsArrow ? "arrow.up" : "arrow.down")
                                .resizable()
                                .frame(width: 15, height: 15, alignment: .leading)
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 80)
                }
                if horizontalSizeClass == .regular && verticalSizeClass == .compact || horizontalSizeClass == .regular && verticalSizeClass == .regular  {
                    Button(action: {
                        self.model.sort(sortBy: .deathRate)
                    }) {
                        Text("Death Rate")
                    }
                            .frame(width: 100, alignment: .leading)
                    Button(action: {
                        self.model.sort(sortBy: .seriousCritical)
                    }) {
                        Text("Critical")
                            .frame(width: 100, alignment: .leading)
                    }
                    Button(action: {
                        self.model.sort(sortBy: .recovered)
                    }) {
                        Text("Recovered")
                            .frame(width: 100, alignment: .leading)
                    }
                }
            }
            .frame(height: 40)
            
//            List (type == "World" ? model.countryDataSet : model.usaDataSet, id: \.self) { values in
            List (getModel(type: type, model: model), id: \.self) { values in
                NavigationLink(destination: BNODetailView(url: values.href)) {
                    HStack {
                        Text(values.country)
                            .frame(width: self.index == 0 ? 130 : 130, alignment: .leading)
                        Text("\(values.confirmed)")
                            .frame(width: self.index == 1 ? 110 : 110, alignment: .leading)
                        Text("\(values.deaths)")
                            .frame(width: self.index == 2 ? 90 : 80, alignment: .leading)
                        if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
                            Text("\(values.newDeaths)")
                                .frame(width: 100, alignment: .leading)
                        }
                        else {
                            Text("\(values.newDeaths)")
                                .frame(width: 80, alignment: .leading)
                            Text("\(String(format: "%.2f",values.deathRate))%")
                                .frame(width: 100, alignment: .leading)
                            Text("\(values.seriousCritical)")
                                .frame(width: 100, alignment: .leading)
                            Text("\(values.recovered)")
                                .frame(width: 100, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}

func getModel(type: String, model: BNOViewModel)-> [BNOData] {
    var modelType: [BNOData]
    
    switch type {
    case "World":
        modelType = model.countryDataSet
    case "USA":
        modelType = model.usaDataSet
    case "J Hopkins":
        modelType = model.jhDataSet
    default:
        modelType = []
        print("invalid getModel")
    }
    
    return modelType
}

struct SanDiegoData : View {
    @ObservedObject var model: SDViewModel
    
    var body : some View{
        
        VStack {
            Spacer()
            Text(model.sdDataStats.statement)
                .padding()
            Spacer()
            Text("Total Positives: \(model.sdDataStats.cases)")
            Spacer()
            Text("Deaths: \(model.sdDataStats.deaths)")
            Spacer()
            List (model.sdDataSet, id: \.self) { values in
                NavigationLink(destination: DisplayPDFView(url: values.url)) {
                    VStack {
                        Text(values.name)
                    }
                }
            }
        }
    }
}

struct BNOView_Previews: PreviewProvider {
    static var previews: some View {
        BNOView(model: BNOViewModel())
    }
}
