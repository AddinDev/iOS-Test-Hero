//
//  DetailUseCase.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 09/03/22.
//

import Foundation
import Combine

protocol DetailUseCase {
  func getHero() -> HeroModel 
  func fetchSimilarHeroes(_ hero: HeroModel) -> AnyPublisher<HeroModels, Error>
}

class DetailInteractor {
  
  private let repository: RepositoryProtocol
  private let hero: HeroModel
  
  init(_ repository: RepositoryProtocol, hero: HeroModel) {
    self.repository = repository
    self.hero = hero
  }
  
}

extension DetailInteractor: DetailUseCase {
  
  func getHero() -> HeroModel {
    return self.hero
  }
  
  func fetchSimilarHeroes(_ hero: HeroModel) -> AnyPublisher<HeroModels, Error> {
    return self.repository.fetchSimilarHeroes(hero)
  }
  
}
