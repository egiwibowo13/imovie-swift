//
//  RemoteDataSource.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {

  func getPopularMovies() -> AnyPublisher<[MovieResponse], Error>
  func getRecommendMovies(movieId: Int) -> AnyPublisher<[MovieResponse], Error>
  
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getPopularMovies() -> AnyPublisher<[MovieResponse], Error> {
    return Future<[MovieResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.popularMovies.url) {
         AF.request(url)
           .validate()
           .responseDecodable(of: MoviesResponse.self) { response in
             switch response.result {
             case .success(let value):
               completion(.success(value.movies))
             case .failure:
               completion(.failure(URLError.invalidResponse))
             }
           }
       }
     }.eraseToAnyPublisher()
    }
  
  func getRecommendMovies(movieId: Int) -> AnyPublisher<[MovieResponse], Error> {
    return Future<[MovieResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.recommendMovies(movieId: movieId).url) {
         AF.request(url)
           .validate()
           .responseDecodable(of: MoviesResponse.self) { response in
            switch response.result {
            case .success(let value):
               completion(.success(value.movies))
            case .failure:
               completion(.failure(URLError.invalidResponse))
             }
           }
       }
     }.eraseToAnyPublisher()
  }

}
