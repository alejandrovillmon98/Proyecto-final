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
        let keyString = String(key)
        
        guard let messege = messegeTxt.text else {
            return
        }
        let values = ["referencia": keyString,
                      "texto": messege,
                      "imagen": "mi imagen",
                      "latitude": "19.3314064",
                      "longitude": "-99.1841764"
                    ] as [String : Any]
        
                self.ref.child(key).setValue(values)
        print("mensaje enviado")
        messegeTxt.text = ""
          
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "eventos") {
            let destinationVC = segue.destination as! MessegeTableViewController
            destinationVC.mydato = "hola mundo"
            destinationVC.valorAuth = 0
        }
    }
    
    
    @IBAction func eventosBtn(_ sender: Any) {
//        let tableVC = MessageTableViewController()
//        self.navigationController?.pushViewController(tableVC, animated: true)
       self.performSegue(withIdentifier: "eventos", sender: self)

    }
    
    @IBAction func registreBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "register", sender: self)
    }
    

}

