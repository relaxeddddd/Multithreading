//
//  ViewController_Task3_Three.swift
//  Multithreading
//
//  Created by mac on 21.03.2024.
//

import UIKit

class ViewController_Task3_Three: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            let semaphore = DispatchSemaphore(value: 1)
            var sharedResource = 0

            DispatchQueue.global(qos: .background).async {
                semaphore.wait()
                for _ in 1...100 {
                    sharedResource += 1
                }
                print(sharedResource)
                semaphore.signal()
            }

            DispatchQueue.global(qos: .background).async {
                semaphore.wait()
                for _ in 1...100 {
                    sharedResource += 1
                }
                print(sharedResource)
                semaphore.signal()
            }
     }

}

// Проблема состояния гонки, что бы исправить проблему нужно синхронизировать доступ к ресурсам. Один из методов решения - симафоры
