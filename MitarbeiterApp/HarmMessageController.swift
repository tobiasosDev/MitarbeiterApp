//
//  HarmMessageController.swift
//  MitarbeiterApp
//
//  Created by Tobias Lüscher on 06.03.17.
//  Copyright © 2017 Tobias Lüscher. All rights reserved.
//

import UIKit
import CoreLocation

class HarmMessageController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var objectInputField: UITextField!
    @IBOutlet weak var adressInputField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    let picker = UIImagePickerController()
    var imageReadToSend: Data!
    @IBOutlet weak var takenImage: UIImageView!
    let locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        objectInputField.delegate = self
        adressInputField.delegate = self
        objectInputField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        adressInputField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        datePicker.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func takePhoto(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
    }

    @IBAction func sendHarmMessage(_ sender: Any) {
    }

    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        var chosenImage = UIImage()//1
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        //takenImage.contentMode = .scaleAspectFill //3
        takenImage.image = chosenImage //4
        imageReadToSend = UIImagePNGRepresentation(chosenImage);//5
        editingChanged(imageReadToSend as AnyObject)//6
        dismiss(animated: true, completion: nil) //7
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func editingChanged(_ inputObject: AnyObject) {
        if inputObject is UITextField && (inputObject as! UITextField).text?.characters.count == 1 {
            if (inputObject as! UITextField).text?.characters.first == " " {
                (inputObject as! UITextField).text = ""
                return
            }
        }
        guard
                let object = objectInputField.text, !object.isEmpty,
                let adress = adressInputField.text, !adress.isEmpty,
                let image = imageReadToSend, !image.isEmpty
        else {
            sendButton.isEnabled = false
            return
        }
        sendButton.isEnabled = true
    }

    //UITextFieldReturn Keyboard Hide
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in

                    //print(placemarks!)

                    if (error != nil) {
                        print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                        return
                    }

                    if (placemarks?.count)! > 0 {
                        let pm = placemarks?[0]
                        self.displayLocationInfo(placemark: pm)
                    } else {
                        print("Problem with the data received from geocoder")
                    }
                })
    }

    func displayLocationInfo(placemark: CLPlacemark!) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let name: String = (containsPlacemark.name != nil) ? containsPlacemark.name! : ""
            let locality: String = (containsPlacemark.locality != nil) ? containsPlacemark.locality! : ""
            let postalCode: String = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode! : ""
            //let administrativeArea: String = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea! : ""
            //let country: String = (containsPlacemark.country != nil) ? containsPlacemark.country! : ""
            
            adressInputField.text = "\(name) \(locality) \(postalCode)";
        }

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
}
