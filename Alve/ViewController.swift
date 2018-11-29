//
//  ViewController.swift
//  Alve
//
//  Created by David Hdz on 11/26/18.
//  Copyright © 2018 David Hdz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }


    @IBAction func enviar(_ sender: Any) {
        message.text = "Hola mundo"
    }
    
}

