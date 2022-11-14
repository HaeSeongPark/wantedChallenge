//
//  Student.swift
//  MyCreditManager
//
//  Created by rhino Q on 2022/11/13.
//

import Foundation

final class Student {
    typealias ReportCard = (name:String, grade:Grade)
    let name:String
    private var reportCard:[ReportCard] = []
    
    private var average:Double {
        return reportCard
            .map { $0.grade.point }
            .reduce(0, +) / Double(reportCard.count)
    }
    
    private var averageReport:String {
        return String(format: "%.2f", average)
    }
    
    init(name:String) {
        self.name = name
    }
    
    func addReport(name:String, grade:Grade) {
        self.reportCard.append((name:name, grade:grade))
    }
    
    func deleteReport(name:String) {
        guard let indexToDelete = self.reportCard.firstIndex (where: { $0.name == name }) else {
            return
        }
        self.reportCard.remove(at: indexToDelete)

    }
    
    func showReport() -> String {
        guard !reportCard.isEmpty else {
            return "보여줄 성적이 없습니다."
        }
        let allReport = reportCard.map { "\($0.name): \($0.grade.rawValue)"}.joined(separator: "\n")
        return allReport + "\n\(averageReport)"
    }
}
