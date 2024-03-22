//
//  ViewController_Task3_Seven.swift
//  Multithreading
//
//  Created by mac on 21.03.2024.
//

import UIKit

class ViewController_Task3_Seven: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let serialQueue = DispatchQueue(label: "com.example.myQueue")

        serialQueue.async {
            print(Thread.current)
            serialQueue.async {
                print(Thread.current)
               print("This will never be printed.")
           }
        }
    }
}

// Проблема в том что вызывается sync код внутри async в одной и той же очереди
