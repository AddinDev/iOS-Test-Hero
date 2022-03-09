//
//  LocaleDataSource.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol {
  func addHeroes(_ heroes: HeroEntities) -> AnyPublisher<Bool, Error>
  func fetchHeroes() -> AnyPublisher<HeroEntities, Error>
}

final class LocaleDataSource {
  
  private let realm: Realm?
  
  init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realm in
    return LocaleDataSource(realm: realm)
  }
  
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
  func addHeroes(_ heroes: HeroEntities) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for hero in heroes {
              realm.add(hero)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func fetchHeroes() -> AnyPublisher<HeroEntities, Error> {
    print("TASK: FETCHING HEROES - LOCALE")
    return Future<HeroEntities, Error> { completion in
      if let realm = self.realm {
        let heroes: Results<HeroEntity> = {
          realm.objects(HeroEntity.self)
            .sorted(byKeyPath: "id", ascending: true)
        }()
        completion(.success(heroes.toArray(ofType: HeroEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }
    .eraseToAnyPublisher()
  }
  
}
