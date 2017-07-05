//
//  StoryboardIdentifiable.swift
//  PatrickMaster
//
//  Created by indianic on 17/04/17.
//  Copyright © 2017 indianic. All rights reserved.
//


import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}


