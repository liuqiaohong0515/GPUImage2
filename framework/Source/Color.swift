#if canImport(UIKit)
import UIKit
#endif

public struct Color {
    public let redComponent:Float
    public let greenComponent:Float
    public let blueComponent:Float
    public let alphaComponent:Float
    
    public init(red:Float, green:Float, blue:Float, alpha:Float = 1.0) {
        self.redComponent = red
        self.greenComponent = green
        self.blueComponent = blue
        self.alphaComponent = alpha
    }
    
#if os(iOS)
    public init(hexString: String) {
        // Convert to lowercase and remove spaces
        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // remove #
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        //The length must be 6/8
        guard cString.count == 6 || cString.count == 8 else {
            self.redComponent = 0
            self.greenComponent = 0
            self.blueComponent = 0
            self.alphaComponent = 0
            return
        }
        
        // Separate RGBA strings
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var aString = "ff"
        if cString.count == 8 {
            aString = ((cString as NSString).substring(from: 6) as NSString).substring(to: 2)
        }
        // HexString to Int
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0, a:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        Scanner(string: aString).scanHexInt32(&a)
        
        self.redComponent = Float(r) / 255
        self.greenComponent = Float(g) / 255
        self.blueComponent = Float(b) / 255
        self.alphaComponent = Float(a) / 255
        
    }
#endif
    
    public static let black = Color(red:0.0, green:0.0, blue:0.0, alpha:1.0)
    public static let white = Color(red:1.0, green:1.0, blue:1.0, alpha:1.0)
    public static let red = Color(red:1.0, green:0.0, blue:0.0, alpha:1.0)
    public static let green = Color(red:0.0, green:1.0, blue:0.0, alpha:1.0)
    public static let blue = Color(red:0.0, green:0.0, blue:1.0, alpha:1.0)
    public static let transparent = Color(red:0.0, green:0.0, blue:0.0, alpha:0.0)
}
