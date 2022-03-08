//
//  Repository.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import Combine
import RealmSwift

protocol RepositoryProtocol {
  
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
  
  
}
