//
//  HomeView.swift
//  SDCare
//
//  Created by Vasapol Aurean on 13/3/2566 BE.
//

import SwiftUI
import Charts


struct HomeView: View{
    @ObservedObject var HomeScreen_viewModel = HomeScreen_TextViewModel()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View{
        GeometryReader{ geo in
            VStack{
                ScrollView{
                    VStack{
                        ZStack{
                            VStack{
                                HStack{
                                    Spacer()
                                    Image(systemName: "powersleep")
                                        .resizable()
                                        .cornerRadius(15)
                                        .frame(width: geo.size.width/10,height: geo.size.width/10)
                                        .padding(.trailing)
                                }
                                Spacer()
                            }
                            VStack{
                                HStack{
                                    Text("👋")
                                    Text(greetingLogic())
                                    Spacer()
                                }
                                HStack{
                                    Text(UserDefaults.standard.string(forKey: "Name") ?? "Unset")
                                        .font(.title)
                                        .bold()
                                    Spacer()
                                }
                                ZStack{
                                    Group{
                                        Image("sleep_cat")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .scaledToFill()
                                            .frame(height: geo.size.width/3)
                                            .clipped()
                                    }.cornerRadius(20)
                                        .brightness(-0.2)
                                    Text("Suitable enviroment make you sleep more deeper")
                                        .multilineTextAlignment(.center)
                                        .bold()
                                        .colorInvert()
                                    
                                }
                                VStack{
                                    HStack{
                                        Text("Overall night")
                                            .font(.title2)
                                            .bold()
                                        Spacer()
                                    }
                                    if let HomeScreen_data = HomeScreen_viewModel.items.first {
                                        HStack{
                                            overall_night_Ui(geo_wi: geo.size.width, Header: "Bruxism",Data: HomeScreen_data.Bruxism , color: .orange)
                                            overall_night_Ui(geo_wi: geo.size.width, Header: "Sleep Phase",Data: HomeScreen_data.Sleep_Phase, color: .blue)
                                        }.frame(height: geo.size.width/2)
                                        HStack{
                                            overall_night_Ui(geo_wi: geo.size.width, Header: "Snoring",Data: HomeScreen_data.Snoring, color: .cyan)
                                            overall_night_Ui(geo_wi: geo.size.width, Header: "Sleep apnea",Data: HomeScreen_data.Sleep_Apnea, color: .purple)
                                        }.frame(height: geo.size.width/2)
                                    }else{
                                        RoundedRectangle(cornerRadius: 15.0)
                                            .frame(height: geo.size.width/2)

                                    }
                                }
                                Timeline_UI()
                            }
                        }.padding(.horizontal)
                    }
                }
            }.onReceive(timer) { time in
                HomeScreen_viewModel.fetchData()
            }
            .onAppear(perform: {
                HomeScreen_viewModel.fetchData()
            })
        }
    }
    func greetingLogic() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        let NEW_DAY = 0
        let NOON = 12
        let SUNSET = 18
        let MIDNIGHT = 24
        
        var greetingText = "Hello" // Default greeting text
        switch hour {
        case NEW_DAY..<NOON:
            greetingText = "Good Morning"
        case NOON..<SUNSET:
            greetingText = "Good Afternoon"
        case SUNSET..<MIDNIGHT:
            greetingText = "Good Evening"
        default:
            _ = "Hello"
        }
        
        return greetingText
    }
}

struct overall_night_Ui: View{
    let geo_wi: CGFloat
    let Header: String
    let Data: Int
    let color: Color
    var body: some View{
        VStack{
            GeometryReader { geo in
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(color)
                            .frame(height: geo.size.width)
                            .opacity(0.7)
                        VStack{
                            Text(Header)
                                .font(.title)
                                .bold()
                                .colorInvert()
                            Text(String(Data))
                                .font(.system(size: 100))
                                .bold()
                                .colorInvert()
                            
                        }
                    }
                    
                }.frame(height: geo.size.width)
            }
        }
    }
}

struct Timeline_UI:View{
    var body: some View{
        VStack{
            HStack{
                GeometryReader{ geo in
                    HStack{
                        Text("Timeline")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                }
            }
            
            HStack{
                Text("Snoring")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(red: 56/255, green: 97/255, blue: 140/255))
                Spacer()
                Text("Bruxism")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(red: 252/255, green: 137/255, blue: 85/255))
                Spacer()
                VStack{
                    Text("Sleep")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(red: 255/255, green: 89/255, blue: 100/255)) //Color(red: 255/255, green: 89/255, blue: 100/255)
                    Text("apnea")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(red: 255/255, green: 89/255, blue: 100/255))
                    
                }
            }
            .padding()
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 300)
                    .foregroundColor(.cyan)
                    .opacity(0.2)
                TimelineChart()
                    .padding(.leading)
                    .padding(.trailing)
            }
        }
    }
}




struct TimelineChart: View {
    @ObservedObject var Graph_ViewModel = GraphItem_ViewModel()
    var body: some View {
        Chart {
            ForEach(Graph_ViewModel.items, id: \.id){ items in
                if (items.SleepType == "1"){
                    RuleMark(
                        xStart: .value("Start", Date(timeInterval: 1, since: Date(primitivePlottable: ConvertStringToDate(items.Start)!)!), unit: .hour),
                        xEnd: .value("End", Date(timeInterval: 1, since: Date(primitivePlottable: ConvertStringToDate(items.Stop)!)!), unit: .hour)
                    ).foregroundStyle(Color(red: 56/255, green: 97/255, blue: 140/255))
                        .lineStyle(.init(lineWidth :6))
                }
                if(items.SleepType == "2"){
                    RuleMark(
                        xStart: .value("Start", Date(timeInterval: 1, since: Date(primitivePlottable: ConvertStringToDate(items.Start)!)!), unit: .hour),
                        xEnd: .value("End", Date(timeInterval: 1, since: Date(primitivePlottable: ConvertStringToDate(items.Stop)!)!), unit: .hour)
                    ).foregroundStyle(Color(red: 252/255, green: 137/255, blue: 85/255))
                        .lineStyle(.init(lineWidth :6))
                }
                if (items.SleepType == "3"){
                    RuleMark(
                        xStart: .value("Start", Date(timeInterval: 1, since: Date(primitivePlottable: ConvertStringToDate(items.Start)!)!), unit: .hour),
                        xEnd: .value("End", Date(timeInterval: 1, since: Date(primitivePlottable: ConvertStringToDate(items.Stop)!)!), unit: .hour)
                    ).foregroundStyle(Color(red: 255/255, green: 89/255, blue: 100/255))
                        .lineStyle(.init(lineWidth :6))
                }
            }
            
        }.chartXAxis{
            AxisMarks(values: .stride(by: .hour)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.hour())
                }
        }
        .onAppear(perform: {
            Graph_ViewModel.fetchData()
        })
        .frame(height: 250)
    }
    func ConvertStringToDate(_ StringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: StringDate) // replace Date String
    }
    //"2015-04-01T11:42:00"

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
