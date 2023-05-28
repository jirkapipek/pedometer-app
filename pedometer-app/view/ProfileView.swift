//
//  ProfileView.swift
//  pedometer-app
//
//  Created by Jiří Pipek on 28.05.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Text("Profil")
                .font(.title)
                .padding()
            
            VStack {
                Text("Váha (kg)")
                    .padding(.bottom, 5)
                
                TextField("", value: $userData.weight, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            Picker("Pohlaví", selection: $userData.gender) {
                Text("Muž").tag(Gender.male)
                Text("Žena").tag(Gender.female)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}
