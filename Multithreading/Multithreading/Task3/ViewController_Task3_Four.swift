//
//  ViewController_Task3_Four.swift
//  Multithreading
//
//  Created by mac on 21.03.2024.
//

import UIKit

class ViewController_Task3_Four: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let people1 = People1()
        let people2 = People2()
        
        let thread1 = Thread { // создаем новый поток
            people1.walkPast(with: people2)
        }
        
        thread1.start()
        
        let thread2 = Thread { // создаем новый поток
            people2.walkPast(with: people1)
        }
        
        thread2.start()
    }
}

class People1 {
    var isDifferentDirections = false // движется ли человек 1 в другом направлении - FALSE
    let semaphore = DispatchSemaphore(value: 1)
    func walkPast(with people: People2) { // функция что бы человек 1 прошел мимо человека 2
        
        DispatchQueue.global(qos: .background).async {
            while (!people.isDifferentDirections) {
                print(Thread.current)
                print("People1 не может обойти People2")
                sleep(1)
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.semaphore.wait()
            print("People1 смог пройти прямо")
            self.isDifferentDirections = true
            self.semaphore.signal()
        }
    }
}

class People2 {
    var isDifferentDirections = false
    let semaphore = DispatchSemaphore(value: 1)
    func walkPast(with people: People1) {
        
        DispatchQueue.global(qos: .background).async {
            while (!people.isDifferentDirections) {
                print(Thread.current)
                print("People2 не может обойти People1")
                sleep(1)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.semaphore.wait()
            print("People2 смог пройти прямо")
            self.isDifferentDirections = true
            self.semaphore.signal()
        }
    }
}
