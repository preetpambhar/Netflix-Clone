//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Preet Pambhar on 2024-06-05.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
       // let vc4 = UINavigationController(rootViewController: UpcomingViewController())
       // let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: DownloadsViewController())
        let vc2 = UINavigationController(rootViewController: Youtube())
        let vc4 = UINavigationController(rootViewController: OptionsViewController())
       
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        //vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        vc4.tabBarItem.image = UIImage(systemName: "ellipsis.circle")
        

        vc1.title = "Home"
        vc2.title = "New Video"
       // vc3.title = "Category"
        vc3.title = "Watch Later"
        vc4.title = "More"
        
        tabBar.tintColor = .label
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }


}

