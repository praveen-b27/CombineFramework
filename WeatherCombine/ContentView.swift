//
//  ContentView.swift
//  WeatherCombine
//
//  Created by pbhaskar on 24/11/20.
//

import SwiftUI
import Combine

struct ContentView: View {
  
  @State var temperature: String
  @State var cityName: String = ""
  var webservice: WebService = WebService()
  @State var cancellable: AnyCancellable?
  
    var body: some View {
      VStack(alignment: .center) {
        TextField("City", text: $cityName) { value in
          print(value)
        } onCommit: {
          print(cityName)
          fetchWeatherTemp()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        
          
        Text(temperature)
          .multilineTextAlignment(.center)
          .font(.largeTitle)
          .padding()
      }
      .padding(.all)
        
    }
  
  func fetchWeatherTemp() {

    cancellable = self.webservice.fetch(city: self.cityName)
      .sink { result in
        switch result {
        case .success(let weather):
          if let temp = weather.temp {
            self.temperature = "\(temp) °F"
          }
        case .failure(_):
          self.temperature = "No data found!"
        }
      }
      
      
//      .catch{ _ in Just(Weather.placeholder)}
//      .map { $0 }
//      .sink { weather in
//        if let temp = weather.temp {
//          self.temperature = "\(temp) °F"
//        } else {
//          self.temperature = "Not able to find"
//        }
//      }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(temperature: "")
    }
}
