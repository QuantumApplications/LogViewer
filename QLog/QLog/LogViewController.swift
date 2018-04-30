//
//  LogViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

protocol LogViewControllerDelegate: class {

    func back(_ logViewController: LogViewController)
    func action(_ logViewController: LogViewController, sender: UIBarButtonItem)

}

class LogViewController: UIViewController {

    static let font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: UIFont.Weight.medium)

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logLevelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var logLevelSegmentedControlHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!

    weak var delegate: LogViewControllerDelegate?

    init(cancelButton: Bool = false) {
        super.init(nibName: "LogViewController", bundle: Bundle(identifier: "qa.quantum.QLog")!)
        self.loadView()
        // Add bar buttons
        if cancelButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(action))
        // Allow scrolling if navigation bars are opaque (WTF Apple?)
        self.extendedLayoutIncludesOpaqueBars = true
        self.tabBarItem = UITabBarItem(title: QLog.Texts.live, image: QLog.Images.live, tag: 1)
        // Set segmented control
        self.logLevelSegmentedControl.selectedSegmentIndex = UiLogger.getShared().logLevel.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    func log(_ logEntry: LogEntry) {
        let attributedMetaText = NSMutableAttributedString(string: "\n\(logEntry.metaText)", attributes: [NSAttributedStringKey.foregroundColor: QLog.colorText, NSAttributedStringKey.font: LogViewController.font])
        let attributedText = NSMutableAttributedString(string: "\(logEntry.text)", attributes: [NSAttributedStringKey.foregroundColor: logEntry.logLevel.color, NSAttributedStringKey.font: LogViewController.font])
        let oldText = NSMutableAttributedString(attributedString: (self.textView.attributedText))
        oldText.append(attributedMetaText)
        oldText.append(attributedText)
        self.textView.attributedText = oldText
    }

    func showLog(_ logUrl: URL) {
        self.logLevelSegmentedControl.isHidden = true
        self.logLevelSegmentedControlHeight.constant = 0
        self.textView.text = String(data: (try? Data(contentsOf: logUrl)) ?? Data(), encoding: .utf8)
    }

    // MARK: - Navigation

    @IBAction func logLevelSegmentedControlValueChanged(_ sender: Any) {
        UiLogger.getShared().logLevel = LogLevel(rawValue: self.logLevelSegmentedControl.selectedSegmentIndex) ?? UiLogger.getShared().logLevel
    }

    @objc func back() {
        self.delegate?.back(self)
    }

    @objc func action(_ sender: UIBarButtonItem) {
        self.delegate?.action(self, sender: sender)
    }

}
