import UIKit

extension UIColor {
    var RGBComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
    convenience init(hex: UInt32) {
        let mask = 0x000000FF
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex >> 0) & mask
        
        let red = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue = CGFloat(b) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

var (r, g, b, a) = UIColor.brown.RGBComponents
print("r=\(r), g=\(g), b=\(b), a=\(a)")

var hex: UInt32 = UInt32(r * 255) << 16 + UInt32(g * 255) << 8 + UInt32(b * 255) << 0

var c = UIColor(hex: hex)
if c == UIColor.brown {
    print("the same")
} else {
    print("not the same")
}

