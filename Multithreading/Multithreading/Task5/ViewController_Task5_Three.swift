//
//  ViewController_Task5_Three.swift
//  Multithreading
//
//  Created by mac on 22.03.2024.
//

import UIKit

class ViewController_Task5_Three: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            print("Task 1 is finished")
        print(Thread.current)
        
        Task.detached(priority: .userInitiated){
            for i in 0..<50 {
                print(i)
            }
            print("Task 2 is finished")
            print(Thread.current)
        }
        
        DispatchQueue.global().async {
            for i in 0..<50 {
                print(i)
            }
            print("Task 4 is finished")
            print(Thread.current)
        }
            print("Task 3 is finished")
        print(Thread.current)
    }
}

// Когда мы используем DispatchQueue.global().async, то блок кода будет запущен на фоновом потоке, не блокирует главный поток

// Когда мы используем Task.detached(priority: .userInitiated) с каким-то приоритетом, в отличие от DispatchQueue.global(), блок кода выполнится на том же самом потоке, на котором была вызвана функция
