//
//  ViewController.swift
//  Multithreading
//
//  Created by mac on 18.03.2024.
//

import UIKit

class ViewControllerFirst: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        Thread.detachNewThread {
            for _ in (0..<10) {
                let currentThread = Thread.current
                print("1, Current thread: \(currentThread)")
             }
        }

      for _ in (0..<10) {
         let currentThread = Thread.current
         print("2, Current thread: \(currentThread)")
      }
    }
    
    // Вывод изменился потому что первый цикл выполнялся в в другом потоке и код выполнялся паралелльно, т.к первый цикл выполняется в другом потоке а второй в main потоке
}

