//
//  TracksPickerView.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 29/11/2021.
//

import UIKit

class TracksPickerView: UIView{
    var viewModel:PickerViewModel?
    let picker: UIPickerView = UIPickerView()
        
    override func draw(_ rect: CGRect) {
        let dimension = 30
        picker.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        picker.backgroundColor = UIColor(named: "secondary")
        self.addSubview(picker)
        let removeButton = UIButton(type: .custom)
        removeButton.setBackgroundImage(UIImage(systemName: "x.circle"), for: .normal)
        removeButton.tintColor = .red
        removeButton.frame = CGRect(x: 5, y: 5, width: dimension, height: dimension)
        self.addSubview(removeButton)
        removeButton.addTarget(self, action:#selector(close), for: .touchUpInside)
        let addButton = UIButton(type: .custom)
        addButton.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        addButton.tintColor = .green
        addButton.frame = CGRect(x:Int(rect.width) - (dimension + 5), y: 5, width: dimension, height: dimension)
        self.addSubview(addButton)
        addButton.addTarget(self, action:#selector(add), for: .touchUpInside)
        self.viewModel = PickerViewModel()
        picker.delegate = self.viewModel!
        picker.dataSource = self.viewModel!
    }
    
    @objc func close () {
        self.removeFromSuperview()
    }
    
    @objc func add () {
        let index = picker.selectedRow(inComponent: 0)
        self.viewModel?.addSongToList(index: index)
    }
}
