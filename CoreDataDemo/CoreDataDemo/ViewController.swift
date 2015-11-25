//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Kerolos Nakhla on 11/24/15.
//  Copyright © 2015 Kerolos Nakhla. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    /* To store and retrieve data using Core Data a reference to the application delegate's managed object context is required */
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var status: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func saveData(sender: AnyObject) {
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
        let contact = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        contact.name = name.text!
        contact.address = address.text!
        contact.phone = phone.text!
        
        do {
            try managedObjectContext.save()
            name.text = ""
            address.text = ""
            phone.text = ""
            status.text = "Contact Saved!"
            
        } catch let error as NSError {
            status.text = error.localizedFailureReason
        }
        
    }

    @IBAction func findContact(sender: AnyObject) {
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(name = %@)", name.text!)
        request.predicate = pred
        
        do {
            var results = try managedObjectContext.executeFetchRequest(request)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                name.text = match.valueForKey("name") as? String
                address.text = match.valueForKey("address") as? String
                phone.text = match.valueForKey("phone") as? String
                status.text = "Matches found: \(results.count)"
            } else {
                status.text = "No Match"
            }
        } catch let error as NSError {
            status.text = error.localizedFailureReason
        }
    }

}

