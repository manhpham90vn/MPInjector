//
//  ViewController.swift
//  Example
//
//  Created by Manh Pham on 05/12/2022.
//

import UIKit
import MPInjector

class ViewController: UIViewController {

    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ViewController", viewModel.request())
        print("ViewController", viewModel.save())
    }


}

