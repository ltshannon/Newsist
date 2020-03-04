//
//  ContentView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

var articiles: [Articile]?

struct ContentView: View {
    @State var isNavigationBarHidden: Bool = true
    @State var selectedView = 1
    @ObservedObject public var postListMV = ArticilesListViewModel()
        
    var body: some View {
//        GeometryReader{ geometry in
        NavigationView {
            TabView(selection: $selectedView) {
                Text("Coming soon")
//                CustomScrollView(width: geometry.size.width, height: geometry.size.height)
                    .tabItem {
                        Image("newspaper")
                        Text("My Topics")
                    }.tag(0)
                DisplayArticles()
                    .tabItem {
                        Image("trending")
                        Text("Trending")
                    }.tag(1)
                Text("Coming soon")
                    .tabItem {
                        Image("browse")
                        Text("Browse")
                    }.tag(2)
            }
            .hideNavigationBar()
/*
            .navigationBarItems(leading:
                Button(action: {
                    self.postListMV.refresh()
                }) {
                    Image("reload")
                }
            )
*/
        }.navigationViewStyle(StackNavigationViewStyle())
//        }
    }
}

extension View {
    func hideNavigationBar() -> some View {
        self
            .navigationBarTitle("", displayMode: .inline)
 //           .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct SwiftUIList: View {
    @ObservedObject var postListMV = ArticilesListViewModel()

    var body: some View {
/*
        List(self.postListMV.articiles, id: \.id){
            model in
            Text(model.title)
        }
*/
        DisplayArticles()
    }
}

struct CustomScrollView : UIViewRepresentable {
    
    var width : CGFloat, height : CGFloat
    let postListMV = ArticilesListViewModel()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, model: postListMV)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)

        let childView = UIHostingController(rootView: SwiftUIList(postListMV: postListMV))
        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        control.addSubview(childView.view)
        return control
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }

    class Coordinator: NSObject {
        var control: CustomScrollView
        var model : ArticilesListViewModel

        init(_ control: CustomScrollView, model: ArticilesListViewModel) {
            self.control = control
            self.model = model
        }

        @objc func handleRefreshControl(sender: UIRefreshControl) {

            sender.endRefreshing()
            model.refresh()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
