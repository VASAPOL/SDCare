//
//  setting.swift
//  SDCare
//
//  Created by Vasapol Aurean on 22/3/2566 BE.
//

import SwiftUI

struct Setting_View: View {
    var Date_Of_Birth = [24,08,2006]
    @State private var isEditing = false
    var body: some View {
        NavigationView{
            GeometryReader{geo in
                VStack{
                    NavigationLink(destination: Edit_InformationView(), isActive: $isEditing){ EmptyView() }
                    HStack{
                        HStack{
                            Button(action: {
                                
                            }, label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: geo.size.width/2.2, height: geo.size.width/2.2)
                                    .foregroundColor(.black)
                            })
                        }
                        VStack{
                            HStack{
                                Text("Raceerote Orarit")
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                Spacer()
                                Button(action: {
                                    self.isEditing = true
                                }, label: {
                                    Image (systemName: "square.and.pencil.circle.fill")
                                        .resizable()
                                        .frame(width: geo.size.width/15,height: geo.size.width/15)
                                })
                                
                            }
                            
                            HStack{
                                Text("Male")
                                    .multilineTextAlignment(.leading)
                                    .opacity(0.7)
                                Spacer()
                            }
                            HStack{
                                Text(String(Date_Of_Birth[0])+" / "+String(Date_Of_Birth[1]))
                                    .multilineTextAlignment(.leading)
                                    .opacity(0.7)
                                Text("/"+String(String(Date_Of_Birth[2])))
                                    .multilineTextAlignment(.leading)
                                    .opacity(0.7)
                                Spacer()
                            }
                        }
                        
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}


struct Edit_Button:View{
    let Topic:String
    let Current_Data:String
    var didTapButton: () -> Bool
    var body: some View{
        Button(action: {
            let success = self.didTapButton()
        }, label: {
            HStack{
                Text(Topic)
                    .foregroundColor(.black)
                Spacer()
                Text(Current_Data)
                    .foregroundColor(.black)
                    .opacity(0.5)
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                    .opacity(0.5)
            }
        })
    }
}

struct Edit_InformationView:View{
    @State private var textIn = ""
    @State private var clicked = ""
    var body: some View{
        List{
            Edit_Button(Topic: "Name",Current_Data: "Unknow",didTapButton: $clicked)
            
        }
    }
}

struct Setting_View_Previews: PreviewProvider {
    static var previews: some View {
        Setting_View()
    }
}

struct Edit_Info_View_Previews: PreviewProvider {
    static var previews: some View {
        Edit_InformationView()
    }
}
