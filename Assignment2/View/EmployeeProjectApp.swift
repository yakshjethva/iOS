//
//  EmployeeProjectApp.swift
//  EmployeeProject
//
//  Created by Yaksh Jethva on 08/04/2024.
//

import SwiftUI

@main
struct EmployeeProjectApp: App {
    
    private let onboardingStatusKey = "isOnboardingCompleted"
    
    let employeeService = EmployeeService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppSettings())
                .environmentObject(EmployeeService())
        }
    }
}


class AppSettings: ObservableObject {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
}
