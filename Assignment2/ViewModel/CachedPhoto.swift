//
//  CachedPhoto.swift
//  EmployeeProject
//
//  Created by Yaksh Jethva on 08/04/2024.
//

import Foundation
import SwiftUI

struct CachedPhoto: Identifiable {
    let id = UUID()
    let url: URL
    let image: UIImage
}
