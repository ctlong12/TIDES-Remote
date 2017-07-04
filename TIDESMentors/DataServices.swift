//
//  DataServices.swift
//  TIDESMentors
//
//  Created by Chandler Long on 6/29/17.
//  Copyright © 2017 Chandler Long. All rights reserved.
//

import Foundation
import UIKit
import Firebase


let DB_BASE = Database.database().reference() //contains the root of our database
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //DB References
    private var _REF_BASE = DB_BASE
    private var _REF_MENTORS = DB_BASE.child("mentors")
    
    //Storage Reference
    private var _REF_MENTOR_IMAGE = STORAGE_BASE.child("mentor-images")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_MENTORS: DatabaseReference {
        return _REF_MENTORS
    }
    
    var REF_MENTOR_IMAGES: StorageReference {
        return _REF_MENTOR_IMAGE
    }
    
}
