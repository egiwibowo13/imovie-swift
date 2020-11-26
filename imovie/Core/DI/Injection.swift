//
//  Injection.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  
  private func provideRepository() -> MovieRepositoryProtocol {
    let realm = try? Realm()

    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return MovieRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
  
  func provideDetail(movie: MovieModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, movie: movie)
  }

}
