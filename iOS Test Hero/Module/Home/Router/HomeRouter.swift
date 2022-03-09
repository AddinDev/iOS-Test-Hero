//
//  HomeRouter.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import SwiftUI

struct HomeRouter {
  
  func makeDetailView(for hero: HeroModel) -> some View {
    let useCase = Injection.init().provideDetail(hero: hero)
    let presenter = DetailPresenter(useCase: useCase)
    return DetailView(presenter: presenter)
  }
  
}
