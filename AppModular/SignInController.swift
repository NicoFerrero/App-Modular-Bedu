//
//  ViewController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 27/10/2021.
//

import UIKit

class SignInController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var tipoError: Int = 0
    let regex = try! NSRegularExpression(pattern: #"([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})"#, options: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "accent")
        logInLabel.textColor = UIColor(named: "primary")
        usernameLabel.textColor = UIColor(named: "primary")
        continueButton.tintColor = UIColor(named: "tertiary")
        signUpButton.tintColor = UIColor(named: "tertiary")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func goToMainViewController() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WelcomeController") as? WelcomeController else {
            print("Error con la vista principal")
            return
        }

      vc.modalPresentationStyle = .fullScreen
      self.present(vc, animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any)->Void {
        self.tipoError = 0
        self.view.endEditing(true)
        guard let username: String = usernameTextField.text else{
            return;
        }
        guard let password: String = passwordTextField.text else{
            return;
        }
        
        if username.isEmpty {
            //VALIDACION USERNAME REQUERIDO
            self.tipoError = 1
            print("El email es un campo requerido")
        } else if username.count < 11 || regex.matches(in:username, options:[], range: NSRange(location: 0, length: username.count)).count != 1{
            //VALIDACION LARGO DE USERNAME Y FORMATO
            self.tipoError = 2
            print("El email debe tener mas de 10 caracteres y un formato valido")
        } else if password.isEmpty{
            //VALIDACION PASSWORD REQUERIDO
            self.tipoError = 3
            print("El password es un campo requerido")
        } else if password.count < 11{
            //VALIDACION LARGO DE PASSWORD
            print("El password debe tener mas de 10 caracteres")
            self.tipoError = 4
        } else{
            //PASO VALIDACIONES
            print("autenticar usuario")
            usernameTextField.text = ""
            passwordTextField.text = ""
            self.goToMainViewController()
        }
    }
    
}

