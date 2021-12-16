//
//  WelcomeController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 30/10/2021.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var bienvenidoLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "accent")
        self.bienvenidoLabel.textColor = UIColor(named: "primary")
        self.logoutButton.tintColor = UIColor(named: "tertiary")
        self.image.image = UIImage(systemName: "brain.head.profile")
        self.image.tintColor = UIColor(named: "secondary")
        self.gestoTap()
        self.gestoPinch()
    }

    @IBAction func logoutButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func gestoTap(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.image.addGestureRecognizer(gesture)
        self.image.isUserInteractionEnabled = true
    }
    
    func gestoPinch(){
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        self.image.addGestureRecognizer(gesture)
        self.image.isUserInteractionEnabled = true
        self.image.isMultipleTouchEnabled = true
    }
    
    @objc func handleTap(){
        let linea1 = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let linea2 = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        let linea3 = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        self.MostrarAlertaSimple("\(linea1)\n\(linea2)\n\(linea3)", "Info")
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer){
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
        guard scale.a > 1.0 else { return }
        guard scale.d > 1.0 else { return }
            
        //con esto solo permito que crezca hasta el doble
        guard scale.a < 2.0 else { return }
        guard scale.d < 2.0 else { return }

        sender.view?.transform = scale
        sender.scale = 1.0
     }
    }
}
