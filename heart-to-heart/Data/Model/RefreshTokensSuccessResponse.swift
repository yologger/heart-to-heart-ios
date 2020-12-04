import ObjectMapper

struct RefreshTokensSuccessResponse: Mappable {
    var code: Int?
    var message: String?
    var data: RefreshTokensSuccessResponseData?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        code        <- map["code"]
        message     <- map["message"]
        data        <- map["data"]
    }
}


struct RefreshTokensSuccessResponseData: Mappable {
    
    var clientId: String?
    var email: String?
    var nickname: String?
    var accessToken: String?
    var refreshToken: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        clientId        <- map["client_id"]
        email           <- map["email"]
        nickname        <- map["nickname"]
        accessToken     <- map["access_token"]
        refreshToken    <- map["refresh_token"]
    }
}


struct RefreshTokensFailureResponse: Mappable {
    var code: Int?
    var errorMessage: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        code            <- map["code"]
        errorMessage    <- map["error_message"]
    }
}
