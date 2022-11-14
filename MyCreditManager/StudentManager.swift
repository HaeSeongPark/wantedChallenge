//
//  StudentManager.swift
//  MyCreditManager
//
//  Created by rhino Q on 2022/11/14.
//

import Foundation
struct StudentManager {
    private var students:[Student] = []
    private var namesOfStudent:[String] {
        return students.map { $0.name } 
    }
    
    mutating func addStudent(with name:String) -> Bool {
        if namesOfStudent.contains(name) {
            return false
        }
        
        let student = Student(name: name)
        students.append(student)
        
        return true
    }
    
    mutating func deleteStudent(with name:String) -> Bool {
        guard let indexToDelete = self.students.firstIndex(where: { $0.name == name}) else {
            return false
        }
        self.students.remove(at: indexToDelete)
        return true
    }
    
    mutating func addReportToStudent(studentName:String,
                                     subjectName:String,
                                     subjectGrade:Grade) -> Bool {
        guard let student = self.students.first(where: { $0.name == studentName}) else {
            return false
        }
        
        student.addReport(name: subjectName, grade: subjectGrade)
        
        return true
    }
    
    mutating func deleteReportToStudent(studentName:String,
                                        subjectName:String) -> Bool {
        guard let student = self.students.first(where: { $0.name == studentName}) else {
            return false
        }
        student.deleteReport(name: subjectName)
        return true
    }
    
    func showReport(of name:String) -> Bool {
        guard let student = self.students.first(where: { $0.name == name}) else {
            return false
        }
        
        print(student.showReport())
        return true
    }
}
