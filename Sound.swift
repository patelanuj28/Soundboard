//
//  Sound.swift
//  Soundboard
//
//  Created by Anuj Patel on 2/16/15.
//  Copyright (c) 2015 Anuj Patel. All rights reserved.
//

import Foundation
import CoreData

class Sound: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var url: String

}
