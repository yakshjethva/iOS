//
//  EmployeeDetailModel.swift
//  EmployeeProject
//
//  Created by EMP on 08/04/2024.
//

import Foundation


struct EmployeeDetailModel: Codable {
    let employees: [Employee]
}

struct Employee: Codable {
    let uuid: String
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let photoUrlSmall: String
    let photoUrlLarge: String
    let team: String
    let employeeType: String
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography = "biography"
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team = "team"
        case employeeType = "employee_type"
    }
}
