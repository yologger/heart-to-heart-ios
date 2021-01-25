import ObjectMapper

struct LogOutSuccessResponse: Mappable {
    
    var code: Int?
    var message: String?
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        code            <- map["code"]
        message         <- map["message"]
    }
}
