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
}
