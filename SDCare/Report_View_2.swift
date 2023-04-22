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
    @State private var isSpo2isActived = false
    @State private var isBruxismisActived = false
    @State private var isSleepPhraseisActived = false
    @State private var isSnoringisActived = false
    @State private var isSleepApneaisActived = false
    @State private var isSleepPostureisActived = false
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            NavigationView(content: {
                VStack{
                    //NavigationLink(destination: Heart_rate_View().navigationViewStyle(StackNavigationViewStyle()),
                  //                 isActive: $isHeartRateScreenisActived){EmptyView()}
                    NavigationLink(destination: explanationChart(ServerLocation: "spo2_chart", Explanation: "Commonly measured in healthcare settings, such as hospitals and clinics, to monitor a patient's respiratory function and oxygenation status. It is also becoming more prevalent in the general population due to the availability of pulse oximeters, which can be used to measure SpO2 at home or on the go.", Unit: "%").navigationViewStyle(StackNavigationViewStyle()),isActive: $isSpo2isActived){EmptyView()}
                    NavigationLink(destination: explanationChart(ServerLocation: "heartRate_now_Chart", Explanation: "Refers to the number of times the heart beats per minute (bpm). It is a measure of the heart's activity and can be affected by various factors, including physical activity, emotions, and overall health.", Unit: "bpm").navigationViewStyle(StackNavigationViewStyle()),isActive: $isHeartRateScreenisActived){EmptyView()}
                    NavigationLink(destination: explanationChart(ServerLocation: "bruxism_chart", Explanation: "8-31% of adults experience bruxism at some point in their lives, with higher rates reported in certain groups such as people with anxiety or sleep disorders. However, it's important to note that these estimates may not be representative of all populations, and diagnosis of bruxism requires a clinical evaluation by a healthcare professional.", Unit: "").navigationViewStyle(StackNavigationViewStyle()),isActive: $isBruxismisActived){EmptyView()}
                    NavigationLink(destination: explanationChart(ServerLocation: "sleep_phase_chart", Explanation: "The natural state of rest and reduced consciousness that occurs in cycles throughout a 24-hour day. It is a complex physiological process that involves changes in brain activity, heart rate, breathing, and other bodily functions.", Unit: "").navigationViewStyle(StackNavigationViewStyle()),isActive: $isSleepPhraseisActived){EmptyView()}
                    NavigationLink(destination: explanationChart(ServerLocation: "snoring_chart", Explanation: "Common condition that occurs when the flow of air through the mouth and nose is partially obstructed during sleep, causing vibrations of the tissues in the throat. This can result in loud, hoarse, or unpleasant sounds that disrupt the sleep of the snorer or their bed partner.", Unit: "").navigationViewStyle(StackNavigationViewStyle()),isActive: $isSnoringisActived){EmptyView()} // Snoringggggg Misssiiiiisiisisiisi
                    NavigationLink(destination: explanationChart(ServerLocation: "sleep_apnea_chart", Explanation: "Sleep disorder characterized by brief periods during sleep where breathing repeatedly stops and starts. There are two main types of sleep apnea: obstructive sleep apnea (OSA) and central sleep apnea (CSA).", Unit: "").navigationViewStyle(StackNavigationViewStyle()),isActive: $isSleepApneaisActived){EmptyView()}
                    NavigationLink(destination: explanationChart(ServerLocation: "sleep_posture_chart", Explanation: "the position in which a person sleeps. There are three main sleep postures: back, side, and stomach.", Unit: "").navigationViewStyle(StackNavigationViewStyle()),isActive: $isSleepPostureisActived){EmptyView()}
                    List{
                        if let Report_Screen_Data = ReportScreen_viewModel.items.first {
                            Button(action: {
                                self.isBruxismisActived = true
                            }, label: {
                                insideNavigation(image_name: "null", image_color: .red, text_color: .red, Topic: "Bruxism", update_time: Report_Screen_Data.Brux_update_time, data:  Report_Screen_Data.Bruxism,unitt: "")
                            })
                            Button(action: {
                                self.isSleepApneaisActived = true
                            }, label: {
                                insideNavigation(image_name: "bed.double.fill", image_color: .purple, text_color: .purple, Topic: "Sleep Phase", update_time: Report_Screen_Data.Sleep_Phase_update_time, data: Report_Screen_Data.Sleep_Phase,unitt: "")
                            })
                            Button(action: {
                                self.isSnoringisActived = true
                            }, label: {
                                insideNavigation(image_name: "speaker.zzz", image_color: .blue, text_color: .blue, Topic: "Snoring", update_time: Report_Screen_Data.Snoring_update_time, data: Report_Screen_Data.Snoring,unitt: "")
                            })
                            Button(action: {
                                self.isSleepApneaisActived = true
                            }, label: {
                                insideNavigation(image_name: "exclamationmark.triangle", image_color: .indigo, text_color: .indigo, Topic: "Sleep Apnea", update_time: Report_Screen_Data.Sleep_apnea_update_time, data: Report_Screen_Data.Sleep_apnea,unitt: " ")
                            })
                            Button(action: {
                                self.isHeartRateScreenisActived = true
                            }, label: {
                                insideNavigation(image_name: "heart.fill", image_color: .red, text_color: .red, Topic: "Heartrate", update_time: Report_Screen_Data.Heartrate_update_time, data: Report_Screen_Data.Heartrate,unitt: "bpm")
                            })
                            Button(action: {
                                self.isSpo2isActived = true
                            }, label: {
                                insideNavigation(image_name: "person.wave.2", image_color: .cyan, text_color: .cyan, Topic: "Spo2", update_time: Report_Screen_Data.Spo2_update_time, data: Report_Screen_Data.Spo2,unitt: "%")
                            })
                            Button(action: {
                                self.isSleepPostureisActived = true
                            }, label: {
                                insideNavigation(image_name: "person.and.background.dotted", image_color: .green, text_color: .green, Topic: "Sleep posture", update_time: Report_Screen_Data.Spo2_update_time, data: Report_Screen_Data.Spo2,unitt: "%")
                            })
                        }
                    }.navigationTitle("Overall night")
                }
                
            }).navigationTitle("Overall night")
        }.onReceive(timer) { time in
            ReportScreen_viewModel.fetchData()

        }
        .onAppear(perform: {
            ReportScreen_viewModel.fetchData()
        })
    }
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}




