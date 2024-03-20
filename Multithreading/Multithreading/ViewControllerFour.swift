//
//  ViewControllerFour.swift
//  Multithreading
//
//  Created by mac on 19.03.2024.
//

import UIKit

class ViewControllerFour: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()

           // Создаем и запускаем поток
            let thread1 = ThreadprintDemon()
            let thread2 = ThreadprintAngel()

            // Меняем приоритеты
        
        // Сначала приоритет у первого потока
//            thread1.qualityOfService = .userInteractive
//            thread2.qualityOfService = .background
        
        // Приопитет у второго потока
//        thread1.qualityOfService = .background
//        thread2.qualityOfService = .userInteractive
        
        // печать вперемешку (утсановка одинаковых приоритетов)
        thread1.qualityOfService = .userInteractive
        thread2.qualityOfService = .userInteractive
        
            thread1.start()
            thread2.start()

    }

    class ThreadprintDemon: Thread {
        override func main() {
            for _ in (0..<10) {
                print("1")
            }
        }
    }
    class ThreadprintAngel: Thread {
        override func main() {
            for _ in (0..<10) {
                print("2")
            }
        }
    }

}
