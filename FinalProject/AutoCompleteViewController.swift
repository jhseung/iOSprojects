//
//  CitySearch.swift
//  FinalProject
//
//  Created by Ji Hwan Seung on 24/04/2017.
//  Copyright © 2017 Ji Hwan Seung. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class AutoCompleteViewController: UIViewController {
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let searchView = UIView(frame: CGRect(x: 0, y: 65, width: view.frame.width, height: view.frame.height))
        
        searchView.addSubview(searchController)
        view.addSubview(searchView)
        searchController.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        
        definesPresentationContext = true
        
    }
    
}

extension AutoCompleteViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("\(place.name)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("\(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
