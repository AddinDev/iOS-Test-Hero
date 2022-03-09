//
//  iOS_Test_HeroApp.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import SwiftUI

@main
struct iOS_Test_HeroApp: App {
  var body: some Scene {
    
    let homeUseCase = Injection.init().provideHome()
    let homePresenter = HomePresenter(homeUseCase)
    
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
    }
  }
}
