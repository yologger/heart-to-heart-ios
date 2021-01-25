import ObjectMapper

struct Post: Mappable {
    
    var id: Int?
    var content: String?
    var createdAt: String?
    var userId: Int?
    var user: User?
    var postImages: [PostImage]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        content         <- map["content"]
        createdAt       <- map["createdAt"]
        userId          <- map["userId"]
        user            <- map["user"]
        postImages      <- map["postImages"]
    }
}


