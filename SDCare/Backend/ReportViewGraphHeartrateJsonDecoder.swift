//
//  ReportViewGraphHeartrateJsonDecoder.swift
//  SDCare
//
//  Created by Vasapol Aurean on 26/3/2566 BE.
//

import Foundation

struct HeartRate_Now_Chart: Identifiable, Decodable {
    let id: Int
    let dat_time: String
    let heart_rate: Int
}


class HeartRate_Now_Chart_ViewModel: ObservableObject {
  @Published var items = [HeartRate_Now_Chart]()
  func fetchData() {
    let api = "http://184.82.207.10:1845/heartRate_now_Chart.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([HeartRate_Now_Chart].self, from: data)
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


class HeartRate_7D_Chart_ViewModel: ObservableObject {
  @Published var items = [HeartRate_Now_Chart]()
  func fetchData() {
    let api = "http://184.82.207.10:1845/heartRate_now_Chart.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([HeartRate_Now_Chart].self, from: data)
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

class HeartRate_10D_Chart_ViewModel: ObservableObject {
  @Published var items = [HeartRate_Now_Chart]()
  func fetchData() {
    let api = "http://184.82.207.10:1845/heartRate_now_Chart.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([HeartRate_Now_Chart].self, from: data)
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


