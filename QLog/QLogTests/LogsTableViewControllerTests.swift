//
//  LogsTableViewControllerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 04.04.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class LogsTableViewControllerTests: XCTestCase {

    // MARK: - Table view data source

    func testNumberOfSections() {
        // 1. Arrange
        let logsTableViewController = LogsTableViewController()

        // 3. Assert
        XCTAssertEqual(logsTableViewController.numberOfSections(in: logsTableViewController.tableView), 1)
    }

    func testNumberOfRowsInSection() {
        // 1. Arrange
        let logsTableViewController = LogsTableViewController()

        // 3. Assert
        XCTAssertEqual(logsTableViewController.tableView(logsTableViewController.tableView, numberOfRowsInSection: 0), 0)
    }

    func testHeightForRowAt() {
        // 1. Arrange
        let logsTableViewController = LogsTableViewController()

        // 3. Assert
        XCTAssertEqual(logsTableViewController.tableView(logsTableViewController.tableView, heightForRowAt: IndexPath(row: 0, section: 0)), 44.0)
    }

}
