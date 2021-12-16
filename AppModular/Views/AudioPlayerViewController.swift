//
//  AudioPlayerViewController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 09/11/2021.
//

import UIKit
import AudioPlayer

class AudioPlayerViewController: UIViewController {
    var isPlaying: Bool!
    //var titlesong: String?
    var cell: TrackTableViewCell?
    var menuButton: UIButton = UIButton(type: .system)
    var cancion: AudioPlayer?
    var volumenSlider: UISlider = UISlider()
    var musicSlider: UISlider? {
        didSet {
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(actualizarTiempo), userInfo: nil, repeats:true)
        }
    }
    var gifAnimation: UIImageView?
    var landscape: NSLayoutConstraint?
    var portrait: NSLayoutConstraint?
    var gifLandscape: NSLayoutConstraint?
    var gifPortrait: NSLayoutConstraint?
    
    @objc func actualizarTiempo(timer: Timer){
        let index = Float(self.cancion!.currentTime)
        self.musicSlider!.setValue(index, animated: true)
        if self.musicSlider!.value >= self.musicSlider!.maximumValue{
            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicSlider = UISlider()
        portrait = volumenSlider.widthAnchor.constraint(equalToConstant: self.view.safeAreaLayoutGuide.layoutFrame.width/2)
        landscape = volumenSlider.widthAnchor.constraint(equalToConstant: self.view.safeAreaLayoutGuide.layoutFrame.height/2)
        view.backgroundColor = UIColor(named: "accent")
        self.isPlaying = true
        self.cancion?.volume = 0.5
        //Label principal
        let label1 = UILabel()
        label1.text = self.cell?.getTitle()
        label1.font = UIFont.systemFont(ofSize: 24)
        label1.translatesAutoresizingMaskIntoConstraints=false
        label1.textAlignment = .center
        label1.textColor = UIColor(named: "primary")
        self.view.addSubview(label1)
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            label1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        //Boton menu
        menuButton.setTitle("", for: .normal)
        menuButton.setImage(UIImage(systemName: "circle.grid.3x3.circle"), for: .normal)
        menuButton.translatesAutoresizingMaskIntoConstraints=false
        menuButton.tintColor = UIColor(named: "tertiary")
        menuButton.showsMenuAsPrimaryAction = true
        menuButton.menu = addMenuItems()
        self.view.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            menuButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        //Label secundaria
        let artistLabel = UILabel()
        artistLabel.text = self.cell?.getArtist()
        artistLabel.font = UIFont.systemFont(ofSize: 16)
        artistLabel.translatesAutoresizingMaskIntoConstraints=false
        artistLabel.textAlignment = .center
        artistLabel.textColor = UIColor(named: "secondary")
        self.view.addSubview(artistLabel)
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 8),
            artistLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        //Play button
        let playButton = UIButton(type: .system)
        playButton.setTitle("Play", for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints=false
        playButton.tintColor = UIColor(named: "tertiary")
        self.view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40)
        ])
        playButton.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        //Stop button
        let stopButton = UIButton(type: .system)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.translatesAutoresizingMaskIntoConstraints=false
        stopButton.tintColor = UIColor(named: "tertiary")
        self.view.addSubview(stopButton)
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 20),
            stopButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        stopButton.addTarget(self, action: #selector(stopMusic), for: .touchUpInside)
        //Music slider
        guard let musicSlider = musicSlider else {return}
        musicSlider.translatesAutoresizingMaskIntoConstraints=false
        musicSlider.tintColor = UIColor(named: "secondary")
        self.view.addSubview(musicSlider)
        NSLayoutConstraint.activate([
            musicSlider.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
            musicSlider.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            musicSlider.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])
        musicSlider.addTarget(self, action: #selector(slider1Touch), for: .valueChanged)
        //Volumen label
        let label2 = UILabel()
        label2.text = "Volumen"
        label2.font = UIFont.systemFont(ofSize: 15)
        label2.translatesAutoresizingMaskIntoConstraints=false
        label2.textColor = UIColor(named: "primary")
        self.view.addSubview(label2)
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 20),
            label2.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40)
        ])
        //Volumen slider
        volumenSlider.translatesAutoresizingMaskIntoConstraints=false
        volumenSlider.value = 0.5
        volumenSlider.tintColor = UIColor(named: "secondary")
        self.view.addSubview(volumenSlider)
        NSLayoutConstraint.activate([
            volumenSlider.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 10),
            volumenSlider.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
        ])
        volumenSlider.addTarget(self, action: #selector(changeVolume), for: .valueChanged)
        //GIF Animation
        if let gifUrl = Bundle.main.url(forResource: "stegosaurus-studio", withExtension: ".gif") {
            let gifAnimationImage = UIImage.animatedImage(withAnimatedGIFURL: gifUrl)
            gifAnimation = UIImageView(image: gifAnimationImage)
            gifAnimation!.translatesAutoresizingMaskIntoConstraints=false
            gifPortrait = gifAnimation!.heightAnchor.constraint(equalToConstant: 150.0)
            gifLandscape = gifAnimation!.heightAnchor.constraint(equalToConstant: 80.0)
            self.view.addSubview(gifAnimation!)
            NSLayoutConstraint.activate([
                gifAnimation!.topAnchor.constraint(equalTo: volumenSlider.bottomAnchor, constant: 20),
                gifAnimation!.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                gifAnimation!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            ])
        } else{
            print("El archivo gif no existe")
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.orientation.isPortrait{
            gifLandscape?.isActive = false
            gifPortrait?.isActive = true
            landscape?.isActive = false
            portrait?.isActive = true
        } else{
            gifPortrait?.isActive = false
            gifLandscape?.isActive = true
            portrait?.isActive = false
            landscape?.isActive = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do{
            if let audioUrl = Bundle.main.url(forResource: "sampleMusic", withExtension: ".mp3") {
                self.cancion = try AudioPlayer(contentsOf: audioUrl)
                self.isPlaying = true
                self.musicSlider!.minimumValue = 0
                self.musicSlider!.maximumValue = Float(self.cancion!.duration)
                self.musicSlider!.isContinuous = true
                self.cancion?.play()
            } else{
                print("El archivo mp3 no existe")
            }
        } catch {
            print("Fallo inicializacion de la cancion")
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.cancion?.stop()
        self.isPlaying = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.cell!._play.performTwoStateSelection()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        self.isPlaying = !self.isPlaying
        if self.isPlaying{
            print("Reproduciendo")
            self.cancion?.play()
        } else{
            print("No reproduciendo")
            self.cancion?.stop()
        }
    }
    
    @objc func playMusic(_ sender:UIButton!) {
        self.cancion?.play()
    }
    
    @objc func stopMusic(_ sender:UIButton!) {
        self.cancion?.stop()
    }
    
    @objc func slider1Touch(_ sender:UISlider!) {
        self.cancion?.stop()
        self.cancion?.currentTime = TimeInterval(sender.value)
        self.cancion?.play()
    }
    
    @objc func changeVolume(_ sender:UISlider!) {
        self.cancion?.volume = sender.value
    }
    
    private func addMenuItems() -> UIMenu{
        var i = 0
        var index = 0
        for track in misTracks{
            if track.song_id == self.cell?.track?.song_id{
                index = i
            }
            i = i + 1
        }
        let love = misTracks[index].loved ? "heart.slash" : "heart"
        let titleLove = misTracks[index].loved ? "Unlove" : "Love"
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Delete from Library", image: UIImage(systemName: "xmark.bin"), attributes: .destructive, handler:{ _ in
                print("Delete from library")
                misTracks.remove(at: index)
                self.cell?.prueba()
                self.dismiss(animated: true, completion: nil)
            }),
            UIAction(title: "Download", image: UIImage(systemName: "arrow.down.circle"), handler:{ _ in
                print("Download")
                DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
            }),
            UIAction(title: "Add to a Playlist...", image: UIImage(systemName: "text.badge.plus"), handler:{ _ in
                print("Add to a Playlist...")
                var i = 0
                var index = 0
                for track in misTracks{
                    if track.song_id == self.cell?.track?.song_id{
                        index = i
                    }
                    i = i + 1
                }
                let playListViewModel = PlayListViewModel()
                print(misTracks[index])
                playListViewModel.insertTrack(track: misTracks[index])
            }),
            UIAction(title: "Share Song...", image: UIImage(systemName: "square.and.arrow.up"), handler:{ _ in
                print("Share Song...")
                // text to share
                let text = "Cancion: \(self.cell?.getTitle() ?? "") | Artista: \(self.cell?.getArtist() ?? "")"
                // set up activity view controller
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
            }),
            UIAction(title: titleLove, image: UIImage(systemName: love), handler:{ _ in
                print("Love")
                let myView = UIView(frame: CGRect(x: (self.view.frame.size.width-150) / 2 , y: (self.view.frame.size.height-150) / 2, width: 150, height: 150))
                myView.backgroundColor = .gray
                myView.alpha = 1
                let imagen = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
                imagen.clipsToBounds = true
                if misTracks[index].loved {
                    imagen.image = UIImage(systemName: "heart.slash")
                } else{
                    imagen.image = UIImage(systemName: "heart")
                }
                imagen.tintColor = .white
                myView.addSubview(imagen)
                self.view.addSubview(myView)
                UIView.animate(withDuration: 2, animations: {
                    myView.alpha = 0
                })
                misTracks[index].loved = !misTracks[index].loved
                self.menuButton.menu = self.addMenuItems()
            })
        ])
        
        return menuItems
    }
}
