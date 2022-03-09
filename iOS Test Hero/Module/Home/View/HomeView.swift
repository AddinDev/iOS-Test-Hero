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
        ForEach(heroes) { hero in
          presenter.linkBuilder(for: hero) {
            HeroItemView(hero: hero)
          }
        }
      }
    }
  }
  
  var heroes: HeroModels {
    return presenter.selectedRole == 0 ? presenter.heroes : presenter.heroes.filter({$0.roles.contains(presenter.roles[presenter.selectedRole])})
  }
  
  var filterButton: some View {
    Button(action: {
      
    }) {
      Menu {
        ForEach(0..<presenter.roles.count) { i in
          Button(presenter.roles[i]) { presenter.changeRole(i) }.disabled(i == presenter.selectedRole)
        }
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
