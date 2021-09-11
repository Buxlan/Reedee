//
//  EventDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/7/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    typealias DataType = SportEvent
    
    var data: DataType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = data?.title

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
