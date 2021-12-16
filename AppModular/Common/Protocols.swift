//
//  Protocols.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 04/11/2021.
//
import UIKit
import Foundation

protocol ButtonOnCellDelegate{
    func buttonTouchedOnCell(tableRow: TrackTableViewCell)
    func cargarCanciones()
}

protocol TracksPickerDelegate {
    func addTrack(track: Track)
    func cargarCanciones()
}

protocol ButtonSignInDelegate{
    func continueButtonFromDelegate()
    func errorFromDelegate(mensaje:String)
}

protocol ButtonSignUpDelegate{
    func registerButtonFromDelegate()
    func errorFromDelegate(mensaje:String)
}

/*protocol TrackTableViewModelDelegate{
    func cargarCanciones()
}*/
