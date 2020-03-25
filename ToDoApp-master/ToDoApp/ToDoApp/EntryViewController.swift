//
//  SecondViewController.swift
//  ToDoApp
//
//  Created by Field Employee on 3/24/20.
//  Copyright © 2020 Tom Kew-Goodale. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleField: UITextField!
    
    
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self//when enter is pressed save start
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveTask))

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
    }

    @objc func saveTask() {
        
        guard let text = titleField.text, !text.isEmpty else{
            return
        }
        
        guard var count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    
    }
    
}
