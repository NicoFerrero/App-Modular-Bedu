//
//  String+Extension.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 13/12/2021.
//

import Foundation
public extension String{
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: #"([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})"#, options: [])
        let coincidencias = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return coincidencias.count > 0 ? true : false
    }
}
