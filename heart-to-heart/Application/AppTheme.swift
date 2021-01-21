import UIKit
import Foundation

enum AppTheme: Int {
    
    case Light
    case Dark
    
    var redColor: UIColor {
        return UIColor(red: 0.8392, green: 0, blue: 0, alpha: 1.0)
    }
    
    var mainColor: UIColor {
        switch self {
        case .Light: return AppColor.Primary.normal
        case .Dark: return AppColor.Secondary.normal
        }
    }
    
    // Customizing NavigationBar
    var navigationBarBackgroundImage: UIImage? {
        switch self {
        case .Light: return UIImage(named: "navigation_bar_background_light.png")
        case .Dark: return UIImage(named: "navigation_bar_background_dark.png")
        }
    }
    var navigationBarTintColor: UIColor {
        switch self {
        case .Light: return AppColor.Primary.normal
        case .Dark: return AppColor.Secondary.normal
        }
    }
    var barStyle: UIBarStyle {
        switch self {
        case .Light: return .default
        case .Dark: return .black
        }
    }
    
    // Customizing TabBar
    var tabBarBackgroundImage: UIImage? {
        switch self {
        case .Light: return UIImage(named: "tab_bar_background_light.png")
        case .Dark: return UIImage(named: "tab_bar_background_dark.png")
        }
    }
    
    var tabBarTintColor: UIColor {
        switch self {
        case .Light: return AppColor.Primary.normal
        case .Dark: return AppColor.Secondary.normal
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .Light:
            return AppColor.Orange.normal
        case .Dark:
            return AppColor.Orange.normal
        }
    }
    
    // Customizing UILabel
    var labelTextColor: UIColor {
        switch self {
        case .Light:
            return AppColor.Black.normal
        case .Dark:
            return AppColor.White.normal
        }
    }
    
    // Customizing UIBarButtonItem
    var barButtonItemColor: UIColor {
        switch self {
        case .Light:
            return AppColor.Primary.normal
        case .Dark:
            return AppColor.Secondary.normal
        }
    }
    
    var switchOnTintColor: UIColor {
        switch self {
        case .Light:
            return AppColor.Primary.normal
        case .Dark:
            return AppColor.Secondary.normal
        }
    }
    
    var switchOnThumbTintColor: UIColor {
        switch self {
        case .Light:
            return AppColor.White.normal
        case .Dark:
            return AppColor.Grey.dark
        }
    }
}

struct ThemeManager {
    
    static var isDarkTheme: Bool {
        get {
            let storedTheme = UserDefaults.standard.integer(forKey: Constant.Key.ThemeKey)
            if (storedTheme == 0) {
                return false
            } else {
                return true
            }
        }
    }
    
    static func currentTheme() -> AppTheme {
        let storedTheme = UserDefaults.standard.integer(forKey: Constant.Key.ThemeKey)
        if (storedTheme == 0) {
            return .Light
        } else {
            return AppTheme(rawValue: storedTheme)!
        }
    }
    
    static func applyTheme(theme: AppTheme) {
        
        UserDefaults.standard.setValue(theme.rawValue, forKey: Constant.Key.ThemeKey)
        UserDefaults.standard.synchronize()
        
        // Initialize App TintColor
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = AppColor.Orange.normal
        
        // Initialize UINavigationBar
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBarBackgroundImage, for: .default)
        // UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        // UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        UINavigationBar.appearance().tintColor = theme.navigationBarTintColor
        
        // Initialize UITabBar
        UITabBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage
        UITabBar.appearance().tintColor = theme.tabBarTintColor
        
        // Initialize UILabel
        UILabel.appearance().textColor = theme.labelTextColor
        
        // Initialize UITextField
        UITextField.appearance().textColor = AppColor.Orange.normal
        
        // Initialize UIBarButtonItem
        UIBarButtonItem.appearance().tintColor = theme.barButtonItemColor
        
        // Initialize UISwitch
        
        UISwitch.appearance().thumbTintColor = theme.switchOnThumbTintColor
        UISwitch.appearance().onTintColor = theme.switchOnTintColor
    }
}
