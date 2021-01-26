import ObjectMapper

struct GetAllPostsSuccessResponseData: Mappable {
    var posts: [Post]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        posts    <- map["posts"]
    }
}
