//
//  ContentView.swift
//  SwiftUIMapView
//
//  Created by liang.wang on 21/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showPartialSheet = false
    var body: some View {
        MapViewWrapper()
            .partialSheet($showPartialSheet) {
                Sheet()
            }
            .onNotification(NSNotification.Name(rawValue: "MKAnnotationViewClicked")) {
                showPartialSheet = !showPartialSheet
            }
    }
}

struct Sheet: View {
    var body: some View {
        VStack {
            Text("This is the partial sheet")
        }
        .frame(height: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
