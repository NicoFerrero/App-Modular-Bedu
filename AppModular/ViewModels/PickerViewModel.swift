//
//  PlayListDetailViewModel.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 13/12/2021.
//

import UIKit
class PickerViewModel: NSObject{
    static var delegate:TracksPickerDelegate?
    func addSongToList(index:Int){
        if PickerViewModel.delegate != nil {
            let track = misTracks[index]
            PickerViewModel.delegate?.addTrack(track: track)
        }
    }
    
    func deleteSongFromList(id:Int){
        print("id", id)
    }
}

extension PickerViewModel: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowStr = misTracks[row]
        return rowStr.title
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: misTracks[row].title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}

extension PickerViewModel: UIPickerViewDataSource/*, UIPickerViewDelegate*/{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return misTracks.count
    }
}
