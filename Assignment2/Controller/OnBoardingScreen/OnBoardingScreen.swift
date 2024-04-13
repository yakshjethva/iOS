//
//  OnBoardingScreen.swift
//  EmployeeProject
//
//  Created by Yaksh Jethva on 08/04/2024.
//

import SwiftUI

struct OnBoardingScreen: View {
    @EnvironmentObject var appSettings: AppSettings
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Welcome to Employee List")
                .font(.title)
                .foregroundColor(.accentColor)
                .padding()
            
            Spacer()
            
            Button(action: {
                appSettings.isOnboardingCompleted = true
            }) {
                ZStack {
                    Circle()
                        .foregroundColor(.accentColor)
                        .frame(width: 150, height: 150)
                        .shadow(color: colorScheme == .dark ? .white : .black, radius: 10)
                    
                    
                    Text("Let's Go")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                
            }
            
            Spacer()
            
            Text("Application shows the list of employees who are fetched from the network and perform various tasks like search.")
                .font(.subheadline)
                .fontWeight(.medium)
                .padding([.leading, .trailing], 6)
                .padding(.bottom)
        }
        .padding()
    }
}

#Preview {
    OnBoardingScreen()
}
