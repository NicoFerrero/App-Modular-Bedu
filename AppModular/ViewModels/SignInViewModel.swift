//
//  SignInViewModel.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 01/12/2021.
//

import Foundation

class SignInViewModel{
    var parent: ButtonSignInDelegate?
    var tipoError: Int = 0
    let usuarioRegistrado: Registered = Registered()
    var mensajeError = ""
    
    func continueButton(user:String?,password:String?){
        self.tipoError = 0
        guard let user: String = user else{
            return
        }
        guard let password: String = password else{
            return
        }
        if user.isEmpty {
            //VALIDACION USERNAME REQUERIDO
            self.tipoError = 1
            self.mensajeError = "El email es un campo requerido"
            print("El email es un campo requerido")
        } else if user.count < 11 || !user.isValidEmail(){
            //VALIDACION LARGO DE USERNAME Y FORMATO
            self.tipoError = 2
            self.mensajeError = "El email debe tener mas de 10 caracteres y un formato valido"
            print("El email debe tener mas de 10 caracteres y un formato valido")
        } else if password.isEmpty{
            //VALIDACION PASSWORD REQUERIDO
            self.tipoError = 3
            self.mensajeError = "El password es un campo requerido"
            print("El password es un campo requerido")
        } else if password.count < 11{
            //VALIDACION LARGO DE PASSWORD
            self.mensajeError = "El password debe tener mas de 10 caracteres"
            print("El password debe tener mas de 10 caracteres")
            self.tipoError = 4
        } else if self.usuarioRegistrado.user1.user != user || self.usuarioRegistrado.user1.pass != password{
            //USUARIO INVALIDO
            self.tipoError = 5
            self.mensajeError = "El usuario ingresado no se encuentra registrado"
            print("El usuario ingresado no se encuentra registrado")
        }
        
        if self.tipoError != 0{
            self.parent?.errorFromDelegate(mensaje: self.mensajeError)
        } else{
            self.parent?.continueButtonFromDelegate()
        }
    }
}
