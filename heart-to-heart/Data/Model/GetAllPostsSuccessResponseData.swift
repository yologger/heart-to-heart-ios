import ObjectMapper

struct GetAllPostsSuccessResponseData: Mappable {
    
    var name: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name        <- map["name"]
    }
}
