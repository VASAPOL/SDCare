//
//  HomeView.swift
//  SDCare
//
//  Created by Vasapol Aurean on 13/3/2566 BE.
//

import SwiftUI
import Charts

struct HomeView: View{
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
                                    Text("Raveerote Orarit")
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
                                    HStack{
                                        overall_night_Ui(geo_wi: geo.size.width, Header: "Bruxism",Data: 7, color: .orange)
                                        overall_night_Ui(geo_wi: geo.size.width, Header: "Sleep Phase",Data: 8, color: .blue)
                                    }.frame(height: geo.size.width/2)
                                    HStack{
                                        overall_night_Ui(geo_wi: geo.size.width, Header: "Snoring",Data: 7, color: .cyan)
                                        overall_night_Ui(geo_wi: geo.size.width, Header: "Sleep apnea",Data: 8, color: .purple)
                                    }.frame(height: geo.size.width/2)
                                    
                                }
                                Timeline_UI()
                            }
                        }.padding(.horizontal)
                    }
                }
            }
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
                        Button(action: {
                            
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: geo.size.width/3, height: geo.size.width/10)
                                    .foregroundColor(.blue)
                                Text("More")
                                    .foregroundColor(.black)
                                    .colorInvert()
                                    .bold()
                                
                            }
                        })
                        .padding(.bottom)
                    }
                }
            }
            
            HStack{
                Text("Snoring")
                    .font(.title)
                    .bold()
                    .foregroundColor(.cyan)
                Spacer()
                Text("Bruxism")
                    .font(.title)
                    .bold()
                    .foregroundColor(.yellow)
                Spacer()
                VStack{
                    Text("Sleep")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)
                    Text("apnea")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)
                    
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
    var body: some View {
        Chart {
            RuleMark(
                xStart: .value("Start", 0),
                xEnd: .value("End", 9)
            ).foregroundStyle(.red)
            RuleMark(
                xStart: .value("Start", 9),
                xEnd: .value("End", 11)
            ).foregroundStyle(.yellow)
            RuleMark(
                xStart: .value("Start", 11),
                xEnd: .value("End", 20)
            ).foregroundStyle(.blue)
        }
        .frame(height: 250)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
