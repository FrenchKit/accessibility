//
//  ViewController.swift
//  frenchkit-accessibility
//
//  Created by amath on 13/09/16.
//  Copyright © 2016 amath. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btn: UIButton!
    var places = [Place(title: "BarIOS", locationName: "Bar", coordinate: CLLocationCoordinate2DMake(48.8578841, 2.38887869), imageName: "bar"), Place(title: "RestaurantIOS", locationName: "Restaurant", coordinate: CLLocationCoordinate2DMake(48.857741, 2.39017), imageName: "img_resto"), Place(title: "DiscoIOS", locationName: "Discotheque", coordinate: CLLocationCoordinate2DMake(48.857431, 2.386544), imageName: "discotheque")]
    
    private enum DISPLAY_MODE {
        case List
        case Map
    }
    
    private var displayMode: DISPLAY_MODE = .Map{
        didSet{
            switch displayMode{
            case .List:
                mapView.hidden = true
                tableView.hidden = false
                btn.setTitle("MAP", forState: .Normal)
                break
            case .Map:
                mapView.hidden = false
                tableView.hidden = true
                btn.setTitle("LIST", forState: .Normal)
                break
            }
        }
    }
    
    let initialLocation = CLLocation(latitude: 48.8574089, longitude: 2.38664370)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centerMapOnLocation(initialLocation)
        addAnnotationsToTheMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Just change the displayMode mode. The display will change in variable's didSet
    @IBAction func display(sender: UISwitch) {
        switch displayMode{
        case .List:
            displayMode = .Map
            break
        case .Map:
            displayMode = .List
            break
            
        }
    }
    
    private func addAnnotationsToTheMap(){
        mapView.addAnnotations(places)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func showDetailsViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewControllerWithIdentifier("detailsVC") as! DetailsViewController
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }


}

extension ViewController: MKMapViewDelegate{
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let placeAnnotation = annotation as? Place {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
            view.image = UIImage(named: placeAnnotation.imageName!)
            //let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            return view
        }
        return nil
        
    }
    
    func mapView(mapView: MKMapView,
                   annotationView view: MKAnnotationView,
                                  calloutAccessoryControlTapped control: UIControl){
        showDetailsViewController()
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showDetailsViewController()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let place = places[indexPath.row]
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
        cell.textLabel!.text = place.title
        cell.imageView?.image = UIImage(named:place.imageName!)
        return cell
    }
}

