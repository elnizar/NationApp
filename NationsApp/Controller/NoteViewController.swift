//
//  NoteViewController.swift
//  NationsApp
//
//  Created by Nizar Elhraiech on 27/01/2019.
//  Copyright © 2019 Nizar. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var note: UITextView!
    var id : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        note.becomeFirstResponder()
        note.text = StorageHelper.getCountry(id: Int(id!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveNote(_ sender: Any) {
        if note.text != nil {
            StorageHelper.insertAndUpdateNote(id: id!, note: note.text)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
