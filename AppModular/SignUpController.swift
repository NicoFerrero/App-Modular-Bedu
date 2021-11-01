//
//  SignUpController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 27/10/2021.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var otherSignUpLabel: UILabel!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    var tipoError: Int = 0
    let regex = try! NSRegularExpression(pattern: #"([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})"#, options: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "accent")
        signUpLabel.textColor = UIColor(named: "primary")
        usernameLabel.textColor = UIColor(named: "primary")
        registerButton.tintColor = UIColor(named: "tertiary")
        dismissButton.tintColor = UIColor(named: "secondary")
        otherSignUpLabel.textColor = UIColor(named: "primary")
    }
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        self.tipoError = 0
        guard let username: String = usernameTextField.text else{
            return;
        }
        if username.isEmpty {
            //VALIDACION USERNAME REQUERIDO
            self.tipoError = 1
            print("El email es un campo requerido")
        } else if username.count < 11 || regex.matches(in:username, options:[], range: NSRange(location: 0, length: username.count)).count != 1{
            //VALIDACION LARGO DE USERNAME Y FORMATO
            self.tipoError = 1
            print("El email debe tener mas de 10 caracteres y un formato valido")
        } else{
            //PASO VALIDACIONES
            print("registrar usuario")
            usernameTextField.text = ""
        }
    }
    @IBAction func facebookButtonAction(_ sender: Any) {
        self.facebookLoginButton.backgroundColor = UIColor(named: "tertiary")
    }
}
