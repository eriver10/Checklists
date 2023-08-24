//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Grey on 8/24/23.
//


import UIKit
class AddItemViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    // MARK: - Actions
    @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
    }
    @IBAction func done() {
      navigationController?.popViewController(animated: true)
    }
    
}
