//
//  UIStoryboardExtension.swift
//  VacationPlanner
//
//  Created by Daniel Oliveira on 27/12/18.
//  Copyright © 2018 Daniel Oliveira. All rights reserved.
//

import UIKit

extension UIStoryboard {
    convenience init(name: StoryboardName) {
        self.init(name: name.rawValue, bundle: nil)
    }
}
