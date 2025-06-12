//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-05.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 2
    //case Popular =  3
    case Upcoming = 3
   // case TopRated = 5
    case YTVideos = 1
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
   

//    let sectionTitles: [String] = ["Trending Movies","Trending Tv", "Popular", "Upcoming Movies","YT Videos"]
    let sectionTitles: [String] = ["Trending Videos","Most Liked Videos","Suggestions"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureNavbar()
        //getTrendingTvs()
       // getTopLikedVideoTest()
        APICaller.shared.ViewVideo(with: "1gycJH2fjPk") { result in
            
        }
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        configureHeroHeader()
    }
    
    private func getTopLikedVideoTest(){
        APICaller.shared.fetchVideos { result in
            switch result {
                  case .success(let videos):
                      // Process the videos
                print("Fetched videos: \(videos[0].snippet.title)")
                  case .failure(let error):
                      // Handle the error
                      print("Failed to fetch videos: \(error)")
                  }
        }
    }
    private func configureHeroHeader(){
        APICaller.shared.getTrendingMovies {[weak self] result in
            switch result {
            case .success(let titles):
                let selectedtitle = titles.randomElement()
                self?.randomTrendingMovie = selectedtitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedtitle?.original_title ?? "", posterURL: selectedtitle?.poster_path ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
//    private func configureNavbar(){
//       // var image = UIImage(named:"Netflix")
//        var image = UIImage(named: "Logo")
//        guard let image = image?.withRenderingMode(.alwaysOriginal) else {
//            print("Failed to load Netflix logo")
//            return
//        }
//        
//        
//        //image = image?.sd_resizedImage(with: .zero, scaleMode: .aspectFill)
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
//        navigationItem.rightBarButtonItems = [
//            UIBarButtonItem(title:"Swashray", style: .done, target: self, action: nil),
//           // UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
//        ]
//        navigationController?.navigationBar.tintColor = .white
//    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Check if the user interface style has changed
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // Reconfigure the navigation bar based on the new appearance
            configureNavbar()
            homeFeedTable.reloadData()
        }
    }

    
    private func configureNavbar() {
        // Load the Netflix logo image
        let originalImage: UIImage
            
            // Check the interface style (dark or light mode) and load the respective logo
            if traitCollection.userInterfaceStyle == .dark {
                guard let blackLogo = UIImage(named: "WhiteLogo") else {
                    print("Failed to load black Netflix logo")
                    return
                }
                originalImage = blackLogo
            } else {
                guard let whiteLogo = UIImage(named: "BlackLogo") else {
                    print("Failed to load white Netflix logo")
                    return
                }
                originalImage = whiteLogo
            }
//        guard let originalImage = UIImage(named: "BlackLogo") else {
//            print("Failed to load Netflix logo")
//            return
//        }

        let targetSize = CGSize(width: 30, height: 30)
        let resizedImage = resizeImage(image: originalImage, targetSize: targetSize)
        let finalImage = resizedImage.withRenderingMode(.alwaysOriginal)

        let logoItem = UIBarButtonItem(image: finalImage, style: .plain, target: self, action: nil)

        navigationItem.leftBarButtonItem = logoItem

        navigationItem.rightBarButtonItems = [
//            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
//            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
            UIBarButtonItem(title: "Swashray", style: .done, target: self, action: nil)
                        
        ]

        if traitCollection.userInterfaceStyle == .dark {
                navigationController?.navigationBar.barTintColor = .black // Background color for dark mode
                navigationController?.navigationBar.tintColor = .white    // Tint color for dark mode (icons)
            } else {
                navigationController?.navigationBar.barTintColor = .white // Background color for light mode
                navigationController?.navigationBar.tintColor = .black    // Tint color for light mode (icons)
            }


        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = nil
    }

    // Helper function to resize the image
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Determine the scale factor that preserves aspect ratio
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        
        // Create a new image context and draw the resized image
        UIGraphicsBeginImageContextWithOptions(scaledImageSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
    


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
//    private func getTrendingTvs(){
////        APICaller.shared.getTrendingMovies{
////            results in
////            switch results{
////            case.success(let movies):
////                print(movies)
////            case .failure(let error):
////                print(error)
////            }
////        }
////        APICaller.shared.getTrendingTvs { results in
////            //
////        }
////        APICaller.shared.getUpcomoingMovies { _ in
////            //
////        }
////        APICaller.shared.getPopular{ _ in
////            //
////        }
//        APICaller.shared.getTopRated{ _ in
//            //
//        }
//    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return  UITableViewCell()}
        
        // Set the parent view controller
        cell.parentViewController = self
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.fetchMostViewVideos { result in
                switch result{
                case.success(let Video):
                    cell.homeConfigure(with: Video)
                        //print(result)
                case.failure(let error):
                    print(error.localizedDescription)
                    print("Error fetching top liked videos: \(error.localizedDescription)")
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.fetchVideos { result in
                switch result{
                case.success(let Video):
                    cell.homeConfigure(with: Video)
                        //print(result)
                case.failure(let error):
                    print(error.localizedDescription)
                    print("Error fetching top liked videos: \(error.localizedDescription)")
                }
            }
           
        case Sections.YTVideos.rawValue:
                        APICaller.shared.fetchVideos { result in
                            switch result{
                            case.success(let Video):
                                cell.homeConfigure(with: Video)
                                    //print(result)
                            case.failure(let error):
                                print(error.localizedDescription)
                                print("Error fetching top liked videos: \(error.localizedDescription)")
                            }
                        }
            
            
//        case Sections.Popular.rawValue:
//            APICaller.shared.fetchVideos { result in
//                switch result{
//                case.success(let Video):
//                    cell.homeConfigure(with: Video)
//                        //print(result)
//                case.failure(let error):
//                    print(error.localizedDescription)
//                    print("Error fetching top liked videos: \(error.localizedDescription)")
//                }
//            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomoingMovies{ result in
                switch result{
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
//        case Sections.TopRated.rawValue:
//            APICaller.shared.getTopRated{ result in
//                switch result{
//                case.success(let titles):
//                    cell.configure(with: titles)
//                case.failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
    
        default:
           return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header  = view  as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
       // header.textLabel?.textColor = .black
        if traitCollection.userInterfaceStyle == .dark {
                header.textLabel?.textColor = .white  // Light text for dark mode
            } else {
                header.textLabel?.textColor = .black  // Dark text for light mode
            }
        header.textLabel?.text = header.textLabel?.text?.capitalizedFirstLetter()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}


extension HomeViewController: CollectionViewTableViewCellDelegate  {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async{ [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
