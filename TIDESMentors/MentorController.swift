//
//  MentorController.swift
//  TIDESMentors
//
//  Created by Chandler Long on 6/27/17.
//  Copyright © 2017 Chandler Long. All rights reserved.
//

import UIKit
import Firebase

class MentorController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var mentors = [Mentor]()
    
    @IBOutlet var addMentorView: UIView!
    @IBOutlet weak var addMentorImage: MentorImageRadius!
    @IBOutlet weak var addMentorName: UITextField!
    @IBOutlet weak var addMentorAttributes: UITextView!
    
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imageSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
            self.navigationItem.title = "Mentors"
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        pullDataFromFirebase()
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mentor = mentors[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "mentors", for: indexPath) as? MentorCell {
            if let img = MentorController.imageCache.object(forKey: NSString(string: mentor.mentorProfileImageUrl!)) {
                cell.updateMentor(mentor: mentor, img: img)
                
            }else {
                cell.updateMentor(mentor: mentor)
            }
            return cell
        }else {
            return MentorCell()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentors.count
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let mentor = self.mentors[indexPath.row]
            let parentNode = mentor.key
            DataService.ds.REF_MENTORS.child(parentNode!).removeValue()
        }
        tableView.reloadData()
    }
    
    @IBAction func addMentorTapped(_ sender: Any) {
        Animations.animatePopUpIn(view: addMentorView, controller: self)
    }
    
    @IBAction func addNewMentorTapped(_ sender: Any) {
        FirebaseData.addMentorToFirebase(mentorImage: addMentorImage, mentorName: addMentorName, mentorAttributes: addMentorAttributes, tableView: self.tableView)

        Animations.animatePopUpOut(view: addMentorView)
    }
    
    @IBAction func cancelAddMentorTapped(_ sender: Any) {
        Animations.animatePopUpOut(view: addMentorView)
    }
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //Image Picker and Pull Function
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            addMentorImage.image = image
            imageSelected = true
        } else {
            print("Please select a valid image")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func pullDataFromFirebase() {
        DataService.ds.REF_MENTORS.observe(.value, with: { (snapshot) in
            print(snapshot.value!)
            
            self.mentors = []
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshot {
                    
                    print("SNAP: \(snap)")
                    if let mentorDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let mentor = Mentor(mentorKey: key,
                                            mentorData: mentorDict)
                        self.mentors.append(mentor)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
}
