//
//  ViewController.swift
//  LogViewerExample
//
//  Created by Christian Oberdörfer on 23.01.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

import LogViewer
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        for _ in 1..<100 {
            QLogDebug("Test")
        }
        super.viewDidLoad()
    }

}
