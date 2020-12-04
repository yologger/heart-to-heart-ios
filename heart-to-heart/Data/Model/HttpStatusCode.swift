enum HttpStatusCode: Int {
    case susccess = 200
    case badRequest = 400
    case authenticationFailed = 401
    case forbidden = 403
    case notFoundException = 404
    case contentLengthError = 413
    case quotaExceeded = 429
    case systemError = 500
    case endpointError = 503
    case timeout = 504
}
