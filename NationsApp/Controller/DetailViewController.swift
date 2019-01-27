//
//  DetailViewController.swift
//  NationsApp
//
//  Created by Nizar Elhraiech on 27/01/2019.
//  Copyright © 2019 Nizar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var name : String?
    var flag : String?
    var latitude : String?
    var longitude : String?
    var id : Int?
    var stateOfConnetion : Bool?

    override func viewDidLoad() {
        if(stateOfConnetion!){
            nameLabel.text = name
            let flagUrl = NSURL(string: flag!)
            flagImg.af_setImage(withURL: flagUrl! as URL)
            latitudeLabel.text = latitude
            longitudeLabel.text = longitude
        }else {
            nameLabel.text = name
            latitudeLabel.text = latitude
            longitudeLabel.text = longitude
        }

        super.viewDidLoad()
        
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
