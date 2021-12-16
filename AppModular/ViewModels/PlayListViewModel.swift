//
//  PlayListViewModel.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 13/12/2021.
//

import UIKit
class PlayListViewModel: NSObject{
    var delegate: TracksPickerDelegate?
    static var songs = Set<Track>()
    static var songsArray = [Track]()
    var timer: Timer?
    
    func insertTrack(track: Track){
        PlayListViewModel.songs.insert(track)
        PlayListViewModel.songsArray = Array(PlayListViewModel.songs)
        self.delegate?.cargarCanciones()
    }
}

extension PlayListViewModel: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PlayListViewModel.songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
        cell.backgroundColor = UIColor(named: "secondary")
        let track = PlayListViewModel.songsArray[indexPath.row]
        cell.textLabel?.text = track.title
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        gesture.minimumPressDuration = 0.2
        cell.addGestureRecognizer(gesture)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        
        guard let gestureView = sender.view as? UITableViewCell else {
            return
        }
        if sender.state == UIGestureRecognizer.State.began {
            print("inicio gesture")
            gestureView.backgroundColor = .red
            let titulo = gestureView.textLabel?.text ?? ""
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(prueba(_:)), userInfo: titulo, repeats: true)
        }
        else if sender.state == UIGestureRecognizer.State.ended {
            print("fin gesture")
            gestureView.backgroundColor = UIColor(named: "secondary")
            self.timer?.invalidate()
        }
    }
    
    @objc func prueba(_ sender: Timer){
        var i = 0
        for track in PlayListViewModel.songs {
            if track.title == sender.userInfo as! String{
                PlayListViewModel.songs.remove(track)
                PlayListViewModel.songsArray = Array(PlayListViewModel.songs)
                self.delegate?.cargarCanciones()
            }
            i = i + 1
        }
    }
}

extension PlayListViewModel: UITableViewDelegate{
    
}
