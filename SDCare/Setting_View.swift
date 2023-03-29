//
//  setting.swift
//  SDCare
//
//  Created by Vasapol Aurean on 22/3/2566 BE.
//

import SwiftUI
import Photos

struct Setting_View: View {
    @State private var photoPickerIsPresented = false
    @State var pickerResult: [UIImage] = []
    var body: some View {
        NavigationView{
            GeometryReader{geo in
                VStack{
                    HStack{
                        HStack{
                            Button(action: {
                                photoPickerIsPresented = true
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: geo.size.width/2.2, height: geo.size.width/2.2)
                                        .foregroundColor(.black)
                                    ForEach(pickerResult, id: \.self) { uiImage in
                                      Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: geo.size.width/2.2, height: geo.size.width/2.2)
                                            .clipped()
                                            .cornerRadius(15)
                                            .onAppear(perform: {
                                                self.saveImage()
                                            })
                                    }
                                }
                            })
                        }
                        User_Information_View()
                    }
                    Medical_Info()
                    Hospitality_uses()
                }.sheet(isPresented: $photoPickerIsPresented) {
                    PhotoPicker(pickerResult: $pickerResult,
                                isPresented: $photoPickerIsPresented)
                  }
            }
            .padding(.horizontal)
        }
    }
    func saveImage() {
        guard let data = pickerResult[0].jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "KEY")
    }

    func loadImage() {
         guard let data = UserDefaults.standard.data(forKey: "KEY") else { return }
         let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
         let pickerResult = UIImage(data: decoded)
    }
}


struct Medical_Info: View{
    @State private var Height = ""
    @State private var Weight = ""
    @State private var BMI:Double = 0
    var body: some View{
        VStack{
            HStack{
                Text("Medical Information")
                    .bold()
                    .font(.title)
                Spacer()
            }
            HStack{
                Text("Height: ")
                    .bold()
                Text("\(Height) cm")
                Spacer()
            }
            HStack{
                Text("Weight: ")
                    .bold()
                Text("\(Weight) kg")
                Spacer()
            }
            HStack{
                Text("BMI: ")
                    .bold()
                if BMI == 0.00{
                    Text("Unable to calculate")
                }else{
                    Text("\(BMI, specifier: "%.2f")")
                }
                Spacer()
            }
            HStack{
                Text("Alcohol Consumption: ")
                    .bold()
                Text(UserDefaults.standard.string(forKey: "Alcohol Consumption") ?? "Unset")
                Spacer()
            }
            HStack{
                Text("Medical Condition: ")
                    .bold()
                Text(UserDefaults.standard.string(forKey: "Medical Conditions") ?? "Unset")
                Spacer()
            }
            HStack{
                Text("Medical health Condition: ")
                    .bold()
                Text(UserDefaults.standard.string(forKey: "Medical health conditions") ?? "Unset")
                Spacer()
            }
        }.onAppear(perform: {
            Height = UserDefaults.standard.string(forKey: "Height") ?? "Unset"
            Weight = UserDefaults.standard.string(forKey: "Weight") ?? "Unset"
            if let weight = Double(Weight), let height = Double(Height) {
                let prier_tem:Double = height*height
                let bmi:Double = prier_tem/10000
               // print("HE \((height/100) * (height/100))")
                print("BMI: \(weight/bmi)")
                BMI = weight/bmi
            } else {
                print("Invalid input")
            }
        })
    }
}

struct User_Information_View:View{
    @State private var isEditing = false
    @State private var Name = ""
    @State private var Gender = ""
    @State private var DOB = ""
    @State private var Age = ""
    @State private var Location = ""
    @State private var Birth_Day = Date()
    @State private var age = Int()
    var body: some View{
        VStack{
            NavigationLink(destination: Edit_InformationView(), isActive: $isEditing){ EmptyView() }
            HStack{
                Text(Name)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding(.leading)
                Spacer()
                Button(action: {
                    self.isEditing = true
                }, label: {
                    Image (systemName: "square.and.pencil.circle.fill")
                        .scaleEffect(2)
                })
                
            }
            VStack{
                HStack{
                    Text(Gender)
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Spacer()
                }
                HStack{
                    Text(String("\(Birth_Day)").prefix(10))
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Spacer()
                }
                HStack{
                    Text("Age: \(age) years old")
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Spacer()
                }
                HStack{
                    Text(Location)
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Spacer()
                }
            }
            .padding(.leading)
        }.onAppear(perform:{
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: "Date of birth"),
               let decoded = try? decoder.decode(Date.self, from: data) {
                Birth_Day = decoded
            }
            Name = UserDefaults.standard.string(forKey: "Name") ?? "Unset"
            Gender = UserDefaults.standard.string(forKey: "Gender") ?? "Unset"
            Location = UserDefaults.standard.string(forKey: "Location") ?? "Unset"
            let calendar = Calendar.current
            let now = Date()
            let ageComponents = calendar.dateComponents([.year], from: Birth_Day, to: now)
            age =  ageComponents.year ?? 0
            
        })
    }
}


