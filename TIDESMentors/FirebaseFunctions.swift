//
//  FirebaseFunctions.swift
//  TIDESMentors
//
//  Created by Chandler Long on 6/29/17.
//  Copyright © 2017 Chandler Long. All rights reserved.
//

import Firebase
import UIKit

class FirebaseData {
    
    static func addMentorToFirebase(mentorImage: UIImageView, mentorName: UITextField, mentorAttributes: UITextView, tableView: UITableView) {
        
        if let imgData = UIImageJPEGRepresentation(mentorImage.image!, 0.2) {
            
            let imageUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_MENTOR_IMAGES.child(imageUid).putData(imgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Unable to upload image to firebase storage")
                    
                }else {
                    print("Successfully uploaded image to firebase storage")
                    let downloadUrl = metadata?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        let postMentors: Dictionary<String, AnyObject> = [
                            "mentorName": mentorName.text! as AnyObject, "mentorAttributes": mentorAttributes.text! as AnyObject, "mentorProfileImageUrl": url as AnyObject]
                        
                        let firebasePost = DataService.ds.REF_MENTORS.childByAutoId()
                        firebasePost.setValue(postMentors)
                        
                        tableView.reloadData()
                    }
                }
            }
        }
    }
}
