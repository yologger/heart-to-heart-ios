import UIKit
import Foundation

extension UIColor {
    
    static func colorFromHexString (_ hex:String) -> UIColor {
        
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


enum AppColor {
    
    enum Primary {
        static var light = UIColor.colorFromHexString("#2128AA")
        static var normal = UIColor.colorFromHexString("#0F1361")
        static var dark = UIColor.colorFromHexString("#01014D")
    }
    
    enum Secondary {
        static var light = UIColor.colorFromHexString("#FD699E")
        static var normal = UIColor.colorFromHexString("#F91C6B")
        static var dark = UIColor.colorFromHexString("#EC0054")
    }
    
    enum White {
        static var normal = UIColor.colorFromHexString("#FFFFFF")
    }
    
    enum Black {
        static var normal = UIColor.colorFromHexString("#000000")
    }
    
    enum Grey {
        static var light = UIColor.colorFromHexString("#B4B4B4")
        static var normal = UIColor.colorFromHexString("#646464")
        static var dark = UIColor.colorFromHexString("#363636")
    }
    
    enum Orange {
        static var normal = UIColor.colorFromHexString("#FF9900")
    }
    
    enum Green {
        static var normal = UIColor.colorFromHexString("#0FBB99")
    }
    
    enum Pink {
        static var normal = UIColor.colorFromHexString("#FF00AC")
    }
    
    enum Blue {
        static var normal = UIColor.colorFromHexString("#008DFF")
    }
}
