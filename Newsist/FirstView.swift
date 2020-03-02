//
//  FirstView.swift
//  Newsist
//
//  Created by Larry Shannon on 3/1/20.
//  Copyright © 2020 Larry Shannon. All rights reserved.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                CustomScrollView(width: geometry.size.width, height: geometry.size.height)
                    .navigationBarTitle(Text("SwiftUI Pull To Refresh"), displayMode: .inline)
            }.navigationViewStyle(StackNavigationViewStyle())
        }
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

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
