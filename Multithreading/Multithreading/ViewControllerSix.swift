//
//  ViewControllerSix.swift
//  Multithreading
//
//  Created by mac on 19.03.2024.
//

import UIKit

class ViewControllerSix: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("A")
        
        DispatchQueue.main.async {
            print("B")
        }
        
        print("C")
    }
}

// Вывод будет: ACB по сколько DispatchQueue.main.async мы используем в мейн потоке из-за чего print("B") сработвет только тогда когда до него дойдет очередь т.е последним
