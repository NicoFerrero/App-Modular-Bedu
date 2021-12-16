//
//  SignUpViewModel.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 01/12/2021.
//

import Foundation

class SignUpViewModel{
    var tipoError: Int = 0
    var mensajeError = ""
    var parent: ButtonSignUpDelegate?
    
    func registerButton(user:String?){
        self.tipoError = 0
        guard let username: String = user else{
            return;
        }
        if username.isEmpty {
            //VALIDACION USERNAME REQUERIDO
            self.tipoError = 1
            self.mensajeError = "El email es un campo requerido"
            print("El email es un campo requerido")
        } else if username.count < 11 || username.isValidEmail(){
            //VALIDACION LARGO DE USERNAME Y FORMATO
            self.tipoError = 2
            self.mensajeError = "El email debe tener mas de 10 caracteres y un formato valido"
            print("El email debe tener mas de 10 caracteres y un formato valido")
        }
        
        if self.tipoError != 0{
            self.parent?.errorFromDelegate(mensaje: self.mensajeError)
        } else{
            self.parent?.registerButtonFromDelegate()
        }
    }
}
