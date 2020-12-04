import ObjectMapper

struct LogInSuccessResponse: Mappable {
    
    var code: Int?
    var data: LogInSuccessResponseData?
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        code        <- map["code"]
        data        <- map["data"]
    }
}
