//
//  ViewController_Task5_Two.swift
//  Multithreading
//
//  Created by mac on 22.03.2024.
//

import UIKit

class ViewController_Task5_Two: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(1)
        Task { @MainActor  in
            print(2)
        }
        print(3)
    }
}

// Если у нас стоит после Task @MainActor то у нас Task будет выполнятся в главном потоке
