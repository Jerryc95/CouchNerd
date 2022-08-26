//
//  Network.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/23/22.
//

import SwiftUI

class MovieNetworker: ObservableObject {
    @Published var movies: Movies
    @Published var topMovies: Movies
    
    init(movies: Movies, topMovies: Movies) {
        self.movies = movies
        self.topMovies = topMovies
    }
    
    func fetchMovies(query: String)  {
        let TMDBKey = APIKeys().IMDBKey
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(TMDBKey)&language=en-US&query=\(query)&page=1&include_adult=false")!
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("request error:", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedMovies = try decoder.decode(Movies.self, from: data)
                        self.movies = decodedMovies
                    } catch let error {
                        print("error decoding:", error)
                    }
                }
            }
        }
         dataTask.resume()
    }
    
    func fetchTopMovies()  {
        let TMDBKey = APIKeys().IMDBKey
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(TMDBKey)&language=en-US&page=1")!
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("request error:", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedTopMovies = try decoder.decode(Movies.self, from: data)
                        self.topMovies = decodedTopMovies
                    } catch let error {
                        print("error decoding:", error)
                    }
                }
            }
        }
         dataTask.resume()
    }
}
