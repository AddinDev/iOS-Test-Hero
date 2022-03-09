//
//  Injection.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import RealmSwift

final class Injection {
  
  private func provideRepository() -> Repository {
    let realm = try? Realm()
    let locale: LocaleDataSourceProtocol = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSourceProtocol = RemoteDataSource.sharedInstance
    return Repository(locale: locale, remote: remote)
  }
  
  func provideHome() -> HomeUseCase {
    return HomeInteractor(provideRepository())
  }
  
}
