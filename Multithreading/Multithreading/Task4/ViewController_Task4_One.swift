//
//  ViewController_Task4_One.swift
//  Multithreading
//
//  Created by mac on 21.03.2024.
//

import UIKit

class ViewController_Task4_One: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        class ViewController: UIViewController {
            
            class Post: @unchecked Sendable {
                
            }
            
            enum State1: Sendable {
                case loading
                case data(String)
            }
            
            enum State2: Sendable {
                case loading
                case data(Post) // Out: Associated value 'data' of 'Sendable'-conforming enum 'State2' has non-sendable type 'ViewController.Post'
            }
        }
    }
}

// Ошибка была в том что у нас структура пост не подписана на Sendebale и ее нужно было подписать вместе с @unchecked потому что мы используем эту структуру в перечислении
