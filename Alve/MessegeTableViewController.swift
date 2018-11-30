//
//  MessegeTableViewController.swift
//  Alve
//
//  Created by Servicio on 11/30/18.
//  Copyright © 2018 David Hdz. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MessegeTableViewController: UITableViewController {

    var ref:DatabaseReference!
    var mydato:String?
    
    var mensajes = [Mensajes](){
        didSet{
            updateData()
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Eventos"
        loadProductos()
        if let mydato = mydato{
            print(mydato)
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mensajes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = mensajes[indexPath.row].texto
        cell.detailTextLabel?.text = mensajes[indexPath.row].latitude! + ", " +  mensajes[indexPath.row].longitude!
        cell.imageView?.image = UIImage(named: "grafitero")
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "") {
            let destinationVC = segue.destination as! MessegeTableViewController
            destinationVC.mydato = "hola mundo"
        }
    }
    
    func loadProductos(){
        ref = Database.database().reference().child("mensajeCalle")
        self.ref.observe(DataEventType.value) { (snapshot) in
            self.mensajes.removeAll()
            if snapshot.childrenCount>0{
                for mensaje in snapshot.children.allObjects as! [DataSnapshot]{
                    if let mensajeObject = mensaje.value as? [String: AnyObject]{
                        let texto = mensajeObject["texto"] as! String
                        let imagen = mensajeObject["imagen"] as! String
                        let latitude = mensajeObject["latitude"] as! String
                        let longitude = mensajeObject["longitude"] as! String
                        self.mensajes.append(Mensajes(texto:texto, imagen: imagen, latitude:latitude, longitude:longitude))
                    }
                }
            }
        }
    }
    
    func updateData() {
        self.tableView.reloadData()
    }


}
