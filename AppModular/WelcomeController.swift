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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
