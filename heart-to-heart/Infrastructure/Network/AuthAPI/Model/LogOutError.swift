enum LogOutError: Int {
    case InvalidAccessToken = -1
    case ExpiredAccessToken = -2
    case NoAccessTokenInBody = -3
    case NetworkTimeOutError = -4
    case UnknownError = -5
}
