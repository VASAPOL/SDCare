//
//  Time_View.swift
//  SDCare
//
//  Created by Vasapol Aurean on 14/3/2566 BE.
//

import SwiftUI
import AVKit

struct Time_UP: View {
    @State private var isblue = true
    @State var audioPlayer3: AVAudioPlayer!
    var body: some View {
            ZStack{
                VStack{
                    HStack{
                        Button(action: {
                            self.audioPlayer3.play()
                        }, label: {
                            AnalogClockView(foregroundColor: .constant(Color(red: 0.1, green: 0.1, blue: 0.6)))
                                .shadow(radius: 100)
                                .padding()
                        })
                    }
                    
                    ScrollView{
                        UPchannel(Color_Blackground: .indigo , text: "Do you want to turn the smart alarm on")
                            .padding(.horizontal)
                            .onAppear(perform: {
                                isblue.toggle()
                            })
                    }
                }
            }
            .navigationTitle("Smart Alarm⏰")
            .onAppear(perform: {
                let sound3 = Bundle.main.path(forResource: "Alam Audio", ofType: "mp3")
                self.audioPlayer3 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound3!))
            })
        
    }
}

struct Time_UP_Previews: PreviewProvider {
    static var previews: some View {
        Time_UP()
    }
}
struct UPchannel:View{
    @State private var alarmTime: Date = (UserDefaults.standard.object(forKey: "setted_date") as? Date) ?? Date.now
    @State private var isAlarmOn: Bool = UserDefaults.standard.bool(forKey: "isAlamOn")
    @State private var alarmRange1: String = ""
    @State private var alarmRange: String = ""
    let customSound = UNNotificationSound(named: UNNotificationSoundName("Alam Audio.mp3"))
    let Color_Blackground:Color
    let text: String
    @State var Switch = UserDefaults.standard.bool(forKey: "Switch")
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
                Toggle("", isOn: $Switch)
                    .onChange(of: Switch){ unused in
                        UserDefaults.standard.set(Switch,forKey: "Switch")
                    }
                    
            }.padding(.all)
        }
        if Switch{
            VStack {
                if !isAlarmOn {
                    Text("Set Alarm Time")
                        .font(.title)
                        .padding()
                    DatePicker("Alarm Time", selection: $alarmTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding()
                }
                
                Button(action: {
                    self.isAlarmOn.toggle()
                    UserDefaults.standard.set(isAlarmOn ,forKey: "isAlamOn")
                    updateAlarmRangeOK()
                    if (isAlarmOn){
                        UserDefaults.standard.set(alarmTime, forKey: "setted_date")
                        let content = UNMutableNotificationContent()
                        content.title = "SDCare"
                        content.subtitle = "Wakeup!"
                        content.sound = customSound

                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(Int(alarmTime.timeIntervalSinceNow)), repeats: false)

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                    }else{
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }
                }) {
                    Text(isAlarmOn ? "Turn Off Alarm" : "Turn On Alarm")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(isAlarmOn ? Color.cyan : Color.green)
                        .cornerRadius(10)
                }
                .padding()
                
                if isAlarmOn {
                    VStack{
                        
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                                    .shadow(radius: 10)
                                    .frame(height: 100)
                                HStack{
                                    Text(alarmRange)
                                        .font(.title)
                                }
                            }
                        }
                        Text("Your Alarm Range").font(Font.system(size: 20))
                            .multilineTextAlignment(.leading)
                    }
                }
            }.onAppear(perform: {
                if (isAlarmOn == true){
                    updateAlarmRangeOK()
                }
            })
        }
    }
    private func updateAlarmRangeOK() {
        if isAlarmOn {
            let modifiedAlarmTime = Calendar.current.date(byAdding: .hour, value: -1, to: alarmTime)!
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            // let timeDifference = Date().timeIntervalSince(modifiedAlarmTime) / 3600
            
            alarmRange = "\(formatter.string(from: modifiedAlarmTime)) - \(formatter.string(from: alarmTime))"
            //if timeDifference >= 6 && timeDifference <= 8 {
            //alarmRange1 = "Good"
            //} else if timeDifference < 6 {
            //alarmRange1 = "Sleep more"
            // } else {
            //alarmRange1 = "Too much sleep"
            //}
            
        } else {
            alarmRange1 = ""
        }
    }
    
    
}
