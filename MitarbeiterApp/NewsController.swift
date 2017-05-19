//
//  NewsController.swift
//  MitarbeiterApp
//
//  Created by Tobias Lüscher on 06.03.17.
//  Copyright © 2017 Tobias Lüscher. All rights reserved.
//

import UIKit

class NewsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var newsList:Array<String> = ["Test1", "Test2", "Test3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Table methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsList.count
        
    }
    
    //This function creates the List elements(cells)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! overviewCell
        
        cell.titel.text = newsList[(indexPath as NSIndexPath).row]
        
        cell.shortMessage.text = "sadfajklsdhf asjkldfhajklsd sakjdfhjklasd fjhhjkjka sd f hsadfjklasd l"
        
        cell.date.text = "14.03.17    20.45"
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Read device by index of the table element
        //deviceActive = deviceList[(indexPath as NSIndexPath).row]
        
        //Change View
        //self.performSegue(withIdentifier: "detailDeviceViewSeque", sender: nil)
    }
    
//    //Edit Actions for the table elements(cell's)
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        //Get dbService instance
//        let dbServiceInstance = dbService()
//        //create slide Button Delete
//        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
//            //here comes the code which would executed by click
//            //Read device by index of the table element
//            let myDevice = self.deviceList[(indexPath as NSIndexPath).row]
//            //Delete device with dbService
//            _ = dbServiceInstance.deletePlugByName(myDevice.dbID).then{result -> Void in
//                //Also delete Device in local DB
//                let realm = try! Realm()
//                try! realm.write {
//                    realm.delete(myDevice)
//                }
//            }
//        }
//        //Set the background color of the button
//        delete.backgroundColor = UIColor.red
//        //Return the created button
//        return [delete]
//    }


}
