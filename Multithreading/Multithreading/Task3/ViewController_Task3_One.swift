//
//  ViewController_Task3_One.swift
//  Multithreading
//
//  Created by mac on 20.03.2024.
//

import UIKit

class ViewController_Task3_One: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phrasesService = PhrasesService()
        
        for i in 0..<10 {
            DispatchQueue.global().async {
                Task {
                    await phrasesService.addPhrases("Phrase \(i)")
                }
            }
        }
        
        Thread.sleep(forTimeInterval: 1)
        Task {
            print(await phrasesService.phrases)
        }
    }
}

actor PhrasesService {
    var phrases: [String] = []
    
    func addPhrases(_ phrase: String) {
        phrases.append(phrase)
    }
}

/// 1, 2 пункт
class ViewController_Task3_One_2: UIViewController {
    let semaphore = DispatchSemaphore(value: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phrasesService = PhrasesService()
        
        DispatchQueue.global().async {
            for i in 0..<10 {
                phrasesService.addPhrases("Phrase \(i)")
            }
        }
        
        Thread.sleep(forTimeInterval: 1)
        self.semaphore.wait()
        print(phrasesService.phrases)
        self.semaphore.signal()
    }
    
    class PhrasesService {
        var phrases: [String] = []
        
        func addPhrases(_ phrase: String) {
            phrases.append(phrase)
        }
    }
}

