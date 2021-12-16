import UIKit


public extension UILabel {
    func labelEffect(firstColor: UIColor, secondColor: UIColor){
        guard let texto:String = self.text else {return}
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: texto as String)
        for i in 0..<texto.count {
            //print(i)
            if i % 2 == 0 {
                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: firstColor, range: NSRange(location:i,length:1))
            } else{
                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: secondColor, range: NSRange(location:i,length:1))
            }
        }
        self.attributedText = myMutableString
    }
}
