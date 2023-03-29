//
//  Report_View_2.swift
//  SDCare
//
//  Created by Vasapol Aurean on 26/3/2566 BE.
//

import SwiftUI
import Charts
import Accelerate

struct Report_View_2: View {
    @ObservedObject var ReportScreen_viewModel = Report_ViewModel()
    @State private var isHeartRateScreenisActived = false
    var body: some View {
        VStack{
            NavigationView(content: {
                VStack{
                    NavigationLink(destination: Heart_rate_View(),
                                   isActive: $isHeartRateScreenisActived){EmptyView()}
                    List{
                        if let Report_Screen_Data = ReportScreen_viewModel.items.first {
                            Button(action: {
                                
                            }, label: {
                                insideNavigation(image_name: "null", image_color: .red, text_color: .red, Topic: "Bruxism", update_time: Report_Screen_Data.Brux_update_time, data:  Report_Screen_Data.Bruxism,unitt: "")
                            })
                            Button(action: {
                                
                            }, label: {
                                insideNavigation(image_name: "bed.double.fill", image_color: .purple, text_color: .purple, Topic: "Sleep Phase", update_time: Report_Screen_Data.Sleep_Phase_update_time, data: Report_Screen_Data.Sleep_Phase,unitt: "")
                            })
                            Button(action: {
                                
                            }, label: {
                                insideNavigation(image_name: "speaker.zzz", image_color: .blue, text_color: .blue, Topic: "Snoring", update_time: Report_Screen_Data.Snoring_update_time, data: Report_Screen_Data.Snoring,unitt: "")
                            })
                            Button(action: {
                                
                            }, label: {
                                insideNavigation(image_name: "exclamationmark.triangle", image_color: .indigo, text_color: .indigo, Topic: "Sleep Apnea", update_time: Report_Screen_Data.Sleep_apnea_update_time, data: Report_Screen_Data.Sleep_apnea,unitt: " ")
                            })
                            Button(action: {
                                self.isHeartRateScreenisActived = true
                            }, label: {
                                insideNavigation(image_name: "heart.fill", image_color: .red, text_color: .red, Topic: "Heartrate", update_time: Report_Screen_Data.Heartrate_update_time, data: Report_Screen_Data.Heartrate,unitt: "bpm")
                            })
                            Button(action: {
                                
                            }, label: {
                                insideNavigation(image_name: "person.wave.2", image_color: .cyan, text_color: .cyan, Topic: "Spo2", update_time: Report_Screen_Data.Spo2_update_time, data: Report_Screen_Data.Spo2,unitt: "%")
                            })
                            Button(action: {
                                
                            }, label: {
                                insideNavigation(image_name: "person.and.background.dotted", image_color: .green, text_color: .green, Topic: "Sleep posture", update_time: Report_Screen_Data.Spo2_update_time, data: Report_Screen_Data.Spo2,unitt: "%")
                            })
                        }
                    }.navigationTitle("Overall night")
                }
                
            }).navigationTitle("Overall night")
        }.onAppear(perform: {
            ReportScreen_viewModel.fetchData()
        })
    }
}


