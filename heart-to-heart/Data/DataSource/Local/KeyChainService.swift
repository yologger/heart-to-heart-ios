import Security
import Foundation

class KeyChainService {
    
    let bundleId = Bundle.main.bundleIdentifier
    
    func save(key: String, value: String) {
        
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: bundleId!,
            kSecAttrAccount: key,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        
        // Delete previous value
        SecItemDelete(keyChainQuery)
        
        // Save new value
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "Fail to save token.")
        NSLog("status=\(status)")
    }
    
    func load(key: String) -> String? {
        
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: bundleId!,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        if (status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("Nothing was retrieved from the keychain.")
            return nil
        }
    }
    
    func delete(key: String) {
        
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: bundleId!,
            kSecAttrAccount: key,
        ]
        
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "Fail to delete token")
        NSLog("status=\(status)")
    }
}
