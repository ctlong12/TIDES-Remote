//
//  Mentors.swift
//  TIDESMentors
//
//  Created by Chandler Long on 6/29/17.
//  Copyright © 2017 Chandler Long. All rights reserved.
//

import UIKit
import Firebase

class Mentor {
    
    var mentorName: String?
    var mentorProfileImageUrl: String?
    var mentorAttributes: String?
    var ref: DatabaseReference!
    var key: String?
    
    init(mentorName: String, mentorProfileImageUrl: String, mentorAttributes: String) {
        self.mentorAttributes = mentorAttributes
        self.mentorName = mentorName
        self.mentorProfileImageUrl = mentorProfileImageUrl
    }
    
    
    //Initializing dictionary for Firebase
    init(mentorKey: String, mentorData: Dictionary<String, AnyObject>) {
        self.key = mentorKey
        
        if let mentorName = mentorData["mentorName"] as? String {
            self.mentorName = mentorName
        }
        if let mentorAttributes = mentorData["mentorAttributes"] as? String {
            self.mentorAttributes = mentorAttributes
        }
        if let mentorProfileImageUrl = mentorData["mentorProfileImageUrl"] as? String {
            self.mentorProfileImageUrl = mentorProfileImageUrl
        }
        self.ref = DataService.ds.REF_BASE.child(mentorKey)
    }
}




















