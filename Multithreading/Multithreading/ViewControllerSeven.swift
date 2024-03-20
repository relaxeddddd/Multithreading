//
//  ViewControllerSeven.swift
//  Multithreading
//
//  Created by mac on 19.03.2024.
//

import UIKit

class ViewControllerSeven: UIViewController {
    
    private lazy var name = "I love RM"
    var lock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Therd: \(Thread.current)")
        updateName()
    }

    func updateName() {
        DispatchQueue.global().async {
            self.lock.lock()
            // Считываем имя из global
            print(self.name)
            print(Thread.current)
            self.lock.unlock()
        }
        self.lock.lock()
        print(self.name)
        self.lock.unlock()

    }
}

// Проблема состоит в том, что при выполнении кода с DispatchQueue.global().async обвновляет переменную name ив это же время код за пределами пытается считать эту переменную из-за чего происходит гонка за данными. Для этого мы используем NSLock() что бы ограничить доступ к данным одного потока что бы выполнялось другое действие этими данными и не было гонки за данными
