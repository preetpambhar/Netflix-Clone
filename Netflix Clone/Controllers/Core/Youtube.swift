//
//  Youtube.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-07-05.
//

import UIKit
import WebKit

class Youtube: UIViewController {
    private let apiKey = "AIzaSyAnrzMV6RpzHc_8avZX8cuMAlVMuC59DJc" // Replace with your YouTube Data API key
        private let channelId = "UC54_ux4BnaJwkVFn5M391XQ" // Replace with the Channel ID
        private var videos: [Video] = []
        private var webView: WKWebView!
    private var cancelButton: UIButton!
        
        private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
            return tableView
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "YouTube Videos"
            view.backgroundColor = .systemBackground
            view.addSubview(tableView)
            
            // Enable large titles
                   navigationController?.navigationBar.prefersLargeTitles = true
                   navigationItem.largeTitleDisplayMode = .always
            
            tableView.dataSource = self
            tableView.delegate = self
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            fetchVideos()
        }
        
        private func fetchVideos() {
            let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=\(channelId)&maxResults=10&order=date&type=video&key=\(apiKey)"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Failed to fetch videos:", error)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                print("Raw JSON response: \(json)")
                            }
//                    let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
//                    self.videos = videoResponse.items
                    
                    do {
                        let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
                        self.videos = videoResponse.items
                        print("Decoded videos: \(self.videos)")
                    } catch {
                        print("Failed to decode:", error)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let decodeError {
                    print("Failed to decode:", decodeError)
                }
            }.resume()
        }
        
        private func playVideo(videoId: String) {
            if webView != nil {
                webView.removeFromSuperview()
                cancelButton.removeFromSuperview()
            }
            
            webView = WKWebView()
            webView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(webView)
            
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                webView.heightAnchor.constraint(equalToConstant: 300)
            ])
            
            let urlString = "https://www.youtube.com/embed/\(videoId)"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
            // Add cancel button
                   cancelButton = UIButton(type: .system)
                   cancelButton.setTitle("Cancel", for: .normal)
                   cancelButton.translatesAutoresizingMaskIntoConstraints = false
                   cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
                   view.addSubview(cancelButton)

                   NSLayoutConstraint.activate([
                       cancelButton.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
                       cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                   ])
        }
    
    @objc private func didTapCancelButton() {
        webView.removeFromSuperview()
        cancelButton.removeFromSuperview()
    }
    }

    extension Youtube: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return videos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
            let video = videos[indexPath.row]
            cell.titleLabel.text = video.snippet.title
            if let url = URL(string: video.snippet.thumbnails.high.url) {
                cell.thumbnailImageView.load(url: url)
            }
            return cell
        }
        // In your view controller where the tableView is implemented
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let video = videos[indexPath.row]
//            playVideo(videoId: video.id.videoId)
            
            let video = videos[indexPath.row]
               let videoPlayerVC = VideoPlayerViewController()
               videoPlayerVC.videoId = video.id.videoId
            videoPlayerVC.videoTitle = video.snippet.title // Set the video title if you want to use it in the player view
                videoPlayerVC.videoDescription = video.snippet.description ?? "No description available"
            videoPlayerVC.publishedAt = video.snippet.publishedAt
            APICaller.fetchYouTubeVideoDetails(videoId: video.id.videoId) { [weak self] description, _ in
                DispatchQueue.main.async {
                    videoPlayerVC.videoDescription = description
                    self?.navigationController?.pushViewController(videoPlayerVC, animated: true)
                }
            }
        }

}
