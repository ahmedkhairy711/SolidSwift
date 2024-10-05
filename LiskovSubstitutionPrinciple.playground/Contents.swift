import UIKit

// MARK: - Liskov Substitution Principle (LSP)
// Derived or child classes/structures must be substitutable for their base or parent classes.
// meaning if you have a function throw an Error you can create a custom error or throw the default error but the meaning behind that all from Error type.

enum APIError: Error {
    case invalidURL
    case invalidResponse
}

struct MockNetworkService {
    func fetchUser() async throws {
        do {
            throw APIError.invalidURL
        } catch  {
            print("Error: \(error)")
        }
    }
}
// here i can change the throw to what ever i want custom error(APIError.invalidURL) or default error (URLError()) but the main point all from the same type Error because the function throw Error.

// MARK: - Time to use it.
let mockNetworkService = MockNetworkService()
Task {
    try await mockNetworkService.fetchUser()
}

