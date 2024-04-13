//
//  TabBarView.swift
//  EmployeeProject
//
//  Created by Yaksh Jethva on 08/04/2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            EmployeeListView()
                .tabItem {
                    Label("Employee", systemImage: "person.3.fill")
                }
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    TabBarView()
}
