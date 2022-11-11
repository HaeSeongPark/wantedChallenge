//
//  MyCredidtManager.swift
//  MyCreditManager
//
//  Created by rhino Q on 2022/11/11.
//

import Foundation

struct MyCredidtManager {
    
    let mainPrompt:String = """
            원하는 기능 입력해주세요
            \(MainMenu.allTitle)
            """
    
    func start() {
        while true {
            
            printMessage(with: .mainPrompt)
            
            let command = readLine()
                        
            if isExit(command) {
                printMessage(with: .exit)
                exit(0)
            }
            
            if !isValid(command) {
                printMessage(with: .notValid)
                continue
            }
            
            addStudent()
            
        }
    }
    
    func addStudent() {
        
    }
    
}

// MARK: - Util
extension MyCredidtManager {
    private func isExit(_ command:String?) -> Bool {
        command == "X" || command == "x"
    }
    
    private func isValid(_ command:String?) -> Bool {
        guard let inputToNumber = Int(command ?? "") else {
            return false
        }
        
        if !(1...MainMenu.allCases.count - 1).contains(inputToNumber) {
            return false
        }
        
        return true
    }
    
    private func printMessage(with message:Message) {
        print(message.description)
    }
}

// MARK: - MainMenu
extension MyCredidtManager {
    enum MainMenu:CaseIterable {
        case addStuduent
        case deleteStudent
        case addGrade
        case deleteGrade
        case showGrade
        case exit
        
        private var title:String {
            switch self {
            case .addStuduent:
                return "1: 학생추가"
            case .deleteStudent:
                return "2: 학생 삭제"
            case .addGrade:
                return "3: 성적추가(변경)"
            case .deleteGrade:
                return "4: 성적삭제"
            case .showGrade:
                return "5: 평점보기"
            case .exit:
                return "X: 종료"
            }
        }
        
        static var allTitle: String {
            return MainMenu.allCases.map { $0.title }.joined(separator: ", ")
        }
    }
}
// MARK: - Message
extension MyCredidtManager {
    enum Message {
        case mainPrompt
        case exit
        case notValid
        case addStudent
        
        var description:String {
            switch self {
            case .mainPrompt:
                return """
                원하는 기능 입력해주세요
                \(MainMenu.allTitle)
                """
            case .exit:
                return "프로그램을 종료합니다..."
            case .notValid:
                return  "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
            case .addStudent:
                return "추가할 학생의 이름을 입력해주세요"
            }
        }
    }
}
