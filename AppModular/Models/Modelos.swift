//
//  Modelos.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 02/11/2021.
//

import Foundation
import UIKit

struct Account {
    let user: String
    let pass: String
}

struct Registered {
  let user1: Account = Account(user: "nico@gmail.com", pass: "niconiconico")
}

struct Track: Codable, Hashable {
    let title: String
    let artist: String?
    let album: String?
    let song_id: String
    let genre: String?
    var loved:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case artist = "artist"
        case title = "name"
        case album = "album"
        case song_id = "song_id"
        case genre = "genre"
    }
}

enum PlayerStates{
    case play
    case pause
    case next
    case previous
}

var misTracks:[Track] = []

enum MenuOption: Int {
    case BorrarDePlaylist = 0
    case Descargar
    case AgregarAPlaylist
    case Compartir
    case Love
}

/*var misTracks:[Track?] = [
    Track(title:"Like A Rolling Stone", artist:"Bob Dylan", album:"", song_id:"1",genre:"Rock", duration:nil),
    Track(title:"Walk On The Wild Side", artist:"Lou Reed", album:"", song_id:"2",genre:"Rock", duration:nil),
    Track(title:"Hey Joe", artist:"The Jimi Hendrix Experience", album:"", song_id:"3",genre:"Rock", duration:nil),
    Track(title:"Piece Of My Heart", artist:"Big Brother & The Holding Company", album:"", song_id:"4",genre:"Rock", duration:nil),
    Track(title:"Blowin' In The Wind", artist:"Bob Dylan", album:"", song_id:"5",genre:"Rock", duration:nil),
    Track(title:"I Heard It Through The Grapevine", artist:"Creedence Clearwater Revival", album:"", song_id:"1",genre:"Rock", duration:nil),
    Track(title:"Cry Baby", artist:"Janis Joplin", album:"", song_id:"6",genre:"Rock", duration:nil),
    Track(title:"Me And Bobby McGee", artist:"Janis Joplin", album:"", song_id:"7",genre:"Rock", duration:nil),
]*/