struct ChartView: View {
    let spo2Items: [Decode_Chart]
    let geometryHeight: CGFloat

    var body: some View {
        Chart {
            ForEach(spo2Items) { item in
                LineMark(
                    x: .value("Time", convertStringToDate(item.dat_time)!),
                    y: .value("%", item.data)
                )
                //print(item.dat_time)
            }
        }
        .frame(height: geometryHeight / 3)
        .foregroundColor(.red)
        .padding(.all)
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.day().month())
            }
        }
    }

    func convertStringToDate(_ stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: stringDate)
    }
}

struct AVG_Data:View{
    var data:String
    var unit:String
    var body: some View{
        VStack{
            VStack{
                HStack{
                    Text("AVG.")
                        .opacity(0.5)
                        .fontDesign(.rounded)
                    Spacer()
                }
                HStack{
                    Text(data)
                        .font(.title)
                        .fontDesign(.rounded)
                        .bold()
                    Text(unit)
                        .font(.body)
                        .fontDesign(.rounded)
                    Spacer()
                }
            }
            .padding(.leading)
        }
    }
}


struct explanationChart: View{
    var ServerLocation: String
    var Explanation: String
    var Unit:String
    @ObservedObject var ChartDataNow = Chart_Data_Now_ViewModel()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showScreenSpo2 = 0
    var body: some View{
        VStack{
            GeometryReader { geo in
                //ScrollView(showsIndicators: false){
                    Section(header: EmptyView()){
                        VStack{
                            if showScreenSpo2 == 0{
                                AVG_Data(data: "205", unit: Unit)
                                    HStack{
                                        Text("Today")
                                            .opacity(0.5)
                                            .fontDesign(.rounded)
                                        Spacer()
                                    }
                                    .padding(.leading)
                                    ChartView(spo2Items: ChartDataNow.items, geometryHeight: geo.size.height)
                            }
                            ScrollView([.vertical],showsIndicators: false){
                                Text(Explanation)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .fontDesign(.rounded)
                                    .frame(width: geo.size.width)
                            }.background(Color.gray.opacity(0.1))
                                .frame( height: geo.size.height/2)
                        }
                    }
                //}.listStyle(.grouped)
            }
        }
        .onAppear(perform: {
            ChartDataNow.fetchData()
        })
        .onReceive(timer) { time in
            URL_ADDR = ServerLocation
            ChartDataNow.fetchData()
        }
        .navigationBarTitleDisplayMode(.inline)
        
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


struct insideNavigation_Previews: PreviewProvider {
    static var previews: some View {
        insideNavigation(image_name: "heart.fill", image_color: .red, text_color: .red, Topic: "Bruxism", update_time: "21:00", data: 21,unitt: "step")
    }
}
