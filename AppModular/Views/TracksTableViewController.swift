//
//  TracksTableViewController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 03/11/2021.
//
import Foundation
import UIKit

class TracksTableViewController: UITableViewController, ButtonOnCellDelegate{
    
    var viewModel:TrackTableViewModel?
    
    override func viewDidLoad() {
        print("hola")
        super.viewDidLoad()
        self.viewModel = TrackTableViewModel()
        self.viewModel?.delegate = self
        self.tableView.backgroundColor = UIColor(named: "accent")
        //Indicamos a la tabla de que tipo seran las celdas
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: self.viewModel?.cellIdentifier ?? "")
        self.tableView.delegate = self.viewModel!
        self.tableView.dataSource = self.viewModel!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.saveData()
        self.viewModel?.agregarCanciones()
    }
    
    func buttonTouchedOnCell(tableRow: TrackTableViewCell) {
        let audioPlayer = AudioPlayerViewController()
        audioPlayer.cell = tableRow
        self.present(audioPlayer, animated: true, completion: nil)
    }
    
    func cargarCanciones() {
        self.tableView.reloadData()
    }
}
