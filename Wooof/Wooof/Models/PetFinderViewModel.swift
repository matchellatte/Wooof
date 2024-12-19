import Foundation
import Combine

class PetFinderViewModel: ObservableObject {
    @Published var pets: [Pet] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "FhGDsHGT1fuftj28B09R1a48kTUjS7sSeSX8ZSo0gpkjoIfVXA"
    private let apiSecret = "31nfdAYGk7jX4vPfqnwU6iKkIL5auoQDeFtZZZUY"

    func fetchPets() {
        isLoading = true
        errorMessage = nil

        fetchAccessToken()
            .flatMap { token in
                self.fetchPetData(token: token)
            }
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }, receiveValue: { [weak self] pets in
                DispatchQueue.main.async {
                    self?.pets = pets
                }
            })
            .store(in: &cancellables)
    }

    private func fetchAccessToken() -> AnyPublisher<String, Error> {
        let url = URL(string: "https://api.petfinder.com/v2/oauth2/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let bodyParams = [
            "grant_type": "client_credentials",
            "client_id": apiKey,
            "client_secret": apiSecret
        ]
        request.httpBody = bodyParams
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> String in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let decodedResponse = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
                return decodedResponse.access_token
            }
            .receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }

    private func fetchPetData(token: String) -> AnyPublisher<[Pet], Error> {
        let url = URL(string: "https://api.petfinder.com/v2/animals")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> [Pet] in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let decodedResponse = try JSONDecoder().decode(PetResponse.self, from: data)
                return decodedResponse.animals.map { animal in
                    Pet(
                        id: animal.id,
                        name: animal.name,
                        breed: animal.breeds.primary,
                        description: animal.description,
                        imageURL: animal.photos.first?.medium // Use the first image URL
                    )
                }
            }
            .receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }

}
