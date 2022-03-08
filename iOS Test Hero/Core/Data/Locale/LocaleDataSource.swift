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
  
}
