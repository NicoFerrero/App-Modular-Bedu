//
//  SignUpController.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 27/10/2021.
//

import UIKit

class SignUpController: UIViewController, ButtonSignUpDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var otherSignUpLabel: UILabel!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    var viewModel:SignUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "accent")
        signUpLabel.textColor = UIColor(named: "primary")
        usernameLabel.textColor = UIColor(named: "primary")
        registerButton.tintColor = UIColor(named: "tertiary")
        dismissButton.tintColor = UIColor(named: "secondary")
        otherSignUpLabel.textColor = UIColor(named: "primary")
        self.viewModel = SignUpViewModel()
        self.viewModel?.parent = self
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        self.viewModel?.registerButton(user: self.usernameTextField.text ?? "")
    }
    
    @IBAction func facebookButtonAction(_ sender: Any) {
        self.facebookLoginButton.backgroundColor = UIColor(named: "tertiary")
    }
    
    func registerButtonFromDelegate() {
        print("Usuario registrado")
        usernameTextField.text = ""
    }
    
    func errorFromDelegate(mensaje: String) {
        self.MostrarAlertaSimple(mensaje, "Error")
    }
}
