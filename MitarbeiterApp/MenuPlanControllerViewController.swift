//
//  MenuPlanControllerViewController.swift
//  MitarbeiterApp
//
//  Created by Tobias Lüscher on 03.03.17.
//  Copyright © 2017 Tobias Lüscher. All rights reserved.
//

import UIKit

class MenuPlanControllerViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: "http://menu.sv-group.ch/typo3conf/ext/netv_svg_menumob/index.php")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
