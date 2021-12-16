//
//  TrackTableViewCell.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 04/11/2021.
//
import UIKit
import Foundation

class TrackTableViewCell: UITableViewCell{
    var track: Track?
    //puede recibir cualquier elemento que implemente dicho protocolo
    var parent: ButtonOnCellDelegate?
    private let _titulo: UILabel = {
       let lbl = UILabel()
        lbl.textColor = UIColor(named: "primary")
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        return lbl
    }()
    private let _artista: UILabel = {
       let lbl = UILabel()
        lbl.textColor = UIColor(named: "secondary")
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    private let _imagen: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notaMusical")
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor(named: "secondary")
        return image
    }()
    public let _play: PlayButton = {
        let btn = PlayButton()
        btn.icon = UIImage(named: "playButton")
        btn.secondIcon = UIImage(named: "pauseButton")
        btn.performTwoStateSelection()
        btn.tintColor = UIColor(named: "accent")
        btn.backgroundColor = UIColor(named: "primary")
        return btn
    }()
    
    func getTitle()->String{
        guard let title = self.track?.title else { return ""}
        return title
    }
    
    func getArtist()->String{
        let artista = self.track?.artist == "" ? "Sin artista" : self.track?.artist
        return artista!
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor(named: "accent")
        self.addSubview(self._titulo)
        self.addSubview(self._artista)
        self.addSubview(self._imagen)
        self.addSubview(self._play)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self._titulo.frame = CGRect(x: 60, y: 10, width: self.contentView.frame.width-140, height: 20)
        self._artista.frame = CGRect(x: 60, y: self.contentView.frame.height-25, width: self.contentView.frame.width-140, height: 15)
        self._imagen.frame = CGRect(x: 5, y: 5, width: self.contentView.frame.height-10, height: self.contentView.frame.height-10)
        self._play.frame = CGRect(x: self.contentView.frame.width - self.contentView.frame.height, y: 5, width: self.contentView.frame.height-15, height: self.contentView.frame.height-15)
        self._play.layer.cornerRadius = self._play.bounds.size.width / 2
        self._play.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        self._titulo.text = self.track?.title
        self._artista.text = self.track?.artist == "" ? "Sin artista" : self.track?.artist
    }
    
    @objc func playPressed(){
        self._play.performTwoStateSelection()
        self.parent?.buttonTouchedOnCell(tableRow: self)
    }
    
    func prueba(){
        self.parent?.cargarCanciones()
    }
}

