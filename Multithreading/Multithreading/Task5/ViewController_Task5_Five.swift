import UIKit




class ViewController_Task5_Five: UIViewController {
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let messages = await fetchMessagesResult()
            print(messages)
        }
    }
    
//    func fetchMessagesResult() async -> [Message] {
//        await withCheckedContinuation { continuation in
//            networkService.fetchMessages { messages in
//                continuation.resume(returning: messages)
//            }
//        }
//    }
    
    enum ErrorMessage: Error {
        case empty
    }
    
    func fetchMessagesResult() async -> [Message] {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                networkService.fetchMessages { messages in
                    if messages.isEmpty {
                        continuation.resume(throwing: ErrorMessage.empty)
                    } else {
                        continuation.resume(returning: messages)
                    }
                }
            }
        } catch {
            return []
        }
    }
}

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}

class NetworkService {
    
    func fetchMessages(completion: @escaping ([Message]) -> Void) {
        let url = URL(string: "https://hws.dev/user-messages.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }

            completion([])
        }
        .resume()
    }
}