struct Bruxism_timeline: View{
    @State private var favoriteColor = 0
    var body: some View{
        VStack{
            List{
                VStack{
                    Picker("What is your favorite color?", selection: $favoriteColor) {
                        Text("Now").tag(0)
                        Text("7 Days").tag(1)
                        Text("10 Days").tag(2)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}


struct Heart_rate_View: View{
    @ObservedObject var HeartRate_Now_ChartScreen_ViewModel = HeartRate_Now_Chart_ViewModel()
    @ObservedObject var HeartRate_7D_ChartScreen_ViewModel = HeartRate_7D_Chart_ViewModel()
    @ObservedObject var HeartRate_10D_ChartScreen_ViewModel = HeartRate_10D_Chart_ViewModel()
    var avg_today:[Int] = []
    @State private var showScreenHeart = 0
    var body: some View{
        VStack{
            GeometryReader{ geo in
                ScrollView{
                    Section(header: EmptyView()){
                        VStack{
                            Picker("", selection: $showScreenHeart) {
                                Text("Now").tag(0)
                                Text("7 Days").tag(1)
                                Text("10 Days").tag(2)
                            }.padding([.top, .leading, .trailing]).pickerStyle(.segmented)
                            if showScreenHeart == 0{
                                VStack{
                                    VStack{
                                        HStack{
                                            Text("AVG.")
                                                .opacity(0.5)
                                                .fontDesign(.rounded)
                                            Spacer()
                                        }
                                        HStack{
                                            Text("201")
                                                .font(.title)
                                                .fontDesign(.rounded)
                                                .bold()
                                            Text("bpm")
                                                .font(.body)
                                                .fontDesign(.rounded)
                                            Spacer()
                                        }
                                    }
                                    HStack{
                                        Text("Today")
                                            .opacity(0.5)
                                            .fontDesign(.rounded)
                                        Spacer()
                                    }
                                }.padding(.leading)
                                Chart{
                                    ForEach(HeartRate_Now_ChartScreen_ViewModel.items, id: \.id) { items in
                                        LineMark(
                                            x: .value("Time", ConvertStringToDate(items.dat_time)!),
                                            y: .value("bpm", items.heart_rate)
                                        )
                                    }
                                }.frame(height: geo.size.width/1.5)
                                    .foregroundColor(.red)
                                    .padding(.all)
                                    .chartXAxis{
                                        AxisMarks(values: .stride(by: .hour)) { value in
                                            AxisGridLine()
                                            AxisValueLabel(format: .dateTime.hour().minute())
                                        }
                                    }
                            }else if showScreenHeart == 1{
                                Chart{
                                    ForEach(HeartRate_7D_ChartScreen_ViewModel.items, id: \.id) { items in
                                        LineMark(
                                            x: .value("Time", ConvertStringToDate(items.dat_time)!),
                                            y: .value("bpm", items.heart_rate)
                                        )
                                    }
                                }.frame(height: geo.size.width/1.5)
                                    .foregroundColor(.red)
                                    .padding(.all)
                                    .chartXAxis{
                                        AxisMarks(values: .stride(by: .hour)) { value in
                                            AxisGridLine()
                                            AxisValueLabel(format: .dateTime.day().month())
                                        }
                                    }
                                
                            }else if showScreenHeart == 2{
                                Chart{
                                    ForEach(HeartRate_10D_ChartScreen_ViewModel.items, id: \.id) { items in
                                        LineMark(
                                            x: .value("Time", ConvertStringToDate(items.dat_time)!),
                                            y: .value("bpm", items.heart_rate)
                                        )
                                    }
                                }.frame(height: geo.size.width/1.5)
                                    .foregroundColor(.red)
                                    .padding(.all)
                                    .chartXAxis{
                                        AxisMarks(values: .stride(by: .hour)) { value in
                                            AxisGridLine()
                                            AxisValueLabel(format: .dateTime.day().month())
                                        }
                                    }
                            }
                        }
                    }.listStyle(.grouped)
                    
                }.navigationTitle("Heart Rate")
                    .listStyle(GroupedListStyle())
                    .navigationBarTitleDisplayMode(.inline)
                    .labelsHidden()
                    .statusBarHidden()
                    .accessibilityHidden(true)
            }
        }.onAppear(perform: {
            HeartRate_Now_ChartScreen_ViewModel.fetchData()
            HeartRate_7D_ChartScreen_ViewModel.fetchData()
            HeartRate_10D_ChartScreen_ViewModel.fetchData()
        })
    }
    func ConvertStringToDate(_ StringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: StringDate) // replace Date String
    }
}


struct insideNavigation:View{
    var image_name: String
    var image_color: Color
    var text_color: Color
    var Topic: String
    var update_time: String
    var data: Int
    var unitt: String
    var body: some View{
        VStack{
            HStack{
                if image_name == "null"{
                    Image("mouth")
                        .resizable()
                    .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                        .foregroundStyle(image_color)
                }else{
                    Image(systemName:image_name)
                        .foregroundStyle(image_color)
                }
                Text(Topic)
                    .fontDesign(.rounded)
                    .foregroundColor(text_color)
                Spacer()
                Text("Last update: ")
                    .fontDesign(.rounded)
                    .opacity(0.5)
                    .foregroundColor(.black)
                Text(update_time.replacingOccurrences(of: ".", with: ":"))
                    .opacity(0.5)
                    .foregroundColor(.black)
                Image(systemName: "chevron.forward")
                    .foregroundColor(.black)
                    .opacity(0.5)
            }
            HStack{
                Text(String(data))
                    .foregroundColor(.black)
                    .font(.title)
                    .bold()
                    .fontDesign(.rounded)
                VStack{
                    Text(unitt)
                        .foregroundColor(.black)
                        .padding(.top, 4.0)
                        .fontDesign(.rounded)
                        .opacity(0.5)
                }
                Spacer()
            }
        }
    }
}
struct Report_View_2_Previews: PreviewProvider {
    static var previews: some View {
        Report_View_2()
    }
}


struct Heart_rate_View_Previews: PreviewProvider {
    static var previews: some View {
        Heart_rate_View()
    }
}


struct Brux_timeline_Previews: PreviewProvider {
    static var previews: some View {
        Bruxism_timeline()
    }
}


struct insideNavigation_Previews: PreviewProvider {
    static var previews: some View {
        insideNavigation(image_name: "heart.fill", image_color: .red, text_color: .red, Topic: "Bruxism", update_time: "21:00", data: 21,unitt: "step")
    }
}
