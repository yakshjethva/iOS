//
//  EmployeeListView.swift
//  EmployeeProject
//
//  Created by Yaksh Jethva on 08/04/2024.
//

import SwiftUI

struct EmployeeListView: View {
    @StateObject var employeeService = EmployeeService()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if let employees = filteredEmployees {
                    List(employees, id: \.uuid) { employee in
                        NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                            EmployeeRow(employee: employee)
                                .onAppear {
                                    Task {
                                        await employeeService.loadPhoto(for: employee)
                                    }
                                }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .background(Color(UIColor.systemGray6))
            .navigationBarTitle("Employee List", displayMode: .large)
            .searchable(text: $searchText)
            .refreshable {
                await employeeService.fetchData()
            }
        }
        .alert(item: $employeeService.errorMessage) { errorMessage in
            Alert(
                title: Text("Error"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            Task {
                await employeeService.fetchData()
            }
        }
    }
    
    // Computed property to filter employees based on search text
    var filteredEmployees: [Employee]? {
        guard !searchText.isEmpty else { return employeeService.employeeData?.employees }
        return employeeService.employeeData?.employees.filter { employee in
            employee.fullName.lowercased().contains(searchText.lowercased())
        }
    }
}


struct EmployeeRow: View {
    @EnvironmentObject var employeeService: EmployeeService
    let employee: Employee
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let photoURL = URL(string: employee.photoUrlLarge),
                   let cachedImage = employeeService.cachedPhotos[photoURL] {
                    Image(uiImage: cachedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
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
            }
            
            VStack(alignment: .leading) {
                Text(employee.fullName)
                    .font(.system(size: 17, weight: .bold))
                
                Text("Team: \(employee.team)")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 16)
        }
    }
}

#Preview {
    EmployeeListView()
}

