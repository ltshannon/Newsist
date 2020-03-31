//
//  BNOView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/26/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

struct BNOView: View {
    
    var body : some View{
        VStack {
            Home()
        }
    }
    
}

struct Home : View {
    @ObservedObject var covidData = BNOViewModel()
    @State var index = 0
    @State var show = true
    
    var body : some View{
        
        VStack(spacing: 0){
            
            appBar(model: covidData, index: self.$index,show: self.$show)
            
            ZStack{
                
                World(model: covidData, show: self.$show).opacity(self.index == 0 ? 1.0 : 0.0)
                
                usaCites(model: covidData).opacity(self.index == 1 ? 1.0 : 0.0)
                
                Calls().opacity(self.index == 2 ? 1.0 : 0.0)
            }

            
        }.edgesIgnoringSafeArea(.top)
    }
}

struct appBar : View {
    @ObservedObject var model: BNOViewModel
    @Binding var index : Int
    @Binding var show : Bool
    
    var body : some View{
        
        VStack{
            HStack{
                Text("Covid-19 Update")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
               Spacer(minLength: 0)
                Button(action: {
                    self.model.clear()
                    self.model.fetchData()
                }) {
                    Text("Refresh")
                        .foregroundColor(.white)
/*
                    Image(systemName: "arrow.clockwise")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
*/
                }
            }
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
                        Text("Untied States")
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
                        Text("")
                            .foregroundColor(.white)
                            .fontWeight(self.index == 2 ? .bold : .none)
                        
                        Capsule().fill(self.index == 2 ? Color.white : Color.clear)
                        .frame(height: 4)
                    }
                }
            }.padding(.bottom, 10)
            
            
        }.padding(.horizontal)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 10)
        .background(Color("Color"))
    }
}

struct World: View {
    @ObservedObject var model: BNOViewModel
    @Binding var show : Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Country")
                    .padding()
                    .frame(width: 145, alignment: .leading)
                Text("Confirmed")
                    .frame(width: 100, alignment: .leading)
                Text("Deaths")
                    .frame(width: 80, alignment: .leading)
                Text("New")
                    .frame(width: 80, alignment: .leading)
            }
            .frame(height: 40)

            List {
                    
                ForEach(model.countryDataSet, id: \.self) { values in
                    HStack {
                        Text(values.country)
                            .frame(width: 125, alignment: .leading)
                        Text("\(values.confirmed)")
                            .frame(width: 100, alignment: .leading)
                        Text("\(values.deaths)")
                            .frame(width: 80, alignment: .leading)
                        Text("\(values.newDeaths)")
                            .frame(width: 100, alignment: .leading)
                    }
                }
            }
        }
    }
    
}

struct usaCites : View {
    @ObservedObject var model: BNOViewModel
 
    var body: some View {
        VStack {
            HStack {
                Text("City")
                    .padding()
                    .frame(width: 145, alignment: .leading)
                Text("Confirmed")
                    .frame(width: 100, alignment: .leading)
                Text("Deaths")
                    .frame(width: 80, alignment: .leading)
                Text("New")
                    .frame(width: 80, alignment: .leading)
            }
            .frame(height: 40)
            
            List {
                ForEach(model.usaDataSet, id: \.self) { values in
                    HStack {
                        Text(values.country)
                            .frame(width: 125, alignment: .leading)
                        Text("\(values.confirmed)")
                            .frame(width: 100, alignment: .leading)
                        Text("\(values.deaths)")
                            .frame(width: 80, alignment: .leading)
                        Text("\(values.newDeaths)")
                            .frame(width: 100, alignment: .leading)
                    }
                }
            }
        }
    }
}

struct Calls : View {
    
    var body : some View{
        
        GeometryReader{_ in
            
            VStack{
                
                Text("Calls")
            }
        }
    }
}

struct BNOView_Previews: PreviewProvider {
    static var previews: some View {
        BNOView()
    }
}
