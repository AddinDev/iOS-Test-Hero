//
//  HomePresenter.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  @Published var heroes: HeroModels = []

  private var cancellables: Set<AnyCancellable> = []
  
  @Published var selectedRole = 0
  @Published var selectedSort = 0

  let roles = ["All", "Carry", "Disabler", "Durable", "Escape", "Initiator", "Jungler", "Nuker", "Pusher", "Support"]
  let sorts = ["By ID", "By Name", "By Name Ascending"]
  
  private let router = HomeRouter()
  
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
  
  func changeRole(_ number: Int) {
    selectedRole = number
  }
  
  func changeSort(_ number: Int) {
    selectedSort = number
  }
  
  func linkBuilder<Content: View>(for hero: HeroModel, @ViewBuilder content: () -> Content) -> some View {
    return NavigationLink(destination: router.makeDetailView(for: hero)) { content() }
  }
  
}
