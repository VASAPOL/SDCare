//
//  ContentView.swift
//  SDCare
//
//  Created by Vasapol Aurean on 25/2/2566 BE.
//

import SwiftUI
import SwiftfulLoadingIndicators
import UserNotifications

struct noInternetconnection: View{
    var body: some View{
        VStack{
            LoadingIndicator(size: .large)
            Text("Connecting to server")
        }
    }
}


struct ContentView: View {
    @State private var serverStatus = "Unknown"
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            if serverStatus != "Online"{
                noInternetconnection()
            }else{
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
                        Time_UP()
                            .tabItem{
                                Label("Time", systemImage: "timer")
                            }
                        MusicView()
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
        }.onAppear(perform: {
            checkServerStatus()
            requestPer()
        })
        .onReceive(timer){ time in
            checkServerStatus()
        }
    }
    
    func requestPer(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func checkServerStatus() {
            guard let url = URL(string: "http://"+serverAddr+"/HomeScreen_Info.json") else {
                serverStatus = "Invalid URL"
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    serverStatus = "Offline"
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    serverStatus = "Online"
                } else {
                    serverStatus = "Offline"
                }
            }
            
            task.resume()
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
