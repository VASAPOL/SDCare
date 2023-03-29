//
//  ContentView.swift
//  SDCare
//
//  Created by Vasapol Aurean on 25/2/2566 BE.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            TabView{
                HomeView()
                    .tabItem{
                        Label("Home", systemImage: "house")
                    }
                Report_View_2()
                    .tabItem{
                        Label("Report", systemImage: "chart.bar")
                    }
                Time_View()
                    .tabItem{
                        Label("Time", systemImage: "timer")
                    }
                HomeView()
                    .tabItem{
                        Label("Sleep", systemImage: "powersleep")
                    }
                Setting_View()
                    .tabItem{
                        Label("More", systemImage: "line.3.horizontal")
                    }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
