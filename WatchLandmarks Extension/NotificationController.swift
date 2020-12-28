//
//  NotificationController.swift
//  WatchLandmarks Extension
//
//  Created by Brian Zhang on 2020-12-27.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
    var title: String?
    var message: String?
    var landmark: Landmark?
    
    let landmarkIndexKey = "landmarkIndex"

    override var body: NotificationView {
        return NotificationView(title: title, message: message, landmark: landmark)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        let modelData = ModelData()
        
        let notificationData = notification.request.content.userInfo as? [String: Any]
        
        let aps = notificationData?["aps"] as? [String: Any] // aps dictionary contains one or more additional Apple-defined keys. Refer to: /* https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification#2943363 */
        
        let alert = aps?["alert"] as? [String: Any]
        
        title = alert?["title"] as? String
        message = alert?["body"] as? String
        
        if let index = notificationData?[landmarkIndexKey] as? Int {
            landmark = modelData.landmarks[index]
        }
    }
}
