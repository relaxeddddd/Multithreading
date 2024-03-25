//
//  ViewController_Task5_One.swift
//  Multithreading
//
//  Created by mac on 22.03.2024.
//

import UIKit

class ViewController_Task5_One: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(1)
        print(Thread.current)
        Task {
             print(2)
            print(Thread.current)
        }
        print(3)
        print(Thread.current)
    }
}

// Первый раз распечаталось 1 3 2 потому что у нас еасинхронная операция которая выполняется на мейн очереди соответствонно она встает в очередь и будет ждать пока мейн поток не освободится

// Когда мы указываем Task это означет то что что выполнение Task может выполнятся в основном потоке или в другом
