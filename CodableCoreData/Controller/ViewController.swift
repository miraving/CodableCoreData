//
//  ViewController.swift
//  CodableCoreData
//
//  Created by Vitalii on 05.01.2022.
//

import UIKit
import CoreData
import Alamofire

class ViewController: UITableViewController {
    var users = [User]()

    @IBAction func loadUser() {
        loadLoacal()
        sendRequestRequest()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!// as? UITableViewCell
        
        let user = users[indexPath.item]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.bio
        
        return cell
    }
}

extension ViewController {
    func loadLoacal() {
        let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "TRUEPREDICATE")
//        let sortDescriptor = NSSortDescriptor(key: "idauto", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.returnsObjectsAsFaults = false
        managedObjectContext?.perform {
            self.users = try! fetchRequest.execute()
            self.tableView.reloadData()
        }
    }
    
    func sendRequestRequest() {
        /**
         Request
         get https://api.github.com/users/miraving
         */

        // Fetch Request
        AF.request("https://api.github.com/users/miraving", method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: User.self, decoder: ManagedObjectDecoder(), completionHandler: { [weak self] response in
                switch response.result {
                case .success(_):
                    self?.loadLoacal()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }



}
