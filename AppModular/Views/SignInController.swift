//
//  ViewController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 27/10/2021.
//

import UIKit

class SignInController: UIViewController, ButtonSignInDelegate{
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel:SignInViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.backgroundColor = UIColor(named: "accent")
        //logInLabel.textColor = UIColor(named: "primary")
        self.logInLabel.labelEffect(firstColor: UIColor(named: "primary")!, secondColor: UIColor(named: "secondary")!)
        usernameLabel.textColor = UIColor(named: "primary")
        continueButton.tintColor = UIColor(named: "tertiary")
        signUpButton.tintColor = UIColor(named: "tertiary")
        continueButton.botonPrincipal()
        signUpButton.botonSecundario()
        self.setGradientBackground()
        self.viewModel = SignInViewModel()
        self.viewModel?.parent = self
        usernameTextField.addTarget(self, action: #selector(usernameDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        usernameTextField.startInController()
        passwordTextField.startInController()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.usernameTextField.errorAnimated()
        self.passwordTextField.errorAnimated()
    }
    
    func goToMainViewController() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WelcomeController") as? WelcomeController else {
            print("Error con la vista principal")
            return
        }

      vc.modalPresentationStyle = .fullScreen
      self.present(vc, animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        self.viewModel?.continueButton(user: self.usernameTextField.text ?? "",password: self.passwordTextField.text ?? "")
    }
    
    func continueButtonFromDelegate() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        print("deberia viajar")
        performSegue(withIdentifier: "aPantallaPrincipal", sender: nil)
    }
    
    func errorFromDelegate(mensaje: String) {
        self.MostrarAlertaSimple(mensaje, "Error")
        self.usernameTextField.errorAnimated()
        self.passwordTextField.errorAnimated()
    }
    
    @objc func usernameDidChange() {
        self.usernameTextField.sacarError()
    }
    
    @objc func passwordDidChange() {
        self.passwordTextField.sacarError()
    }
}

