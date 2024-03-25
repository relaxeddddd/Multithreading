//
//  ViewControllerFive.swift
//  Multithreading
//
//  Created by mac on 19.03.2024.
//

import UIKit

class ViewControllerFive: UIViewController {

    private var name = "Ilya"
    private let lockQueue = DispatchQueue(label: "name.lock.queue")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateName()
    }
    
    func updateName() {
        lockQueue.async {
            self.name = "I love RM"
            print(Thread.current)
            print(self.name)
        }
        lockQueue.sync {
            print(self.name)
        }
    }

}

// Если написать DispatchQueue.global().аsync вывод будет анихронно проходить на втором потоку и мф будем видеть разный вовд каждый раз в зависимости от того какой поток быстрее выполнит работу

// Если написать DispatchQueue.global().sync то при выполнении кода глоьальный поток будет выолнятся синхронно и пока он не выполнит свою работу следующий поток не будет исполнять свой функционал

// Проблема состоит в том, что при выполнении кода с DispatchQueue.global().async обвновляет переменную name ив это же время код за пределами пытается считать эту переменную из-за чего происходит гонка за данными
