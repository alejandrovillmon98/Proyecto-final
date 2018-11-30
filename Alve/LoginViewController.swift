//
//  LoginViewController.swift
//  Alve
//
//  Created by David Hdz on 11/28/18.
//  Copyright © 2018 David Hdz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class LoginViewController: UIViewController {
    
    var ref:DatabaseReference!


    @IBOutlet weak var usuarioTxt: UITextField!
    @IBOutlet weak var passwdTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ingresarBtn(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func registrarBtn(_ sender: Any) {
        registerUser()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "autentic") {
            let destinationVC = segue.destination as! MessegeTableViewController
            destinationVC.mydato = "hola mundo"
        }
    }

    func loginUser() {
        
        guard let usuario = usuarioTxt.text, let passwd = passwdTxt.text else {
            return
        }
        Auth.auth().signIn(withEmail: usuario, password: passwd) { (user, error) in
                if user != nil {
                    print("Usuario autenticado")
                    print(user!.user.uid)
                    let tableVC = MessegeTableViewController()
                    tableVC.mydato = "hola"
                    self.performSegue(withIdentifier: "autentic", sender: self)
                }else {
                    if let error = error?.localizedDescription{
                        print("Error al iniciar sesion por firebase", error)
                    }else {
                        print("Tu eres error en sesion!!")
                    }
                }
            }
    }
    
    func registerUser(){
        guard let usuario = usuarioTxt.text, let passwd = passwdTxt.text else {
            return
        }
        Auth.auth().createUser(withEmail: usuario, password: passwd) { (user, error) in
                if user != nil {
                    print("Se creo el usuario")
                    let values = ["name": usuario]
                    guard let uid = user?.user .uid else{
                        return
                    }
                    let userReference = self.ref.child("users").child(uid)
                    userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            print("Error al insertar datos")
                            return
                        }
                        print("Dato guardado en la BD")
                    })
//                    let login = LoginViewController()
//                    self.navigationController?.pushViewController(login, animated: true)
                }else {
                    if let error = error?.localizedDescription{
                        print("Error al crear usuario por firebase", error)
                    }else {
                        print("Tu eres error!!")
                    }
                }
            }
        
    }
    
}
