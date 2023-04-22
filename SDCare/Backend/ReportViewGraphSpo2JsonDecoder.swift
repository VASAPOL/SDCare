//
//  ReportViewGraphSpo2JsonDecoder.swift
//  SDCare
//
//  Created by Vasapol Aurean on 19/4/2566 BE.
//

import Foundation

struct Spo2_Now_Chart: Identifiable, Decodable {
    let id: Int
    let dat_time: String
    let data: Int
}



class Spo2_Now_Chart_ViewModel: ObservableObject {
  @Published var items = [Spo2_Now_Chart]()
  func fetchData() {
    let api = "http://"+serverAddr+"/Spo2_now_Chart.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([Spo2_Now_Chart].self, from: data)
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


class Spo2_7D_Chart_ViewModel: ObservableObject {
  @Published var items = [Spo2_Now_Chart]()
  func fetchData() {
    let api = "http://"+serverAddr+"/Spo2_now_Chart.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([Spo2_Now_Chart].self, from: data)
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

class Spo2_10D_Chart_ViewModel: ObservableObject {
  @Published var items = [Spo2_Now_Chart]()
  func fetchData() {
    let api = "http://"+serverAddr+"/Spo2_now_Chart.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([Spo2_Now_Chart].self, from: data)
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


