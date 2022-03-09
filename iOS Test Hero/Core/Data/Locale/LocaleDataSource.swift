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
  func fetchSimilarHeroes(_ hero: HeroEntity) -> AnyPublisher<HeroEntities, Error>
  
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
  
  func fetchSimilarHeroes(_ hero: HeroEntity) -> AnyPublisher<HeroEntities, Error> {
    print("TASK: FETCHING SIMILAR HEROES - LOCALE")
    return Future<HeroEntities, Error> { completion in
      if let realm = self.realm {
        let heroesResult: Results<HeroEntity> = {
          realm.objects(HeroEntity.self)
            .sorted(byKeyPath: "id", ascending: true)
        }()
        let sortedHeroes = self.sortHeroes(heroes: heroesResult.toArray(ofType: HeroEntity.self).filter({$0.id != hero.id}), hero: hero)
        
        let heroes = [sortedHeroes[0], sortedHeroes[1], sortedHeroes[2]]
        print("TASK SIMILAR HEROES: \(heroes)")
        completion(.success(heroes))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }
    .eraseToAnyPublisher()
  }
  
  private func sortHeroes(heroes: HeroEntities, hero: HeroEntity) -> HeroEntities {
    switch hero.primaryAttr {
      case "agi":
        return heroes.sorted(by: { $0.moveSpeed > $1.moveSpeed && $0.roles.contains(hero.roles[Int.random(in: 0..<hero.roles.count)]) && $0.primaryAttr.contains(hero.primaryAttr) })
      case "str":
        return heroes.sorted(by: { $0.baseAttackMax > $1.baseAttackMax && $0.roles.contains(hero.roles[Int.random(in: 0..<hero.roles.count)]) && $0.primaryAttr.contains(hero.primaryAttr )})
      case "int":
        return heroes.sorted(by: { $0.baseMana > $1.baseMana && $0.roles.contains(hero.roles[Int.random(in: 0..<hero.roles.count)]) && $0.primaryAttr.contains(hero.primaryAttr) })
      default:
        return []
    }
  }
  
}
