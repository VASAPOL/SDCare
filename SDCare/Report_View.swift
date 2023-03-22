//
//  Report_View.swift
//  SDCare
//
//  Created by Vasapol Aurean on 13/3/2566 BE.
//

import SwiftUI
import Charts

struct Report_View:View{
    var body: some View{
        VStack{
            ScrollView{
                HStack{
                    Text("Report📈")
                        .font(.title)
                        .bold()
                    Spacer()
                }.padding(.horizontal)
                VStack{
                    VStack{
                        Sleep_Phrase(Title: "Sleep Phrase", Detail: "Dicdicate how much good sleep you receive")
                        Normal_Graph(Title: "Heart Rate", Detail: "Monitoring your Heat rate stat from last night")
                        Normal_Graph(Title: "SpO2", Detail: "Monitoring your Heat rate stat from last night")
                        Timeline_View(Title: "Snoring Timeline", Detail: "Illustrate the occur of snoring")
                        Timeline_View(Title: "Bruxism Timeline", Detail: "Illustrate the occur of grinding")
                        Timeline_View(Title: "Sleep apnea Timeline", Detail: "Illustrate the occur of sleep apnea")
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct Snoring_Graph: View {
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
    }
    
}



struct Timeline_View:View{
    let Title:String
    let Detail:String
    @State var geo_spacer_size: CGFloat? = 0
    var body: some View{
        VStack{
            GeometryReader{ geo in
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: geo.size.width,height: geo.size.width)
                            .foregroundColor(.blue)
                            .opacity(0.5)
                        VStack{
                            HStack{
                                Text(Title)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack{
                                Text(Detail)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(hue: 0.63, saturation: 0.604, brightness: 0.714))
                                    .font(.body)
                                Spacer()
                            }
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                                Snoring_Graph()
                                .padding([.top, .leading, .trailing], 2.0)
                                .padding(.top)
                            }
                        }
                        .padding(.all)
                    }
                }.onAppear(perform: {
                    self.geo_spacer_size = geo.size.width
                })
            }
        }.frame(height: geo_spacer_size)
        
    }
}


struct Sleep_Phrase:View{
    let Title:String
    let Detail:String
    @State var geo_spacer_size: CGFloat? = 0
    var body: some View{
        VStack{
            GeometryReader{ geo in
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: geo.size.width,height: geo.size.width)
                            .foregroundColor(.blue)
                            .opacity(0.5)
                        VStack{
                            HStack{
                                Text(Title)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack{
                                Text(Detail)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(hue: 0.63, saturation: 0.604, brightness: 0.714))
                                    .font(.body)
                                Spacer()
                            }
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                                Chart{
                                    LineMark(
                                        x: .value("Mount", "22.00"),
                                        y: .value("Value", 5)
                                    )
                                    LineMark(
                                        x: .value("Mount", "23.00"),
                                        y: .value("Value", 4)
                                    )
                                    LineMark(
                                        x: .value("Mount", "00.00"),
                                        y: .value("Value", 7)
                                    )
                                }
                                .chartYAxis {
                                    AxisMarks(position: .leading)
                                }
                                .padding([.top, .leading, .trailing], 2.0)
                                .padding(.top)
                                VStack{
                                    GeometryReader{geo in
                                        Rectangle_Stage(Color: .orange, Text: "Stage 1")
                                            .frame(height: geo.size.height+8)
                                    }
                                    GeometryReader{geo in
                                        Rectangle_Stage(Color: .black, Text: "Stage 2")
                                            .frame(height: geo.size.height+8)
                                    }
                                    GeometryReader{geo in
                                        Rectangle_Stage(Color: .teal, Text: "Stage 3")
                                            .frame(height: geo.size.height+8)
                                    }
                                    GeometryReader{geo in
                                        Rectangle_Stage(Color: .green, Text: "Stage 4")
                                            .frame(height: geo.size.height-18)
                                    }
                                }
                            }
                        }
                        .padding(.all)
                    }
                }.onAppear(perform: {
                    self.geo_spacer_size = geo.size.width
                })
            }
        }.frame(height: geo_spacer_size)
        
    }
}

struct Rectangle_Stage:View{
    let Color: Color
    let Text: String
    var body: some View{
        ZStack{
            SwiftUI.Text(Text)
                .bold()
                .font(.title2)
            Rectangle()
                .opacity(0.3)
                .foregroundColor(Color)
        }
        .padding(.vertical, 0.0)
    }
}
struct Normal_Graph:View{
    let Title:String
    let Detail:String
    @State var geo_spacer_size: CGFloat? = 0
    var body: some View{
        VStack{
            GeometryReader{ geo in
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: geo.size.width,height: geo.size.width)
                            .foregroundColor(.blue)
                            .opacity(0.5)
                        VStack{
                            HStack{
                                Text(Title)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack{
                                Text(Detail)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(hue: 0.63, saturation: 0.604, brightness: 0.714))
                                    .font(.body)
                                Spacer()
                            }
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                                Chart{
                                    LineMark(
                                        x: .value("Mount", "22.00"),
                                        y: .value("Value", 10)
                                    )
                                    LineMark(
                                        x: .value("Mount", "23.00"),
                                        y: .value("Value", 4)
                                    )
                                    LineMark(
                                        x: .value("Mount", "00.00"),
                                        y: .value("Value", 7)
                                    )
                                }.chartYAxis {
                                    AxisMarks(position: .leading)
                                }//.chartYScale(range: <#T##PositionScaleRange#>)
                                .padding([.top, .leading, .trailing], 2.0)
                                .padding(.top)
                            }
                        }
                        .padding(.all)
                    }
                }.onAppear(perform: {
                    self.geo_spacer_size = geo.size.width
                })
            }
        }.frame(height: geo_spacer_size)
        
    }
}





struct Report_View_Previews: PreviewProvider {
    static var previews: some View {
        Report_View()
    }
}

struct Sleep_Phrase_View: PreviewProvider{
    static var previews: some View{
        Sleep_Phrase(Title: "fff", Detail: "dsds")
            .padding(.horizontal)
    }
}
