//
//  Time_View.swift
//  SDCare
//
//  Created by Vasapol Aurean on 14/3/2566 BE.
//

import SwiftUI

struct Time_View: View {
    @State private var isRed = true
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    AnalogClockView(foregroundColor: .constant(Color(red: 0.1, green: 0.1, blue: 0.6)))
                        .shadow(radius: 100)
                        .padding()
                }
                ZStack{
                    //RoundedRectangle(cornerRadius: 10)
                    ScrollView{
                        timeViewChannel(Color_Blackground: isRed ? .blue : .red)
                            .onAppear(perform: {
                                isRed.toggle()
                            })
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}


struct timeViewChannel:View{
    let Color_Blackground:Color
    @State var Switch = false
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color_Blackground)
            HStack{
                HStack{
                    VStack{
                        HStack{
                            Text("04:15 AM")
                                .font(.largeTitle)
                                .bold()
                                .colorInvert()
                            Spacer()
                        }
                        HStack{
                            Text("Duration of sleep: 7 hours")
                                .font(.footnote)
                                .colorInvert()
                            Spacer()
                        }
                        HStack{
                            Text("Receive great sleep. recommend")
                                .font(.footnote)
                                .colorInvert()
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
                Toggle(isOn: $Switch){}
            }.padding(.all)
        }
    }
}

struct Time_View_Previews: PreviewProvider {
    static var previews: some View {
        Time_View()
    }
}
struct timeViewChannel_Previews: PreviewProvider {
    static var previews: some View {
        timeViewChannel(Color_Blackground: .blue)
    }
}
