//
//  SleepView.swift
//  SDCare
//
//  Created by Vasapol Aurean on 2/4/2566 BE.
//

import SwiftUI
import AVKit
import UserNotifications

struct pattern: View{
    let text: String
    let image : String
    @State var audioPlayer: AVAudioPlayer!
    @State var audioPlayer1: AVAudioPlayer!
    @State var is_playing1 = false
    var body: some View{
        VStack{
            HStack{
                Spacer()
                Text(text)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack{
                Button {
                    if is_playing1 == false{
                        self.audioPlayer1.play()
                        self.is_playing1 = true
                    }else{
                        self.audioPlayer1.stop()
                    }
                } label: {
                    Image(image)
                        .resizable()
                        .frame(width: 321, height: 206)
                        .padding(.leading)
                }
            }
        }.onAppear(perform: {
            let sound = Bundle.main.path(forResource: "Pink noise TED", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            let sound1 = Bundle.main.path(forResource: "White Noise 500Hz", ofType: "mp3")
            self.audioPlayer1 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
        })
    }
}
struct pattern1: View{
    let text: String
    let image : String
    @State var audioPlayer: AVAudioPlayer!
    @State var audioPlayer1: AVAudioPlayer!
    @State var is_playing = false
    var body: some View{
        VStack{
            HStack{
                Spacer()
                Text(text)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 255/255, green: 105/255, blue: 180/255))
                Spacer()
            }
            HStack{
                Button {
                    if is_playing == false{
                        self.audioPlayer.play()
                        self.is_playing = true
                    }else{
                        self.audioPlayer.stop()
                    }
                } label: {
                    Image(image)
                        .resizable()
                        .frame(width: 321, height: 206)
                        .padding(.leading)
                }
            }
        }.onAppear(perform: {
            let sound = Bundle.main.path(forResource: "Pink noise TED", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            let sound1 = Bundle.main.path(forResource: "White Noise 500Hz", ofType: "mp3")
            self.audioPlayer1 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
        })
    }
}


struct patternView_Previews: PreviewProvider {
    static var previews: some View {
        pattern(text: "White noise", image: "sleepcycle")
        
    }
}


struct MusicView: View {
    @State private var isblue = true
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ScrollView{
                    pattern(text: "White Noise", image: "white")
                    Spacer()
                        musicchannel(Color_Blackground: .cyan , text: "Do you want to turn white noise automatically")
                            .onAppear(perform: {
                                isblue.toggle()
                            })
                    
                        musicchannelok(Color_Blackground: .cyan , text: "Do you want to turn white noise manually ")
                            .onAppear(perform: {
                            isblue.toggle()
                        })
                    Spacer()
                    Spacer()
                        pattern1(text: "Pink Noise", image: "sleepcycle")
                        musicchannel(Color_Blackground: .cyan , text: "Do you want to turn pink noise on")
                            .onAppear(perform: {
                                isblue.toggle()
                            })
                    .padding(.vertical) }.navigationTitle("Therapy🩺")
            }
        }
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}

struct musicchannel:View{
    let Color_Blackground:Color
    let text: String
    @State var Switch = false
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color_Blackground)
                HStack{
                        VStack{
                            Text(text)
                                .font(.subheadline)
                            .bold()
                            .colorInvert()
                        }
                    Spacer()
                Toggle(isOn: $Switch){}
            }.padding(.all)
        }.padding(.horizontal)
    }
}

struct musicchannelok:View{
    @State var choiceMade = "Options +"
    let Color_Blackground:Color
    let text: String
    @State var Switch = false
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color_Blackground)
                HStack{
                        VStack{
                        Text(text)
                                .font(.subheadline)
                            .bold()
                            .colorInvert()
                        }
                    Spacer()
                Toggle(isOn: $Switch){}
            }.padding(.all)
            
            }.padding(.horizontal)
        VStack{
            if Switch {
                Text("Select Time").font(.body)
                Menu{
                    Button(action: {
                        choiceMade = "15 minutes"
                    }, label: {
                        Text("15 minutes")
                    })
                    Button(action: {
                        choiceMade = "30 minutes"                    }, label: {
                        Text("30 minutes")
                    })
                    Button(action: {
                        choiceMade = "45 minutes"                    }, label: {
                        Text("45 minutes")
                    })
                    Button(action: {
                        choiceMade = "60 minutes"                    }, label: {
                        Text("60 minutes")
                    })
                    
                } label: {
                    Label(
                        title: {Text("\(choiceMade)")},
                        icon: {Image(systemName: "ADD+")}
                        )
                }
                if (choiceMade=="15 minutes"){
                    Text("Playing white noise for 15 minutes")
                }
                if (choiceMade=="30 minutes"){
                    Text("Playing white noise for 30 minutes")
                }
                if (choiceMade=="45 minutes"){
                    Text("Playing white noise for 45 minutes")
                }
                if (choiceMade=="60 minutes"){
                    Text("Playing white noise for 60 minutes")
                }            }
            }
        }
        }
