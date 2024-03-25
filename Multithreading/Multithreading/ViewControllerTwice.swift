//
//  ViewControllerTwice.swift
//  Multithreading
//
//  Created by mac on 18.03.2024.
//

import UIKit

class ViewControllerTwice: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            // Создаем и запускаем поток с таймером
            let timer = TimerThread(duration: 10)
            timer.start()
    }


    class TimerThread: Thread {
        private var timerDuration: Int
        private var timer: Timer!
        
        init(duration: Int) {
            self.timerDuration = duration
        }
        
        override func main() {
            // Создаем таймер, который будет выполняться каждую секунду
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            print("Current = \(Thread.current)")
            
            RunLoop.current.add(timer, forMode: .default)
            // Запускаем текущий run loop ниже
            RunLoop.current.run()
        }
        
        @objc func updateTimer() {
            // Ваш код здесь будет выполняться каждую секунду
            if timerDuration > 0 {
                print("Осталось \(timerDuration) секунд...")
                timerDuration -= 1
            } else {
                print("Время истекло!")
                
                timer.invalidate()
                // Остановка текущего run loop после завершения таймера
                CFRunLoopStop(CFRunLoopGetCurrent())
            }
        }
    }
}
