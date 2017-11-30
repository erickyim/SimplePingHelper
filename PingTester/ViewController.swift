//
//  ViewController.swift
//  PingTester
//
//  Created by cyvoit on 2017-11-30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ipAddrField: UITextField!
    @IBOutlet weak var resultsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        ipAddrField.text = "192.168.30.138";
        resultsView.text = nil;
    }

    func log(_ text: String) -> Void {
        resultsView.text = resultsView.text.appending("\(text)\n");
    }

    @IBAction func start(_ sender: UIBarButtonItem) {
        resultsView.text = "";
        log("--------")
        log("Tapped Ping")

        if let address = ipAddrField.text {
            SimplePingHelper.ping(address) { (success, reason) in
                if success {
                    self.log("SUCCESS")
                } else if let reason = reason {
                    self.log("FAILURE: \(reason)")
                } else {
                    self.log("FAILURE")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

