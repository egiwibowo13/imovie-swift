//
//  LocaleDataSource.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {

  func getPopularMovies() -> AnyPublisher<[MovieEntity], Error>
  func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error>
  func addMovie(from movie: [MovieEntity]) -> AnyPublisher<Bool, Error>
  func updateMovie(from movie: MovieEntity) -> AnyPublisher<MovieEntity, Error>

}

final class LocaleDataSource: NSObject {

  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }

}

extension LocaleDataSource: LocaleDataSourceProtocol {

  func getPopularMovies() -> AnyPublisher<[MovieEntity], Error> {
    
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(movies.toArray(ofType: MovieEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error> {
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self)
            .filter("isFavorite == true")
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(movies.toArray(ofType: MovieEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addMovie(from movies: [MovieEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
             do {
               try realm.write {
                 for movie in movies {
                   realm.add(movie, update: .all)
                 }
                 completion(.success(true))
               }
             } catch {
               completion(.failure(DatabaseError.requestFailed))
             }
           } else {
             completion(.failure(DatabaseError.invalidInstance))
           }
    }.eraseToAnyPublisher()
  }
  
  func updateMovie(from movie: MovieEntity) -> AnyPublisher<MovieEntity, Error> {
    return Future<MovieEntity, Error> { completion in
      if let realm = self.realm {
             do {
               try realm.write {
                realm.add(movie, update: .modified)
                 completion(.success(movie))
               }
             } catch {
               completion(.failure(DatabaseError.requestFailed))
             }
           } else {
             completion(.failure(DatabaseError.invalidInstance))
           }
    }.eraseToAnyPublisher()
  }

}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
