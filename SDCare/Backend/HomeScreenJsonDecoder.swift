//
//  HomeScreenJsonDecoder.swift
//  SDCare
//
//  Created by Vasapol Aurean on 25/3/2566 BE.
//

import Foundation

struct HomeScreen_Text: Identifiable, Decodable {
    let id: Int
    let Bruxism: Int
    let Snoring: Int
    let Sleep_Phase: Int
    let Sleep_Apnea: Int
}

struct GraphItem: Identifiable, Decodable {
    let id: Int
    let SleepType: String
    let Start: String
    let Stop: String
}


class HomeScreen_TextViewModel: ObservableObject {
  @Published var items = [HomeScreen_Text]()
  func fetchData() {
    let api = "http://184.82.207.10:1845/HomeScreen_Info.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
           let result = try JSONDecoder().decode([HomeScreen_Text].self, from: data)
           DispatchQueue.main.async {
              self.items = result
           }
         } else {
           print("No data")
         }
      } catch (let error) {
         print(error.localizedDescription)
      }
     }.resume()
  }
}


class GraphItem_ViewModel: ObservableObject {
  @Published var items = [GraphItem]()
  func fetchData() {
    let api = "http://184.82.207.10:1845/GraphItem.json"
    guard let url = URL(string: api) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      do {
         if let data = data {
           let result = try JSONDecoder().decode([GraphItem].self, from: data)
           DispatchQueue.main.async {
              self.items = result
           }
         } else {
           print("No data")
         }
      } catch (let error) {
         print(error.localizedDescription)
      }
     }.resume()
  }
}


