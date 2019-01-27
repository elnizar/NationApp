//
//  ViewController.swift
//  NationsApp
//
//  Created by Nizar Elhraiech on 2019-01-25.
//  Copyright © 2019 Nizar. All rights reserved.
//

import UIKit
import AlamofireImage
import ESPullToRefresh
import CoreLocation



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var name : String?
    var flag : String?
    var latitude : String?
    var longitude : String?
    var note : String?
    var id : Int?
    @IBOutlet weak var tableView: UITableView!
    var stateOfConnetion : Bool = true

    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadData()
        
        /// animator: your customize animator, default is NormalHeaderAnimator
        self.tableView.es.addPullToRefresh{
            [unowned self] in
            self.loadData()
        }
        /// manual refresh
        self.tableView.es.stopPullToRefresh(ignoreDate: true)
    }
    
    func loadData() {
        let service = CountryService()
        service.getCoutries { (countries) in
            //test if service return data or not
            if countries != nil {
                print("countries diff nill")
                self.stateOfConnetion = true
                self.countries = countries!
                self.calculateDistanceBetwenTwoCountry()
                self.countries = self.countries.sorted(by: {$0.distance ?? 0.0 < $1.distance ?? 0.0})
                self.tableView.reloadData()
                self.tableView.es.stopPullToRefresh(ignoreDate: true)
            }else {
                print("you are in offline mode")
                self.stateOfConnetion = false
                //test if core data empty or not
                if StorageHelper.getAllCountrys().count > 0 {
                    //retrive data from core data
                    self.countries = StorageHelper.getAllCountrys()
                    self.countries = self.countries.sorted(by: {$0.distance ?? 0.0 < $1.distance ?? 0.0})
                    self.tableView.reloadData()
                    self.tableView.es.stopPullToRefresh(ignoreDate: true)
                    
                }else {
                    print("Nothing To Do")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)

        if stateOfConnetion == true {
            
            let label = cell.viewWithTag(2) as! UILabel
            let imageView = cell.viewWithTag(1) as! UIImageView
            let country = countries[indexPath.row]
            label.text = country.name
            let flagUrl = NSURL(string: country.flag!)
            imageView.af_setImage(withURL: flagUrl! as URL)

        }
        else{
            let label = cell.viewWithTag(2) as! UILabel
            let country = countries[indexPath.row]
            label.text = country.name
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        name = countries[indexPath.row].name
        flag = countries[indexPath.row].flag
        latitude = countries[indexPath.row].latitude
        longitude = countries[indexPath.row].longitude
        id = Int(countries[indexPath.row].id!)

        performSegue(withIdentifier: "homeToDetail", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "homeToDetail") {
            // initialize new view controller and cast it as your view controller
            let detailViewController = segue.destination as! DetailViewController
            // your new view controller should have property that will store passed value
            detailViewController.stateOfConnetion = stateOfConnetion
            detailViewController.name = name
            detailViewController.flag = flag
            detailViewController.latitude = latitude
            detailViewController.longitude = longitude
            detailViewController.id = id

            
        }

    }
    
    func calculateDistanceBetwenTwoCountry(){
        let coordinate0 = CLLocation(latitude:Constants.METIDE_LAT,longitude:  Constants.METIDE_LONG)
        print( "Number of Country : \(StorageHelper.getAllCountrys().count)")
        if StorageHelper.getAllCountrys().count > 0 {
            for i in 0...countries.count-1{
                if countries[i].latitude != "" && countries[i].longitude != "" {
                    let coordinate1 = CLLocation(latitude: Double(countries[i].latitude!)!, longitude: Double(countries[i].longitude!)!)
                    print (coordinate1)
                    let distanceInMeters = coordinate0.distance(from: coordinate1)
                    print(distanceInMeters)
                    countries[i].distance = distanceInMeters
         
                }
                else{
                    countries[i].distance = 99999999.000000000
                }
            }
            countries = self.countries.sorted(by: {$0.distance ?? 0.0 < $1.distance ?? 0.0})
         }else {
            print("no country In data")
            for i in 0...countries.count-1{
                if countries[i].latitude != "" && countries[i].longitude != "" {
                    let coordinate1 = CLLocation(latitude: Double(countries[i].latitude!)!, longitude: Double(countries[i].longitude!)!)
                    print (coordinate1)
                    let distanceInMeters = coordinate0.distance(from: coordinate1)
                    print(distanceInMeters)
                    countries[i].distance = distanceInMeters
                    StorageHelper.save(country: countries[i])
                }
                else{
                    countries[i].distance = 99999999.000000000
                }
            }
         }
    }
}
