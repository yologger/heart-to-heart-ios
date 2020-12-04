import ObjectMapper

struct GetAllPostsFailureResponse: Mappable {
    
    var code: Int?
    var errorMessage: String?
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        code            <- map["code"]
        errorMessage    <- map["error_message"]
    }
}
