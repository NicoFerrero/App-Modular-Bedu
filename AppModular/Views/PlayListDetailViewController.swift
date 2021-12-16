//
//  PlayListDetailViewController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 29/11/2021.
//

import UIKit

class PlayListDetailViewController: UIViewController, TracksPickerDelegate {

    let songsList = UITableView()
    var picker: PickerViewModel?
    var playList: PlayListViewModel?
    
    func addTrack(track: Track) {
        self.playList?.insertTrack(track: track)
    }
    
    func cargarCanciones() {
        songsList.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker = PickerViewModel()
        self.playList = PlayListViewModel()
        self.playList?.delegate = self
        self.songsList.dataSource = self.playList!
        self.songsList.delegate = self.playList!
        self.view.backgroundColor = UIColor(named: "accent")
        //PlayList Name
        let playListName = UITextField()
        playListName.placeholder = "Playlist..."
        playListName.translatesAutoresizingMaskIntoConstraints = false
        playListName.backgroundColor = UIColor(named: "primary")?.withAlphaComponent(0.2)
        playListName.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        self.view.addSubview(playListName)
        NSLayoutConstraint.activate([
            playListName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            playListName.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            playListName.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            playListName.heightAnchor.constraint(equalToConstant: 50),
        ])
        //Add Button
        let addButton = UIButton()
        addButton.setImage(UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill"), for: .normal)
        addButton.tintColor = UIColor(named: "tertiary")
        addButton.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        addButton.leadingAnchor.constraint(equalTo: playListName.trailingAnchor, constant: 10).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.addTarget(self, action:#selector(pickSong), for: .touchUpInside)
        //table
        self.songsList.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(songsList)
        self.songsList.topAnchor.constraint(equalTo:playListName.bottomAnchor, constant: 20).isActive = true
        self.songsList.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.songsList.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.songsList.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.songsList.backgroundColor = UIColor(named: "primary")?.withAlphaComponent(0.2)
        self.songsList.register(UITableViewCell.self, forCellReuseIdentifier: "track")
    }
    
    @objc func pickSong() {
        let picker = TracksPickerView (frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2))
        PickerViewModel.delegate = self
        self.view.addSubview(picker)
    }
}
