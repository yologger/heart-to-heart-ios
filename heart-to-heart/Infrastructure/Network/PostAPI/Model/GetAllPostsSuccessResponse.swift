import ObjectMapper

struct GetAllPostsSuccessResponse: Mappable {
    
    var code: Int?
    var message: String?
    var count: Int?
    var data: GetAllPostsSuccessResponseData?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code        <- map["code"]
        message     <- map["message"]
        count       <- map["count"]
        data        <- map["data"]
    }
}
