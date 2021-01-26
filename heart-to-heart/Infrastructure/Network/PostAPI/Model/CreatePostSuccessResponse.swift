import ObjectMapper

struct CreatePostSuccessResponse: Mappable {
    
    var code: Int?
    var message: String?
    var data: CreatePostSuccessResponseData?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code    <- map["code"]
        message <- map["message"]
        data    <- map["data"]
    }
}
