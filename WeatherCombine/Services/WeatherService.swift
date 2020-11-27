//
//  WeatherService.swift
//  WeatherCombine
//
//  Created by pbhaskar on 24/11/20.
//

import Foundation
import Combine

class WebService {
  
  func fetch(city: String) -> AnyPublisher<Result<Weather, Error>, Never> {
    
    guard let url = URL(string: String(format: Constants.URLs.weatherUrl, city)) else {
      fatalError("Invalid Url")
    }
    
//    return URLSession.shared.dataTaskPublisher(for: url)
//      .print()
//      .map { $0.data }
//      .decode(type: WeatherResponse.self, decoder: JSONDecoder())
//      .map { $0.main }
//      .receive(on: RunLoop.main)
//      .eraseToAnyPublisher()
    
//    return URLSession.shared.dataTaskPublisher(for: url)
//      .print()
//      .map { $0.data }
//      .decode(as: WeatherResponse.self)
//      .map { $0.main }
//      .receive(on: RunLoop.main)
//      .eraseToAnyPublisher()
    
    return URLSession.shared.dataTaskPublisher(for: url)
      .print()
      .map { $0.data }
      .decode(as: WeatherResponse.self)
      .map { $0.main }
      .receive(on: RunLoop.main)
      .convertToResult()
  }
}

extension JSONDecoder {
  static let snakeCaseConverting: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
}

extension Publisher {
  func decode<T: Decodable>(as type: T.Type = T.self,
                            using decoder: JSONDecoder = .snakeCaseConverting) -> Publishers.Decode<Self, T, JSONDecoder> {
    decode(type: type, decoder: decoder)
  }

  func convertToResult() -> AnyPublisher<Result<Output, Failure>, Never>{
    self.map(Result.success)
      .catch{ Just(.failure($0)) }
      .eraseToAnyPublisher()
  }
}
