//
//  UserData.swift
//  pedometer-app
//
//  Created by Jiří Pipek on 28.05.2023.
//
import Foundation
import SwiftUI

enum Gender {
    case male
    case female
}

struct Record: Hashable {
    var distance: Double
    var caloriesBurned: Double
}

class UserData: ObservableObject {
    @Published var weight: Double = 70.0
    @Published var gender: Gender = .male
    @Published var recentRecords: [Record] = []

}
