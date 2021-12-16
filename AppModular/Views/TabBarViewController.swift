//
//  TabBarViewController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 16/11/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    let tabIconos:[String] = ["music.note", "house", "music.note.list"]
    let tabNames:[String] = ["Canciones", "Home", "Playlist"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearence = UITabBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor(named: "primary")
        self.tabBar.standardAppearance = appearence
        self.tabBar.scrollEdgeAppearance = appearence
        self.tabBar.tintColor = UIColor(named: "secondary")
        var i = 0
        for item in self.tabBar.items! {
            item.image = UIImage(systemName: self.tabIconos[i])
            item.title = self.tabNames[i]
            i+=1
        }
    }
}
