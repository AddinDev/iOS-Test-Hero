//
//  HomePresenter.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import Combine

class HomePresenter: ObservableObject {
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  @Published var heroes: HeroModels = []

  private var cancellables: Set<AnyCancellable> = []
  
  private let useCase: HomeUseCase
  
  init(_ useCase: HomeUseCase) {
    self.useCase = useCase
  }
  
  func fetchHeroes() {
    isLoading = true
    useCase.fetchHeroes()
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
          case .finished:
            self.isLoading = false
            self.isError = false
            self.errorMessage = ""
          case .failure(let error):
            self.isLoading = false
            self.isError = true
            self.errorMessage = error.localizedDescription
        }
      } receiveValue: { heroes in
        self.heroes = heroes
      }
      .store(in: &cancellables)
  }
  
//  func linkBuilder<Content: View>(for game: GameModel, @ViewBuilder content: () -> Content) -> some View {
//    return NavigationLink(destination: router.makeDetailView(for: game)) { content() }
//  }
  
  
}
