//
//  ReportViewGraphHeartrateJsonDecoder.swift
//  SDCare
//
//  Created by Vasapol Aurean on 26/3/2566 BE.
//

import Foundation

struct Decode_Chart: Identifiable, Decodable {
    let id: Int
    let dat_time: String
    let data: Int
}

var URL_ADDR = ""

class Chart_Data_Now_ViewModel: ObservableObject {
  @Published var items = [Decode_Chart]()
  func fetchData() {
    let api = "http://"+serverAddr+"/"+URL_ADDR+".json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([Decode_Chart].self, from: data)
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


class Chart_Data_7D_ViewModel: ObservableObject {
  @Published var items = [Decode_Chart]()
  func fetchData() {
    let api = "http://"+serverAddr+"/Decode_Chart.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([Decode_Chart].self, from: data)
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

class Chart_Data_10D_Chart_ViewModel: ObservableObject {
  @Published var items = [Decode_Chart]()
  func fetchData() {
    let api = "http://"+serverAddr+"/Decode_Chart.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
             print(data)
           let result = try JSONDecoder().decode([Decode_Chart].self, from: data)
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