struct Edit_Button<ConfirmView: View>: View {
    let topic: String
    @State private var isButtonClicked = false
    let confirmView: ConfirmView
    @State private var dataFromUser = ""
    let repralce:String
    var body: some View {
        NavigationLink(destination: confirmView,
                       isActive: $isButtonClicked) {
            Button(action: {
                self.isButtonClicked = true
            }, label: {
                HStack{
                    Text(topic)
                        .foregroundColor(.black)
                    Spacer()
                    Text(dataFromUser)
                        .foregroundColor(.black)
                        .opacity(0.5)
                }
            }).onAppear(perform: {
                if (repralce == ""){
                    dataFromUser = UserDefaults.standard.string(forKey: topic) ?? "Unset"
                }else{
                    dataFromUser = String(String(repralce).prefix(10))
                }
            }).onDisappear(perform: {
                if (repralce == ""){
                    dataFromUser = UserDefaults.standard.string(forKey: topic) ?? "Unset"
                }else{
                    dataFromUser = String(String(repralce).prefix(10))
                }
            })
        }
    }
    
}


struct Edit_InformationView:View{
    @State private var textIn = ""
    @State private var didEditName = false
    @State private var selectedDate = Date()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    var body: some View{
        VStack{
            List{
                Edit_Button(topic: "Name", confirmView: Edit_data(topic: "Name"), repralce: "")
                Edit_Button(topic: "Gender", confirmView: List_Selection(topic: "Gender", ListContain: ["Male","Female","Others"]), repralce: "")
                Edit_Button(topic: "Date of birth", confirmView: Date_of_Birth(topic: "Date of birth"), repralce: "\(selectedDate)")
                Edit_Button(topic: "Location", confirmView: Edit_data(topic: "Location"), repralce: "")
                Edit_Button(topic: "Height", confirmView: Edit_data(topic: "Height"), repralce: "")
                Edit_Button(topic: "Weight", confirmView: Edit_data(topic: "Weight"), repralce: "")
                Edit_Button(topic: "Alcohol Consumption", confirmView: List_Selection(topic: "Alcohol Consumption", ListContain: ["Never","Yearly","6 months","3 months","1 months","2 weeks","weekly","Weekend","Everyday","Alcoholic"]), repralce: "")
                Edit_Button(topic: "Medical Conditions", confirmView: List_Selection(topic: "Medical Conditions", ListContain: ["None","Chronic","Bruxism","Snoring","Sleep apnea","Diabete","Other"]), repralce: "")
                Edit_Button(topic: "Medical health conditions", confirmView: List_Selection(topic: "Medical health conditions", ListContain: ["None","Depression","Stress","Bipolar","Other"]), repralce: "")
                
            }
            
        }.onAppear(perform: {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: "Date of birth"),
               let decoded = try? decoder.decode(Date.self, from: data) {
                selectedDate = decoded
            }
        })
        .onDisappear(perform: {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: "Date of birth"),
               let decoded = try? decoder.decode(Date.self, from: data) {
                selectedDate = decoded
            }
        })
    }
    
}

struct Date_of_Birth: View {
    let topic: String
    @State private var selectedDate = Date()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        VStack {
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(WheelDatePickerStyle())
            .padding()
        }.onAppear(perform: {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: topic),
               let decoded = try? decoder.decode(Date.self, from: data) {
                selectedDate = decoded
            }
            
        })
        .onDisappear(perform: {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(selectedDate) {
                UserDefaults.standard.set(encoded, forKey: topic)
            }
        })
    }
}



