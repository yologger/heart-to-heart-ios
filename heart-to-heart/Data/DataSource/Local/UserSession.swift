struct UserSession: Codable {
    var email: String
    var profile: Profile
    var tokens: Tokens
}
