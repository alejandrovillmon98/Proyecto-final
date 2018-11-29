//
//  ViewController.swift
//  Alve
//
//  Created by David Hdz on 11/26/18.
//  Copyright © 2018 David Hdz. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    var ref:DatabaseReference!


    
    @IBOutlet weak var messegeTxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            ref = Database.database().reference().child("mensajeCalle")
    }


    @IBAction func enviarBtn(_ sender: Any) {
        let key = ref.childByAutoId().key
        
        guard let messege = messegeTxt.text else {
            return
        }
        let values = ["texto": messege,
                      "imagen": "mi imagen",
                      "latitude": "37.331820",
                      "longitude": "-122.031180"
                    ] as [String : Any]
        
                self.ref.child(key).setValue(values)
        print("mensaje enviado")
          
    }
    
    
    @IBAction func eventosBtn(_ sender: Any) {
        let tableVC = MessageTableViewController()
        self.navigationController?.pushViewController(tableVC, animated: true)

    }
    
//    guard let mesajeID = Auth.auth().currentUser?.uid else {
//    return
//    }
}

