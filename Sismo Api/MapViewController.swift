//
//  MapViewController.swift
//  Sismo Api
//
//  Created by Jorge Crisóstomo Palacios on 3/5/15.
//  Copyright (c) 2015 videmor. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!

    var place: String!
    var depth: String!
    var latitude: NSNumber!
    var longitude: NSNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let lat = latitude as CLLocationDegrees
        let long = longitude as CLLocationDegrees
        var camera = GMSCameraPosition.cameraWithLatitude(lat, longitude: long, zoom: 8)
        
        var marker = GMSMarker()
        marker.position = camera.target
        marker.title = place
        marker.snippet = "Profundidad: \(depth)"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView

        mapView.camera = camera
        mapView.selectedMarker = marker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
