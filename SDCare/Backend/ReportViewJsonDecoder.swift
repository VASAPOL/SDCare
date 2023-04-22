//
//  ReportViewJsonDecoder.swift
//  SDCare
//
//  Created by Vasapol Aurean on 26/3/2566 BE.
//

import Foundation


struct Report_Decoder: Identifiable, Decodable {
    let id: Int
    let Bruxism: Int
    let Brux_update_time: String
    let Sleep_Phase: Int
    let Sleep_Phase_update_time: String
    let Snoring: Int
    let Snoring_update_time: String
    let Sleep_apnea: Int
    let Sleep_apnea_update_time: String
    let Heartrate: Int
    let Heartrate_update_time: String
    let Spo2: Int
    let Spo2_update_time: String
    let Sleep_posture: Int
    let Sleep_posture_update_time: String
}

class Report_ViewModel: ObservableObject {
  @Published var items = [Report_Decoder]()
  func fetchData() {
    let api = "http://"+serverAddr+"/report_view.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([Report_Decoder].self, from: data)
           DispatchQueue.main.async {
              self.items = result
           }
         } else {
           print("No data")
         }
      } catch (let error) {
          print(data as Any)
         print(error.localizedDescription)
      }
     }.resume()
  }
}