struct List_Selection:View{
    let topic:String
    var ListContain: [String]
    @State private var Loaded_data = ""
    @State private var selectedItemIndex = 0
    var body: some View{
        VStack {
            Picker("Select an item", selection: $selectedItemIndex) {
                ForEach(0..<ListContain.count) { index in
                    Text(ListContain[index])
                }
            }
            .pickerStyle(.wheel)
        }
        .padding()
        .onAppear(perform: {
            Loaded_data = UserDefaults.standard.string(forKey: topic) ?? "Unset"
            if let pvindex = ListContain.firstIndex(where: { $0 == Loaded_data }) {
                selectedItemIndex = pvindex
            }else {
                selectedItemIndex = 0
            }
        })
        .onDisappear(perform: {
            UserDefaults.standard.set(ListContain[selectedItemIndex], forKey: topic)
        })
    }
}

struct Edit_data:View{
    let topic:String
    @State private var textInput = ""
    var body: some View{
        NavigationView{
            List{
                if (topic == "Height" || topic == "Weight"){
                    TextField(UserDefaults.standard.string(forKey: topic) ?? "Unset", text: $textInput)
                        .onAppear(perform: {
                            textInput = UserDefaults.standard.string(forKey: topic) ?? "Unset"
                        })
                        .keyboardType(.decimalPad)
                        .onDisappear(perform: {
                            if textInput != ""{
                                UserDefaults.standard.set(textInput, forKey: topic)
                            }
                        })
                }else{
                    TextField(UserDefaults.standard.string(forKey: topic) ?? "Unset", text: $textInput)
                        .onAppear(perform: {
                            textInput = UserDefaults.standard.string(forKey: topic) ?? "Unset"
                        })
                        .onDisappear(perform: {
                            if textInput != ""{
                                UserDefaults.standard.set(textInput, forKey: topic)
                            }
                        })
                }
                
            }
        }
    }
}

struct Hospitality_uses: View{
    @State private var isShowingAdd = false
    @State private var Topic_Input = "jhugfdihfomjghkfpekhfdoskdlbnvkodfglfnjkgdopjfknbvckxlv,mkxblgdfmxdklgvbifjvdbfxuhiojrtdfgdoijuv8hirusdnsvz8f"
    @State private var Information_Input = "jhugfdihfomjghkfpekhfdoskdlbnvkodfglfnjkgdopjfknbvckxlv,mkxblgdfmxdklgvbifjvdbfxuhiojrtdfgdoijuv8hirusdnsvz8f"
    var Topic_dat: [String] = UserDefaults.standard.object(forKey: "Hospitality_uses_Topic_Input") as? [String] ?? []
    var Info_Dat: [String] = UserDefaults.standard.object(forKey: "Hospitality_uses_Information_Input") as? [String] ?? []
    var Time_Dat: [String] = UserDefaults.standard.object(forKey: "Hospitality_uses_TimeStamp") as? [String] ?? []
    var body: some View{
        VStack{
            HStack{
                Text("Hospitality uses")
                    .font(.title)
                    .bold()
                Spacer()
            }
            Button(action: {
                self.isShowingAdd = true
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 50)
                        .foregroundColor(.blue)
                    HStack{
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .bold()
                        Text("Add news")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            })
            ForEach(Topic_dat, id: \.self){ sss in
                
            }
        }.sheet(isPresented: $isShowingAdd) {
            NavigationView{
                VStack{
                    HStack{
                        Text("Location :")
                            .bold()
                        Spacer()
                    }.padding(.leading)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                            .opacity(0.1)
                        TextField("Add header detail", text: $Topic_Input)
                            .padding(.horizontal)
                    }.frame(height: 40)
                    .padding(.horizontal)
                        HStack{
                            Text(Date.now.formatted(date: .long, time: .shortened))
                            Spacer()
                        }.padding(.leading)
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.black)
                                .opacity(0.1)
                            VStack{
                                TextField("Add header detail", text: $Information_Input,axis: .vertical)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(nil)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            .padding(.top)
                        }
                        .padding(.horizontal)
                    
                }
                    .navigationBarTitle(Text("Notifications"), displayMode: .inline)
                    .navigationBarItems(trailing:
                                            Button(action: {
                        //self.Topic_dat.append(Topic_Input)
                        self.isShowingAdd = false
                    }) {
                        Text("Save")
                    }
                    )
            }
        }
    }
}

struct Setting_View_Previews: PreviewProvider {
    static var previews: some View {
        Setting_View()
    }
}

struct Medical_Info_Previews: PreviewProvider {
    static var previews: some View {
        Medical_Info()
    }
}

struct Edit_Info_View_Previews: PreviewProvider {
    static var previews: some View {
        Edit_InformationView()
    }
}
