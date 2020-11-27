//
//  Weather.swift
//  WeatherCombine
//
//  Created by pbhaskar on 24/11/20.
//

import Foundation

struct WeatherResponse: Decodable {
  let main: Weather
}


struct Weather: Decodable {
  
  let temp: Double?
  let humidity: Double?
  
  static var placeholder: Weather {
    return Weather(temp: nil, humidity: nil)
  }
}
