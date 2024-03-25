//
//  ViewController_Task3_Two.swift
//  Multithreading
//
//  Created by mac on 20.03.2024.
//

import UIKit

class ViewController_Task3_Two: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        
        let asyncWorker = AsyncWorker()
        
        asyncWorker.doJobs(postNumbers: 1, 2, 3, 4, 5) { posts in
            print(Thread.current)
            print(posts.map { $0.id })
        }
    }
}

class AsyncWorker {
    let postGroup = DispatchGroup()
    func doJobs(postNumbers: Int..., complition: @escaping ([Post]) -> Void) {
        var posts = [Post]()
        
        for i in postNumbers {
            postGroup.enter()
            URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/\(i)")!)) { data, response, error in
                guard let data = data else { return }
                if let post = try? JSONDecoder().decode(Post.self, from: data) {
                    posts.append(post)
                }
                self.postGroup.leave()
            }.resume()
        }
        postGroup.notify(queue: .main) {
            complition(posts)
        }
    }
}

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
