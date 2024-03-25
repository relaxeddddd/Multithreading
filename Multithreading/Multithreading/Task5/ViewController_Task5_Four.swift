//
//  ViewController_Task5_Four.swift
//  Multithreading
//
//  Created by mac on 22.03.2024.
//

import UIKit

class ViewController_Task5_Four: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func randomD6() async -> Int {
            Int.random(in: 1...6)
        }
        
        Task {
            let result = await randomD6()
            print(result)
        }
        
    }
}
