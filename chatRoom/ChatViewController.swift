//
//  ChatViewController.swift
//  chatRoom
//
//  Created by Marilyn Florek on 9/28/18.
//  Copyright © 2018 Marilyn Florek. All rights reserved.
//

import UIKit
import Parse


class Message: PFObject, PFSubclassing {
    @NSManaged var text: String?
    @NSManaged var user: PFUser?

    // returns the Parse name that should be used
    class func parseClassName() -> String {
        return "Message"
    }
}

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatMessageField.delegate = self
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.setContentOffset(.zero, animated:true)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        navigationItem.title = "Chat"
        getMessages()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func getMessages() {
        let query = Message.query()
        query!.includeKey("text")
        query!.includeKey("user")
        query!.addDescendingOrder("createdAt")
        query!.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let objects = objects {
                print("Successfully retrieved \(objects.count) messages.")
                self.messages = objects as! [Message]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription as String!)
            }
        }
    }
    
    func sendMessage() {
        let chatMessage = Message()
        chatMessage.text = chatMessageField.text ?? ""
        chatMessage.user = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
                self.tableView.reloadData()
                
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
        tableView.setContentOffset(.zero, animated:true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    @IBAction func onSend(_ sender: Any) {
        sendMessage()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        let user = PFUser.logOutInBackground()
        print(user)
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages != nil {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        if messages[indexPath.row]["text"] != nil {
            cell.chat = messages[indexPath.row]
        }
        return cell
    }
    
    @objc func onTimer() {
        // Add code to be run periodically
        getMessages()
    }
    
    
}
