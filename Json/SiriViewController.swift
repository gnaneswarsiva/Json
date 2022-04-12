//
//  SiriViewController.swift
//  Json
//
//  Created by lakshmi Raghavendra on 06/03/21.
//

import UIKit
import IntentsUI

class SiriViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var lblElapsedTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let button_AddToSiri = INUIAddVoiceShortcutButton(style: .blackOutline)
        button_AddToSiri.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button_AddToSiri)
        view.centerXAnchor.constraint(equalTo: button_AddToSiri.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: button_AddToSiri.centerYAnchor).isActive = true

        button_AddToSiri.addTarget(self, action: #selector(addToSiri(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc func addToSiri(_ sender:Any)
    {
        let activity = NSUserActivity(activityType: "com.Gnaneswar.Json.calculateelapsedtime")
        activity.title = "Get Elapsed Time" //title shown on siri shortcuts / suggestions
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.suggestedInvocationPhrase = "Get Elapsed Time"
        
        self.userActivity = activity
        self.userActivity?.becomeCurrent()

        let shortcut = INShortcut(userActivity: activity)
        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        viewController.delegate = self
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: true, completion: nil)
    }
    @IBAction func calculateElapsedTime(_ sender: Any) {
        calcElapsedTime()
    }
    
    func calcElapsedTime()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDate = dateFormatter.date(from: "2021-01-01 00:00:00")
        let seconds = startDate!.timeIntervalSinceNow as Double
        print("\(seconds) seconds")
        lblElapsedTime.text = String(format: "%f", seconds)
        
        createUserActivity()
    }
    
    func createUserActivity()
    {
        let activity = NSUserActivity(activityType: "com.Gnaneswar.Json.calculateelapsedtime")
        activity.title = "Get Elapsed Time" //title shown on siri shortcuts / suggestions
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        self.userActivity = activity
        self.userActivity?.becomeCurrent()
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
