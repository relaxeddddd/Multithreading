//
//  ViewController_Task3_Five.swift
//  Multithreading
//
//  Created by mac on 21.03.2024.
//

import UIKit

class ViewController_Task3_Five: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global().async {
                    self.thread1()
                }

                DispatchQueue.global().async {
                    self.thread2()
                }
        
    }
    

    let resourceASemaphore = DispatchSemaphore(value: 1)
        let resourceBSemaphore = DispatchSemaphore(value: 1)

        func thread1() {
            print("Поток 1 пытается захватить Ресурс A")
            resourceASemaphore.wait() // Захват Ресурса A
            resourceBSemaphore.wait() // Попытка захвата Ресурса B, который уже занят Потоком 2
            
            print("Поток 1 захватил Ресурс A и пытается захватить Ресурс B")
            Thread.sleep(forTimeInterval: 1) // Имитация работы для демонстрации livelock
            
            print("Поток 1 захватил Ресурс B")
            
            resourceBSemaphore.signal()
            resourceASemaphore.signal()
        }

        func thread2() {
            resourceBSemaphore.wait() // Захват Ресурса B
            resourceASemaphore.wait() // Попытка захвата Ресурса A, который уже занят Потоком 1
            print("Поток 2 пытается захватить Ресурс B")
            
            print("Поток 2 захватил Ресурс B и пытается захватить Ресурс A")
            Thread.sleep(forTimeInterval: 1) // Имитация работы для демонстрации livelock
            
            print("Поток 2 захватил Ресурс A")
            
            resourceASemaphore.signal()
            resourceBSemaphore.signal()
        }
}

// Проблема LiveLock
