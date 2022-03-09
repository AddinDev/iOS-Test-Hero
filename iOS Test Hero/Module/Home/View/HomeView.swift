//
//  HomeView.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import SwiftUI

struct HomeView: View {
  @StateObject var presenter: HomePresenter
  var body: some View {
    List(presenter.heroes) { hero in
      Text(hero.name)
    }
    .onAppear {
      if presenter.heroes.count == 0 {
        presenter.fetchHeroes()
      }
    }
  }
}

extension HomeView {
  
}

// struct HomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    HomeView()
//  }
// }
