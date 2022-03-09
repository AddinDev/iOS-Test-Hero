//
//  DetailView.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  @StateObject var presenter: DetailPresenter
  
  private let columns: [GridItem] = [
    .init(.flexible()),
    .init(.flexible()),
    .init(.flexible())
  ]
  
  var body: some View {
    ScrollView {
      content
    }
    .onAppear(perform: {
      presenter.fetchSimilarHeroes()
    })
    .navigationTitle(presenter.hero.name)
  }
}

extension DetailView {
  
  var content: some View {
    VStack(alignment: .leading) {
      WebImage(url: URL(string: "\(Api.baseUrl + presenter.hero.image)"))
        .resizable()
        .scaledToFit()
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding()
      VStack {
        HStack {
          Text("Roles")
            .fontWeight(.semibold)
          Spacer()
        }
        .padding(.horizontal)
        LazyVGrid(columns: columns, alignment: .center) {
          ForEach(presenter.hero.roles, id: \.self) { role in
            HStack {
              Text("✦")
              Text(role)
              Spacer()
            }
          }
        }
        .padding(.horizontal)
      }
      VStack(alignment: .leading) {
        Text("Attack Damage: \(presenter.hero.attackMin)-\(presenter.hero.attackMax)")
        Text("Health: \(presenter.hero.health)")
        Text("Armor: \(presenter.hero.armor)")
        Text("Mana: \(presenter.hero.mana)")
        Text("Speed: \(presenter.hero.speed)")
        Text("Attribute: \(presenter.hero.attackType)")
        Text("Primary: \(presenter.hero.primary)")
      }
      .padding()
      HStack {
        ForEach(presenter.similarHeroes, id: \.id) { hero in
          presenter.linkBuilder(for: hero) {
            WebImage(url: URL(string: "\(Api.baseUrl + hero.image)"))
              .resizable()
              .scaledToFit()
              .cornerRadius(10)
              .shadow(radius: 2)
          }
        }
      }
      .padding()
    }
  }
  
}

// struct DetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    DetailView()
//  }
// }
