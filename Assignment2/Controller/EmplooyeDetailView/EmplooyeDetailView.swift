//
//  EmplooyeDetailView.swift
//  EmployeeProject
//
//  Created by Yaksh Jethva on 08/04/2024.
//

import SwiftUI

struct EmployeeDetailView: View {
    let employee: Employee
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var employeeService: EmployeeService
    
    var body: some View {
        VStack {
            if let photoURL = URL(string: employee.photoUrlLarge),
               let cachedImage = employeeService.cachedPhotos[photoURL] {
                Image(uiImage: cachedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
            } else {
                ProgressView()
                    .onAppear {
                        Task {
                            await employeeService.loadPhoto(for: employee)
                        }
                    }
            }
            Text(employee.fullName)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Phone:")
                    Spacer()
                    Text(employee.phoneNumber)
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Email:")
                    Spacer()
                    Text(employee.emailAddress)
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Biography:")
                    Spacer()
                    Text(employee.biography)
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Team:")
                    Spacer()
                    Text(employee.team)
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Type:")
                    Spacer()
                    Text(employee.employeeType.formatEmployeeType())
                    Spacer()
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(.top, 16)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Pop the view
                }) {
                    HStack {
                        Image(systemName: "chevron.left") // Custom back button icon
                        Text("Employee") // Custom back button text
                    }
                }
            }
        )
    }
}

#Preview {
    EmployeeDetailView(employee: Employee(uuid: "", fullName: "", phoneNumber: "", emailAddress: "", biography: "", photoUrlSmall: "", photoUrlLarge: "", team: "", employeeType: ""))
}

extension String {
    func formatEmployeeType() -> String {
        switch self {
        case "FULL_TIME":
            return "Full time"
        case "PART_TIME":
            return "Part time"
        case "CONTRACTOR":
            return "Contractor"
        default:
            return self // Return the original string if no conversion needed
        }
    }
}
