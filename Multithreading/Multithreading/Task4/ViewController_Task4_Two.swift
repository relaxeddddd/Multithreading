//
//  ViewController_Task4_Two.swift
//  Multithreading
//
//  Created by mac on 21.03.2024.
//

import UIKit

protocol RMOperationProtocol {
    // Приоритеты
    var priority: DispatchQoS.QoSClass { get }
    // Выполняемый блок
    var completionBlock: (() -> Void)? { get }
    // Завершена ли операция
    var isFinished: Bool { get }
    // Метод для запуска операции
    var isExecuting: Bool { get }
    //
    func start()
}

class RMOperation: RMOperationProtocol {
    var isExecuting: Bool = false
    
    var priority: DispatchQoS.QoSClass
    var completionBlock: (() -> Void)?
    var isFinished: Bool = false

    init(priority: DispatchQoS.QoSClass, completionBlock: ( () -> Void)? = nil) {
        self.priority = priority
        self.completionBlock = completionBlock
    }

    /// В методе start. реализуйте все через глобальную паралельную очередь с приоритетами.
    func start() {

        DispatchQueue.global().sync {
            self.completionBlock?()
        }

        DispatchQueue.global().sync {
            self.isFinished = true
        }
    }

}

class ViewController_Task4_Two: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let operationFirst = RMOperation(priority: .default)
        let operationSecond = RMOperation(priority: .default)

        operationFirst.priority = .userInitiated
        operationFirst.completionBlock = {

            for _ in 0..<10 {
                print(2)
            }
            print("First: \(Thread.current)")
            print("Операция полностью завершена!")
        }

        operationFirst.start()



        operationSecond.priority = .background
        operationSecond.completionBlock = {

            for _ in 0..<10 {
                print(1)
            }
            print("Twice: \(Thread.current)")
            print("Операция полностью завершена!")
        }
        operationSecond.start()
    }
}

//final class RMOperation: Operation {}
//
//class ViewController_Task4_Two: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let operationFirst = RMOperation()
//        let operationSecond = RMOperation()
//
//        operationFirst.qualityOfService = .background
//        operationFirst.completionBlock = {
//
//            for _ in 0..<10 {
//                print(2)
//            }
//            print("First: \(Thread.current)")
//            print("Операция полностью завершена!")
//            operationSecond.start()
//        }
//
//        operationSecond.qualityOfService = .userInteractive
//        operationSecond.completionBlock = {
//
//            for _ in 0..<10 {
//                print(1)
//            }
//            print("Twice: \(Thread.current)")
//            print("Операция полностью завершена!")
//        }
//
//        operationFirst.start()
//    }
//}
