//
//  SismoTableViewController.swift
//  Sismo Api
//
//  Created by Jorge Crisóstomo Palacios on 3/4/15.
//  Copyright (c) 2015 videmor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SismoTableViewController: UITableViewController {
    
    var places = [String]()
    var dates = [String]()
    var magnitudes = [String]()
    var latitudes = [NSNumber]()
    var longitudes = [NSNumber]()
    var depths = [String]()
    
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        showQuivers()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "showQuivers", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)

        
    }
    
    func showQuivers(){
        let url = "https://sismo.herokuapp.com/quivers.json"
        
        Alamofire.request(.GET, url).responseJSON {
            (request, response, data, error) in
            
            if error == nil {
                let json = JSON(data!)
                
                for (index: String, subJson: JSON) in json["quivers"] {
                    self.places.append(subJson["place"].string!)
                    self.dates.append(subJson["date"].string!)
                    self.magnitudes.append(subJson["magnitude"].string!)
                    self.latitudes.append(subJson["latitude"].number!)
                    self.longitudes.append(subJson["longitude"].number!)
                    self.depths.append(subJson["depth"].string!)
                }
                self.tableView.reloadData()
            }
            
            self.refresher.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.places.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = self.places[indexPath.row] + " - " + self.magnitudes[indexPath.row]
        cell.detailTextLabel?.text = self.dates[indexPath.row]

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            if let destinationVC = segue.destinationViewController as? MapViewController{
                let selectedIndex = self.tableView?.indexPathForCell(sender as UITableViewCell)
                destinationVC.place = self.places[selectedIndex!.row]
                destinationVC.depth = self.depths[selectedIndex!.row]
                destinationVC.latitude = self.latitudes[selectedIndex!.row]
                destinationVC.longitude = self.longitudes[selectedIndex!.row]
                
            }
        }

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
