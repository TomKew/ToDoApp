//
//  FirstViewController.swift
//  ToDoApp
//
//  Created by Field Employee on 3/24/20.
//  Copyright © 2020 Tom Kew-Goodale. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
   

    
    var tasks = [String]()
    var Donetasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get all saved tasks
        self.title = "To-Do"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //Setup
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTasks()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(true)
       updateTasks()
    }
    
    func updateTasks(){
        
        tasks.removeAll()
        
       guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! EntryViewController
        
        vc.title = "New To-Do"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Unselect the row, and instead, show the state with a checkmark.
    tableView.deselectRow(at: indexPath, animated: false)
    
    guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType != .checkmark{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
    }

   
}

extension ViewController: UITableViewDelegate {
    

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask()
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
     @objc func deleteTask() {
        
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
                   return
               }
               
    
        
            UserDefaults.standard.removeObject(forKey: "task_\(count-1)")
            UserDefaults.standard.set(count, forKey: "task_\(count-1)")
        }
               
        
    }


 


