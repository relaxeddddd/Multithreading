//
//  ViewController_Task4_Four.swift
//  Multithreading
//
//  Created by mac on 22.03.2024.
//

import UIKit

class ViewController_Task4_Four: UIViewController {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Использование
        let threadSafeArray = ThreadSafeArray()
        let operationQueue = OperationQueue()

        let firstOperation = FirstOperation(threadSafeArray: threadSafeArray)
        let secondOperation = SecondOperation(threadSafeArray: threadSafeArray)

        operationQueue.addOperation(firstOperation)
//        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation(secondOperation)

        // Дождитесь завершения операций перед выводом содержимого массива
        operationQueue.waitUntilAllOperationsAreFinished()

        print(threadSafeArray.getAll())
    }
}

// Объявляем класс для для синхронизации потоков
class ThreadSafeArray {
    private var array: [String] = []
    let semaphore = DispatchSemaphore(value: 1)
    
    func append(_ item: String) {
        semaphore.wait()
        array.append(item)
        semaphore.signal()
    }

    func getAll() -> [String] {
        return array
    }
    
}

// Определяем первую операцию для добавления строки в массив
class FirstOperation: Operation {
    let threadSafeArray: ThreadSafeArray

    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }

    override func main() {
        if isCancelled { return }
        threadSafeArray.append("Первая операция")
    }
}

// Определяем вторую операцию для добавления строки в массив
class SecondOperation: Operation {
    let threadSafeArray: ThreadSafeArray

    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }

    override func main() {
        if isCancelled { return }
        threadSafeArray.append("Вторая операция")
    }
}

