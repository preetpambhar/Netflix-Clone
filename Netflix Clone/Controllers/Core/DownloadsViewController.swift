//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-05.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var Videos: [VideoItem] = [VideoItem]()
    private var videos: [Video] = []
    private var videoDate: [Video] = [Video]()
    
    private  let downlodedTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Watch Later"
        view.addSubview(downlodedTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        downlodedTable.delegate = self
        downlodedTable.dataSource = self
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
        
    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let videos):
                self?.Videos = videos
                self?.videos = videos.map { videoItem in
                    return Video(
                        id: Video.VideoID(videoId: videoItem.videoID ?? ""),
                            snippet: Video.Snippet(
                            title: videoItem.orignal_title ?? "",
                            description: videoItem.orignal_description ?? "",
                            publishedAt: "",
                            thumbnails: Video.Thumbnail(
                            high: Video.ThumbnailDetail(url: videoItem.poster_url ?? "")
                            )
                        )
                    )
                }
                DispatchQueue.main.async {
                    self?.downlodedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downlodedTable.frame = view.bounds
    }
}


extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = Videos[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: title.orignal_title  ?? "Unknown title name", posterURL: title.poster_url ?? ""))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: Videos[indexPath.row]) {[weak self] result in
                switch result{
                case .success():
                    print( "Deleted from the database")
                case .failure(let error ):
                    print( error.localizedDescription)
                }
                self?.Videos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
               
            }
        default:
            break;
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let title = Videos[indexPath.row]
//
//        guard let videoid = title.videoID else {
//            return
//        }
//
//        APICaller.shared.ViewVideo(with: videoid) {[weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async{
//                    let vc = TitlePreviewViewController()
//                    vc.configure(with: TitlePreviewViewModel(title: titleName, description: title.orignal_description ?? ""))
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        let video = videos[indexPath.row]
        print(video)
           let videoPlayerVC = VideoPlayerViewController()
           videoPlayerVC.videoId = video.id.videoId
        videoPlayerVC.videoTitle = video.snippet.title // Set the video title if you want to use it in the player view
            videoPlayerVC.videoDescription = video.snippet.description ?? "No description available"
        
        videoPlayerVC.publishedAt = video.snippet.publishedAt
        
        APICaller.fetchYouTubeVideoDetails(videoId: video.id.videoId) { [weak self] description, publishedAt in
            DispatchQueue.main.async {
                videoPlayerVC.videoDescription = description
                videoPlayerVC.publishedAt = publishedAt ?? "Unknown date"
                self?.navigationController?.pushViewController(videoPlayerVC, animated: true)
            }
        }
          
    }
}
