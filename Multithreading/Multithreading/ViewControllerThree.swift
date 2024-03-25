//
//  ViewControllerThree.swift
//  Multithreading
//
//  Created by mac on 19.03.2024.
//

import UIKit

class ViewControllerThree: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
     
            // Создаем и запускаем поток
            let infinityThread = InfinityLoop()
        print(infinityThread.isFinished)
        print(infinityThread.isCancelled)
        print(infinityThread.isExecuting)
            infinityThread.start()

            // Подождем некоторое время, а затем отменяем выполнение потока
            sleep(5)
            // Отменяем тут
        infinityThread.cancel()
    }

    class InfinityLoop: Thread {
        var counter = 0
        
        override func main() {
            while counter < 30 && !isCancelled {
                counter += 1
                print(counter)
                InfinityLoop.sleep(forTimeInterval: 1)
            }
        }
    }

}
