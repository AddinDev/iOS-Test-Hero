//
//  RemoteDataSource.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol {
  func fetchHeroes() -> AnyPublisher<HeroResponses, Error>
}

final class RemoteDataSource {
    
  init() { }
  
  static let sharedInstance = RemoteDataSource()
  
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func fetchHeroes() -> AnyPublisher<HeroResponses, Error> {
    print("TASK: FETCHING HEROES - REMOTE")
    return Future<HeroResponses, Error> { completion in
      guard let url = URL(string: Api.baseUrl + Api.heroes) else { return }
      AF.request(url)
        .validate()
        .responseDecodable(of: HeroResponses.self) { response in
          switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure(let error):
              completion(.failure(error))
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
}
