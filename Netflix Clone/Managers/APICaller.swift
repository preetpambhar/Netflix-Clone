//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-15.
//

import Foundation

struct Constants {
    static let API_KEY = "7a9516c5e8af2aad473cc7c246533929"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_Key = "AIzaSyAnrzMV6RpzHc_8avZX8cuMAlVMuC59DJc"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum  APIError: Error{
    case failedToGetData
    case noData
    case invalidResponse
    case decodingError
    case invalidURL
}

class APICaller{
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)")else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try  JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getUpcomoingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
       
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            }
            catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func showChannel(completion: @escaping (Result<VideoElement, Error>) -> Void){
       // let channelID = "UC_x5XG1OV2P6uZZ5FSM9Ttw"
        let channelID = "UCq-Fj5jknLsUf-MWSy4_brA"
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)?part=snippet&channelId=\(channelID)&maxResults=10&order=date&type=video&key=\(Constants.YoutubeAPI_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            }
            catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getTopLikedVideos(completion: @escaping (Result<[Video], Error>) -> Void) {
           let channelID = "UC_x5XG1OV2P6uZZ5FSM9Ttw" // Replace with your channel ID
           guard let url = URL(string: "\(Constants.YoutubeBaseURL)?part=snippet&channelId=\(channelID)&maxResults=10&order=viewCount&type=video&key=\(Constants.YoutubeAPI_Key)") else { return }

           let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
               guard let data = data, error == nil else { return }

               do {
                   let results = try JSONDecoder().decode(VideoResponse.self, from: data)
                   completion(.success(results.items))
               } catch {
                   completion(.failure(error))
               }
           }
           task.resume()
       }
    
//    func getTopLikedVideoTest(completion: @escaping(String) -> Void){
//
//        let channelID = "UC_x5XG1OV2P6uZZ5FSM9Ttw"
//        guard let url = URL(string: "\(Constants.YoutubeBaseURL)?part=snippet&channelId=\(channelID)&maxResults=10&order=viewCount&type=video&key=\(Constants.YoutubeAPI_Key)") else { return }
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//            guard let data = data, error == nil else{
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(SearchListResponse.self, from: data)
//                if let items = response.items {
//                    print(response.items ?? "No items found")
//                } else {
//                    print("Items are missing")
//                }
//            } catch {
//                print("Failed to decode JSON: \(error)")
//            }
//
//        }
//        task.resume()
//    }

//    func getTopLikedVideoTest(completion: @escaping (Result<[Videos], APIError>) -> Void) {
//        let channelID = "UC_x5XG1OV2P6uZZ5FSM9Ttw" // Replace with your channel ID
//        guard let searchURL = URL(string: "\(Constants.YoutubeBaseURL)?part=id&channelId=\(channelID)&maxResults=10&order=viewCount&type=video&key=\(Constants.YoutubeAPI_Key)") else {
//            completion(.failure(.failedToGetData))
//            return
//        }
//
//        let searchTask = URLSession.shared.dataTask(with: URLRequest(url: searchURL)) { data, _, error in
//            if let error = error {
//                completion(.failure(.failedToGetData))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            // Print the raw JSON data
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON Response: \(jsonString)")
//            }
//
//            do {
//                let searchResponse = try JSONDecoder().decode(SearchListResponse.self, from: data)
//                guard let items = searchResponse.items else {
//                    completion(.failure(.noData))
//                    return
//                }
//
//                // Extract video IDs
//                let videoIds = items.compactMap { $0.id?.videoId }
//                self.fetchVideoDetails(videoIds: videoIds, completion: completion)
//            } catch {
//                print("Decoding error: \(error)")  // Print the decoding error for troubleshooting
//                completion(.failure(.failedToGetData))
//            }
//        }
//        searchTask.resume()
//    }
//
//
//    private func fetchVideoDetails(videoIds: [String], completion: @escaping (Result<[Videos], APIError>) -> Void) {
//        let videoIdsString = videoIds.joined(separator: ",")
//        guard let detailsURL = URL(string: "\(Constants.YoutubeBaseURL)?part=snippet&id=\(videoIdsString)&key=\(Constants.YoutubeAPI_Key)") else {
//            completion(.failure(.failedToGetData))
//            return
//        }
//
//        let detailsTask = URLSession.shared.dataTask(with: URLRequest(url: detailsURL)) { data, _, error in
//            if let error = error {
//                completion(.failure(.failedToGetData))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            // Print the raw JSON data
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON Response: \(jsonString)")
//            }
//
//            do {
//                let detailsResponse = try JSONDecoder().decode(SearchListResponse.self, from: data)
//                guard let items = detailsResponse.items else {
//                    completion(.failure(.noData))
//                    return
//                }
//
//                let videos = items.compactMap { item -> Videos? in
//                    guard let videoId = item.id?.videoId,
//                          let title = item.snippet?.title,
//                          let thumbnailURL = item.snippet?.thumbnails?.high?.url else {
//                        return nil
//                    }
//                    return Videos(id: videoId, title: title, thumbnailURL: thumbnailURL)
//                }
//
//                completion(.success(videos))
//            } catch {
//                print("Decoding error: \(error)")  // Print the decoding error for troubleshooting
//                completion(.failure(.failedToGetData))
//            }
//        }
//        detailsTask.resume()
//    }
    private let channelId = "UC54_ux4BnaJwkVFn5M391XQ"
   func fetchVideos(completion: @escaping (Result<[Video], Error>) -> Void) {
            let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=\(channelId)&maxResults=10&order=date&type=video&key=\(Constants.YoutubeAPI_Key)"
       
            guard let url = URL(string: urlString) else {
                completion(.failure(APIError.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(APIError.noData))
                    return
                 }
                
                do {
                    let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
                    completion(.success(videoResponse.items))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    
    func fetchMostViewVideos(completion: @escaping (Result<[Video], Error>) -> Void) {
          let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=\(channelId)&maxResults=10&order=viewCount&type=video&key=\(Constants.YoutubeAPI_Key)"

           guard let url = URL(string: urlString) else {
              completion(.failure(APIError.invalidURL))
              return
          }
          
          URLSession.shared.dataTask(with: url) { data, response, error in
              if let error = error {
                  completion(.failure(error))
                  return
              }
              
              guard let data = data else {
                  completion(.failure(APIError.noData))
                  return
              }
              
              // ✅ Add this block to inspect raw JSON
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("📦 Raw JSON:\n\(jsonString)")
                    }
              
              do {
                let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
                completion(.success(videoResponse.items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func ViewVideo(with videoId: String, completion: @escaping (Result<Video, Error>) -> Void) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else {return}
    
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data
            else {
                            return
                        }
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    static func fetchYouTubeVideoDetails(videoId: String, completion: @escaping (_ description: String, _ publishedAt: String?) -> Void) {
        let urlString = "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=\(videoId)&key=\(Constants.YoutubeAPI_Key)"
            
            guard let url = URL(string: urlString) else {
                print("❌ Invalid URL.")
                completion("No description available", "")
                return
            }

            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("❌ Error: \(error)")
                    completion("No description available", "")
                    return
                }

                guard let data = data else {
                    print("❌ No data")
                    completion("No description available","")
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let items = json["items"] as? [[String: Any]],
                       let snippet = items.first?["snippet"] as? [String: Any],
                       let description = snippet["description"] as? String,
                       let publishedAt = snippet["publishedAt"] as? String {
                        completion(description, publishedAt)
                        //print (description)
                    } else {
                        completion("No description available", "")
                    }
                    
                } catch {
                    print("❌ JSON error: \(error)")
                    completion("No description available", "")
                }
            }.resume()
        }
}
