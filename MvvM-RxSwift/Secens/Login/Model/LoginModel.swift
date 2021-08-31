



import Foundation

// MARK: - LoginSucessModel
struct LoginSucessModel: Codable {
    let response: String?
    let pk: Int?
    let username, email, token: String?
}

// MARK: - LoginErrorModel
struct LoginErrorModel: Codable {
    let response, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case response
        case errorMessage = "error_message"
    }
}
