import ObjectMapper

struct User: Mappable {
    
    var nickname: String?
    var email: String?
    var url: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        nickname        <- map["nickname"]
        email           <- map["email"]
        url             <- map["url"]
    }
}
