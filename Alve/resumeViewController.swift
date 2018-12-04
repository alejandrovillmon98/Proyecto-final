//
//  resumeViewController.swift
//  Alve
//
//  Created by Servicio on 12/3/18.
//  Copyright © 2018 David Hdz. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import MapKit

class resumeViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var ref:DatabaseReference!
    var referenciaM = ""
    var textoM = ""
    var imagenM = ""
    var latitudeM = ""
    var longitudeM = ""
    var initialLocation:CLLocation = CLLocation(latitude: 21.282778, longitude: -157.82944)
    
    var referenciaMensaje:String = ""
    var valorAuth:Int = 0
    var mensajes:Mensajes?

    @IBOutlet weak var textoLbl: UILabel!
    
    @IBOutlet weak var distribuirBtnOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.distribuirBtnOutlet.isHidden = true
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("mensajeGeneral").child(referenciaMensaje)
        
        if self.valorAuth == 1{
            ref = Database.database().reference().child("mensajeCalle").child(referenciaMensaje)
            self.distribuirBtnOutlet.isHidden = false
        }
        
        

        let refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            print(postDict)
            //print(refHandle)
            //print(postDict)
            self.imagenM = (postDict["imagen"] as? String)!
            self.latitudeM = (postDict["latitude"] as? String)!
            self.longitudeM = (postDict["longitude"] as? String)!
            self.referenciaM = (postDict["referencia"] as? String)!
            self.textoM = (postDict["texto"] as? String)!
            
            self.textoLbl.text = self.textoM
            self.initialLocation = CLLocation(latitude: Double(self.latitudeM)!, longitude: Double(self.longitudeM)!)
            self.centerMapOnLocation(location: self.initialLocation)
            
        })
        
        
        



    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func distribuirBtn(_ sender: Any) {
        
        let key = ref.childByAutoId().key
        let keyString = String(key)
        ref = Database.database().reference().child("mensajeGeneral")
        let values = ["referencia": keyString,
                      "texto": textoM,
                      "imagen": imagenM,
                      "latitude": latitudeM,
                      "longitude": longitudeM
            ] as [String : Any]
        
        self.ref.child(key).setValue(values)
        print("mensaje enviado")
//        let refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//
//            let referenciaB:String = (postDict[""] as? String)!
//
//            let values = ["referencia": ,
//                          "texto": postDict[""] as? String,
//                          "imagen": postDict[""] as? String,
//                          "latitude": postDict[""] as? String,
//                          "longitude": postDict[""] as? String
//                ] as [String : Any]
//
//            self.ref.child(key).setValue(values)
        
            
            
            //mensajeObject["latitude"] as! String
            if self.valorAuth == 0{
                self.distribuirBtnOutlet.isHidden = true
            }
//        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
