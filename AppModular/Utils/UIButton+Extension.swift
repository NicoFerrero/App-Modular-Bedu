import UIKit

public extension UIButton {
    func botonPrincipal() {
        layer.cornerRadius = self.frame.size.height / 2
        backgroundColor = UIColor(named: "tertiary")
        tintColor = UIColor(named: "accent")
    }
    
    func botonSecundario() {
        /*tintColor = UIColor(named: "tertiary")
        clipsToBounds = true*/
        backgroundColor = UIColor.clear
        layer.cornerRadius = self.frame.size.height / 2
        layer.borderWidth = 2
        tintColor = UIColor(named: "tertiary")
        layer.borderColor = UIColor(named: "tertiary")?.cgColor
    }
}
