//
//  DetailPresenter.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import Combine
import Alamofire

class DetailPresenter: ObservableObject {
  
  @Published var hero: HeroModel
  
  @Published var similarHeroes: HeroModels = []
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let useCase: DetailUseCase
  
  init(useCase: DetailUseCase) {
    self.useCase = useCase
    self.hero = useCase.getHero()
  }
  
  func fetchSimilarHeroes() {
    self.useCase.fetchSimilarHeroes(hero)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
          case .finished:
            print("DONE")
          case .failure(let error):
            print("TASK ERROR: \(error.localizedDescription)")
        }
      } receiveValue: { heroes in
        self.similarHeroes = heroes
      }
      .store(in: &cancellables)
  }
  
}
