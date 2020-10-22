protocol SessionRepository: BaseRepository {
    
    func test()
    
    func signUp(email: String, firstname: String, lastname: String,  nickname: String, password: String)
}
