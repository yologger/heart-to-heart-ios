import ObjectMapper

struct PostImage: Mappable {
    var id: Int?
    var url: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        url     <- map["url"]
    }
}
