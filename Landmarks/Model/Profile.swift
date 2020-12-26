//
//  Profile.swift
//  Landmarks
//
//  Created by Brian Zhang on 2020-12-26.
//

import Foundation

struct Profile {
    var username: String
    var prefersNotification = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    
    static let `default` = Profile(username: "Brian") // backticks are used for reserved words such as "default" here
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌹"
        case summer = "😎"
        case autumn = "🍁"
        case winter = "☃️"
        
        var id: String {
            String(self.rawValue)
        }
    }
    
}
