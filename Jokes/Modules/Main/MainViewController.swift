//
//  MainViewController.swift
//  Jokes
//
//  Created by mac on 10.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    // MARK: - Properties
    
    var jokeList: JokeListViewController = {
        let controller = JokeListViewController()
        controller.tabBarItem = UITabBarItem(title: "JOKE LIST", image: AppImage.Tabbar.jokeList.image, selectedImage: nil)
       
        return controller
    }()
    
    var myJokes: MyJokesViewController = {
           let controller = MyJokesViewController()
           controller.tabBarItem = UITabBarItem(title: "MY JOKES", image: AppImage.Tabbar.myJokes.image, selectedImage: nil)
          
           return controller
    }()
    
    var settings: SettingsViewController = {
           let controller = SettingsViewController()
           controller.tabBarItem = UITabBarItem(title: "Settings", image: AppImage.Tabbar.settings.image, selectedImage: nil)
          
           return controller
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: myJokes), UINavigationController(rootViewController: jokeList), UINavigationController(rootViewController: settings)]
        selectedIndex = 1
    }    
}
