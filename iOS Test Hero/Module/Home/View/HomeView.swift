//
//  HomeView.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
  @StateObject var presenter: HomePresenter
  
  private let columns: [GridItem] = [
    .init(.flexible()),
    .init(.flexible())
  ]
  
  var body: some View {
    Group {
      content
        .onAppear {
          if presenter.heroes.count == 0 {
            presenter.fetchHeroes()
          }
        }
    }
    .navigationTitle(presenter.roles[presenter.selectedRole])
    .navigationBarItems(trailing:
                        filterButton
    )
  }
}

extension HomeView {
  
  var content: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(presenter.heroes) { hero in
          presenter.linkBuilder(for: hero) {
            HeroItemView(hero: hero)
          }
        }
      }
    }
  }
  
  var filterButton: some View {
    Button(action: {
      
    }) {
      Menu {
        Button("All") { presenter.changeRole(0) }
        Button("Carry") { presenter.changeRole(1) }
        Button("Disabler") { presenter.changeRole(2) }
        Button("Durable") { presenter.changeRole(3) }
      } label: {
        Image(systemName: "ellipsis.circle.fill")
      }

    }
  }
  
}

struct HeroItemView: View {
  var hero: HeroModel
  var body: some View {
    VStack {
      WebImage(url: URL(string: "\(Api.baseUrl + hero.image)"))
        .resizable()
        .scaledToFit()
        .frame(width: UIScreen.main.bounds.width / 2 - 30)
        .cornerRadius(10)
      Text(hero.name)
        .fontWeight(.semibold)
        .foregroundColor(.black)
    }
  }
}

// struct HomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    HomeView()
//  }
// }
