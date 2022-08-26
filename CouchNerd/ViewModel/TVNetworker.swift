//
//  TVNetworker.swift
//  CouchNerd
//
//  Created by Jerry Cox on 7/27/22.
//

import Foundation

class TVNetworker: ObservableObject {
    @Published var tvShows: TVShows
    @Published var topTVShows: TVShows
    
    init(tvShows: TVShows, topTVShows: TVShows) {
        self.tvShows = tvShows
        self.topTVShows = topTVShows
    }
    
    func fetchTVShows(query: String)  {
        let TMDBKey = APIKeys().IMDBKey
        let url = URL(string: "https://api.themoviedb.org/3/search/tv?api_key=\(TMDBKey)&language=en-US&page=1&query=\(query)&include_adult=false")!
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
                        let decodedTVShows = try decoder.decode(TVShows.self, from: data)
                        self.tvShows = decodedTVShows
                    } catch let error {
                        print("error decoding:", error)
                    }
                }
            }
        }
         dataTask.resume()
    }
    
    func fetchTopTVShows()  {
        let TMDBKey = APIKeys().IMDBKey
        let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(TMDBKey)&language=en-US&page=1")!
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
                        let decodedTopTVShows = try decoder.decode(TVShows.self, from: data)
                        self.topTVShows = decodedTopTVShows
                    } catch let error {
                        print("error decoding:", error)
                    }
                }
            }
        }
         dataTask.resume()
    }
}
