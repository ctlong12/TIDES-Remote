//
//  MentorCell.swift
//  TIDESMentors
//
//  Created by Chandler Long on 6/29/17.
//  Copyright © 2017 Chandler Long. All rights reserved.
//

import UIKit
import Firebase

class MentorCell: UITableViewCell {
    
    @IBOutlet weak var mentorImage: MentorImageRadius!
    @IBOutlet weak var mentorName: UILabel!
    @IBOutlet weak var mentorAttributes: UILabel!
    
    var mentor: Mentor!

    func updateMentor(mentor: Mentor, img: UIImage? = nil) {
        self.mentor = mentor
        mentorName.text = mentor.mentorName
        mentorAttributes.text = mentor.mentorAttributes
        
        if img != nil {
            
            self.mentorImage.image = img
            
        } else {
            
            let ref  = Storage.storage().reference(forURL: mentor.mentorProfileImageUrl!)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download image from firebase storage")
                }else {
                    print("Image has been downloaded from firebase storage")
                    if let imageData = data {
                        
                        if let img = UIImage(data: imageData) {
                            
                            self.mentorImage.image = img
                            MentorController.imageCache.setObject(img, forKey: NSString(string: mentor.mentorProfileImageUrl!))
                        }
                    }
                }
            })
        }
    }
}
