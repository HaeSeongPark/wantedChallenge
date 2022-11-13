//
//  Student.swift
//  MyCreditManager
//
//  Created by rhino Q on 2022/11/13.
//

import Foundation

struct Student {
    typealias ReportCard = (name:String, grade:String)
    private let name:String
    private var reportCard:[ReportCard] = []
    
    private var average:Double {
        return reportCard
            .compactMap { Grades(rawValue: $0.grade) }
            .map { $0.point }
            .reduce(0, +) / Double(reportCard.count)
    }
    
    private var averageReport:String {
        return String(format: "%.2f", "\(average)")
    }
    
    init(name:String) {
        self.name = name
    }
    
    mutating func addReport(name:String, grade:String) {
        self.reportCard.append((name:name, grade:grade))
    }
    
    mutating func deleteReport(name:String) {
        guard let indexToDelete = self.reportCard.firstIndex (where: { $0.name == name }) else {
            return
        }
        self.reportCard.remove(at: indexToDelete)

    }
    
    func showReport() -> String {
        let allReport = reportCard.map { "\($0.name): \($0.grade)"}.joined(separator: "\n")
        return allReport + "\n\(averageReport)"
    }
}
