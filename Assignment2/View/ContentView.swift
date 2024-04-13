//
//  ContentView.swift
//  EmployeeProject
//
//  Created by Yaksh Jethva on 08/04/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        Group {
            if appSettings.isOnboardingCompleted {
                TabBarView()
            } else {
                OnBoardingScreen()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
