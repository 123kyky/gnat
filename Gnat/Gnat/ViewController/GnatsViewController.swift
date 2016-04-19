//
//  GnatsViewController.swift
//  Gnat
//
//  Created by Kyle Roberts on 4/5/16.
//  Copyright © 2016 floundertech. All rights reserved.
//

import UIKit
import CoreData

class GnatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var gnats: [Gnat]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        getGnats()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getGnats() {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Gnat")
        
        do {
            let fetchResults = try context.executeFetchRequest(fetchRequest) as? [Gnat]
            gnats = fetchResults
            
            print("Fetch results found \(fetchResults!.count) Gnats.")
        } catch {
            gnats = []
            
            print("Fetch Request did not find any Gnats.")
        }
        
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gnats != nil ? gnats.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let gnat = gnats[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel!.text = gnat.title
        
        return cell
    }

}

