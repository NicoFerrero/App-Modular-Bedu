//
//  DataManager.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 19/11/2021.
//

import Foundation

class DataManager{
    static func cancionesPorGenero(canciones:[Track])->[Track]{
        return canciones.filter({$0.genre != nil})
    }
}
