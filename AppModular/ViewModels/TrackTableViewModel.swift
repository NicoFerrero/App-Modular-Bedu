//
//  TrackTableViewModel.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 01/12/2021.
//

import UIKit
import CoreData

class TrackTableViewModel: NSObject{
    var delegate:ButtonOnCellDelegate?
    let cellIdentifier:String = "reuseIdentifier"
    
    func saveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TrackList")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context?.fetch(request)
            misTracks = [Track]()
            for data in result as! [NSManagedObject]{
                let title = data.value(forKey: "title") as? String ?? ""
                let song_id = data.value(forKey: "song_id") as? String ?? ""
                let album = data.value(forKey: "album") as? String ?? ""
                let genre = data.value(forKey: "genre") as? String ?? ""
                let artist = data.value(forKey: "artist") as? String ?? ""
                let track = Track(title: title, artist: artist, album: album, song_id: song_id, genre: genre)
                misTracks.append(track)
            }
        }catch{
            print("No se guardo la informacion. ", error, " ", error.localizedDescription)
        }
        if misTracks.count < 1{
            self.descargarInfo()
        } else{
            self.delegate?.cargarCanciones()
        }
    }
    
    func descargarInfo(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTable(_:)), name: NSNotification.Name("updateTable"), object: nil)
        let callback: (Bool, [Track]?) -> () = { status, data in
            misTracks = [Track]()
            if let _data = data {
                misTracks = _data
                if let _context = context {
                    //declaramos la entidad sobre la que queremos trabajar
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TrackList")
                    //declaramos el delete request
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    do{
                        //aca se borra la info
                        try appDelegate.persistentStoreCoordinator?.execute(deleteRequest, with: _context)
                    } catch{
                        print(error)
                    }
                    //recorremos los datos para agregarlos a la BD
                    for item in _data{
                        guard let tracksEntity = NSEntityDescription.insertNewObject(forEntityName: "TrackList", into: _context) as? NSManagedObject else{
                            return
                        }
                        //se referencia la propiedad del item con el campo de nuestra entity
                        tracksEntity.setValue(item.artist, forKey: "artist")
                        tracksEntity.setValue(item.title, forKey: "title")
                        tracksEntity.setValue(item.song_id, forKey: "song_id")
                        tracksEntity.setValue(item.genre, forKey: "genre")
                        tracksEntity.setValue(item.album, forKey: "album")
                        do{
                            //aca se guarda la info
                            try _context.save()
                        } catch{
                            print("No se guardo la informacion. ", error, " ", error.localizedDescription)
                        }
                    }
                }
                //despues de que esto pasa la tbar bar se cambia de color
                self.delegate?.cargarCanciones()
            }
        }
        RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs", completionHandler: callback)
        /*let callback:([Track]?,Error?)->()={canciones, error in
            if error != nil{
                print("No se pudieron cargar las canciones")
            } else{
                misTracks = canciones ?? []
                DispatchQueue.main.sync {
                    //despues de que esto pasa la tbar bar se cambia de color
                    self.delegate?.cargarCanciones()
                }
            }
        }
        let api = APIManager()
        api.getMusic(completion: callback)*/
    }
    
    @objc func updateTable(_ notification: Notification) {
        misTracks.append(Track(title: "Mi Cancion", artist: "Mi Artista", album: "Mi Album", song_id: "0", genre: "Mi Genero"))
        self.delegate?.cargarCanciones()
    }
    
    func agregarCanciones(){
        let _ = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: nil)
        }
    }
}

extension TrackTableViewModel: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension TrackTableViewModel: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Le pedimos a tableview una celda y se hace el cast al tipo de celda definido en el register
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TrackTableViewCell else { return UITableViewCell() }
        // Configure the cell...
        let currentTrack = misTracks[indexPath.row]
        cell.track = currentTrack
        cell.parent = self.delegate
        return cell
    }
}
