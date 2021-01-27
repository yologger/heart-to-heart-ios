import ObjectMapper

struct UpdateAvatarImageSuccessResponse: Mappable {
    
    var code: Int?
    var message: String?
    var url: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code    <- map["code"]
        message <- map["message"]
        url     <- map["url"]
    }
}
