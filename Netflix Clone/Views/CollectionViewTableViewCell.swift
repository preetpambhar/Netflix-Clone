//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-08.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var titles: [Title] = [Title]()
    
    private var Videos: [Video] = [Video]()
    
    weak var parentViewController: UIViewController?

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: 144,
            height: 200
        )
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            TitleCollectionViewCell.self,
            forCellWithReuseIdentifier: TitleCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        contentView.backgroundColor = .systemPink
        contentView.addSubview(
            collectionView
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    required init? (
        coder: NSCoder
    ){
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    public func configure(
        with titles: [Title]
    ){
        self.titles = titles
        DispatchQueue.main.async{ [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    public func homeConfigure(
        with Videos: [Video]
    ){
        self.Videos = Videos
        DispatchQueue.main.async{ [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath){
        DataPersistenceManager.shared.downloadTitleWith(model: Videos[indexPath.row]) { result in
            switch result{
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
      //  print("Downloading \(titles[indexPath.row].original_title)")
    }
}


extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TitleCollectionViewCell.identifier,
            for: indexPath
        ) as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
//        guard let model = titles[indexPath.row].poster_path else {
//            return UICollectionViewCell()
//        }
        
//        cell.configure(
//            with: model
//        )
        
        cell.configure(with: Videos[indexPath.row].snippet.thumbnails.high.url)
        return cell
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return Videos.count
    }
    
    
    //    func collectionView(
    //              _ collectionView: UICollectionView,
    //              cellForItemAt indexPath: IndexPath
    //          ) -> UICollectionViewCell {
    //              guard let cell = collectionView.dequeueReusableCell(
    //                  withReuseIdentifier: TitleCollectionViewCell.identifier,
    //                  for: indexPath
    //              ) as? TitleCollectionViewCell else {
    //                  return UICollectionViewCell()
    //              }
    //              let searchResult = searchResults[indexPath.row]
    //              let thumbnailURL = searchResult.snippet.thumbnails.high.url
    //              cell.configure(with: thumbnailURL)
    //              return cell
    //          }
    //
    //          func collectionView(
    //              _ collectionView: UICollectionView,
    //              numberOfItemsInSection section: Int
    //          ) -> Int {
    //              return searchResults.count
    //          }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(
            at: indexPath,
            animated: true
        )
//        let title = Videos[indexPath.row]
//        let titleName = title.snippet.title
//
//        APICaller.shared.getMovie(with: titleName + "trailer") { [weak self]result in
//            switch result {
//            case .success(let videoElement):
//
//                let title = self?.Videos[indexPath.row]
//                guard let overView = title?.snippet.description else {return}
//                guard let strongSelf = self else {return}
//                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, description: overView)
//                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
//
//            case.failure(let error):
//                print(error.localizedDescription)
//            }
   //     }
        

        
        let video = Videos[indexPath.row]
        let videoPlayerVC = VideoPlayerViewController()
           videoPlayerVC.videoId = video.id.videoId
        videoPlayerVC.videoTitle = video.snippet.title // Set the video title if you want to use it in the player view
        videoPlayerVC.publishedAt = video.snippet.publishedAt
        APICaller.fetchYouTubeVideoDetails(videoId: video.id.videoId) { [weak self] description, _ in
            DispatchQueue.main.async {
                videoPlayerVC.videoDescription = description
                self?.parentViewController?.navigationController?.pushViewController(videoPlayerVC, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?{
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self]_ in
            let downloadAction = UIAction(title: "Watch Later", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
    }
}
