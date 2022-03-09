//
//  HomeUseCase.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import Combine

protocol HomeUseCase {
  func fetchHeroes() -> AnyPublisher<HeroModels, Error>
}

class HomeInteractor {
  
  private let repository: RepositoryProtocol
  
  init(_ repository: RepositoryProtocol) {
    self.repository = repository
  }
  
}

extension HomeInteractor: HomeUseCase {
  
  func fetchHeroes() -> AnyPublisher<HeroModels, Error> {
    return self.repository.fetchHeroes()
  }
  
}
