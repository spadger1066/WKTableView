//
//  InterfaceController.swift
//  WKTableViewWatch Extension
//
//  Created by Stephen on 20/10/2015.
//  Copyright © 2015 lumiator.technology.com. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    var headerData = Array<String>()
    
    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var button: WKInterfaceButton!

    @IBAction func getHeaderRowsFromApp() {
        configureTableRows()
        // Hide the button
        button.setHidden(true)
    }
    
    func configureTableRows(){
        if WCSession.defaultSession().reachable == true {
            let session = WCSession.defaultSession()
            session.sendMessage(["function": 1], replyHandler: { reply in
                let replyDict = reply as! [String:[String]]
                let allKeys = Array(replyDict.keys)
                self.headerData = allKeys},
                errorHandler: { error in
                    print("error: \(error)")
            })
            
            print(headerData)
            // Set the number of rows in the table
            table.setNumberOfRows(headerData.count, withRowType: "tableRow")
            
            // Set the title for each row
            for var i = 0; i < table.numberOfRows; i++ {
                let currentRow = table.rowControllerAtIndex(i) as! TableRow
                let rowTitle = headerData[i]
                currentRow.lblTitle.setText(rowTitle)
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        configureTableRows()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
