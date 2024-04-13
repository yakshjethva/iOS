//
//  EmployeeService.swift
//  SwiftuICrypto
//
//  Created by Yaksh Jethva on 08/11/2023.
//

import Foundation
import SwiftUI
import Combine

class EmployeeService: ObservableObject {
    @Published var employeeData: EmployeeDetailModel?
    @Published var errorMessage: ErrorMessageWrapper?
    
    @Published var cachedPhotos: [URL: UIImage] = [:]
    
    private var cachedEmployeeData: EmployeeDetailModel?
    
    func fetchData() async {
        
        if let cachedData = cachedEmployeeData {
            DispatchQueue.main.async {
                self.employeeData = cachedData
            }
            return
        }
        
        let webService = WebService()
        do {
            let data: EmployeeDetailModel = try await webService.downloadData(fromURL: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")
            DispatchQueue.main.async {
                if data.employees.isEmpty {
                    self.employeeData = nil
                    self.errorMessage = ErrorMessageWrapper(message: "No employees available")
                } else {
                    self.employeeData = data
                    self.cachedEmployeeData = data
                    self.errorMessage = nil
                }
            }
        } catch NetworkError.badUrl {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessageWrapper(message: "There was an error creating the URL")
                self.employeeData = nil
            }
        } catch NetworkError.badResponse {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessageWrapper(message: "Did not get a valid response")
                self.employeeData = nil
            }
        } catch NetworkError.badStatus {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessageWrapper(message: "Did not get a 2xx status code from the response")
                self.employeeData = nil
            }
        } catch NetworkError.failedToDecodeResponse {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessageWrapper(message: "Failed to decode response into the given type")
                self.employeeData = nil
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessageWrapper(message: "An error occurred downloading the data: \(error.localizedDescription)")
                self.employeeData = nil
            }
        }
    }
    
    func loadPhoto(for employee: Employee) async {
        let photoURL = URL(string: employee.photoUrlLarge)!
        if let cachedImage = cachedPhotos[photoURL] {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: photoURL)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.cachedPhotos[photoURL] = image
                }
            } else {
                DispatchQueue.main.async {
                    self.cachedPhotos[photoURL] = UIImage(systemName: "person.fill")
                }
            }
        } catch {
            print("Failed to load photo: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.cachedPhotos[photoURL] = UIImage(systemName: "person.fill")
            }
        }
    }

}
