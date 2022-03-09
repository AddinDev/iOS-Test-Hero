//
//  Repository.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import Combine

protocol RepositoryProtocol {
  func fetchHeroes() -> AnyPublisher<HeroModels, Error>
}

final class Repository {
  
  typealias Repo = (LocaleDataSourceProtocol, RemoteDataSourceProtocol) -> Repository
  
  fileprivate let locale: LocaleDataSourceProtocol
  fileprivate let remote: RemoteDataSourceProtocol
  
  init(locale: LocaleDataSourceProtocol, remote: RemoteDataSourceProtocol) {
    self.locale = locale
    self.remote = remote
  }
  
  static let sharedInstance: Repo = { locale, remote in
    return Repository(locale: locale, remote: remote)
  }
  
}

extension Repository: RepositoryProtocol {
  
  func fetchHeroes() -> AnyPublisher<HeroModels, Error> {
    return locale.fetchHeroes()
      .flatMap { result -> AnyPublisher<HeroModels, Error> in
        if result.isEmpty {
          return self.remote.fetchHeroes()
            .map { HeroMapper.responseToEntity(responses: $0) }
            .flatMap { self.locale.addHeroes($0) }
            .filter { $0 }
            .flatMap { _ in self.locale.fetchHeroes()
            .map { HeroMapper.entityToDomain(entities: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.fetchHeroes()
            .map { HeroMapper.entityToDomain(entities: $0) }
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
  
}
