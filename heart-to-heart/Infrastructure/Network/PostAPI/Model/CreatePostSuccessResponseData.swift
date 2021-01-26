import ObjectMapper

struct CreatePostSuccessResponseData: Mappable {
    
    var post: Post?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        post    <- map["post"]
    }
}
