//
//  MyCredidtManager.swift
//  MyCreditManager
//
//  Created by rhino Q on 2022/11/11.
//

import Foundation

struct MyCredidtManager {
    
    private var studentManager = StudentManager()
    
    mutating func start() {
        
        while true {
            
            printMessage(with: .mainPrompt)
                        
            guard let command = readLine(), let menu = MainMenu(rawValue: command) else {
                printMessage(with: .invalidInputForMain)
                continue
            }
            
            switch menu {
            case .addStuduent:
                addStudent()
            case .deleteStudent:
                deleteStudent()
            case .addGrade:
                addReportToStudent()
            case .deleteGrade:
                print("성적 삭제")
            case .showGrade:
                showReport()
            case .exit:
                printMessage(with: .exit)
                exit(0)
            }
        }
    }
    
    private mutating func addStudent() {
        printMessage(with: .addStudent)
        guard let name = readLine(), !name.isEmpty else {
            printMessage(with: .invalidInput)
            return
        }
        
        
        if studentManager.addStudent(with: name) {
            printMessage(with: .successOfAddStudent(name: name))
        } else {
            printMessage(with: .duplicatedName(name: name))
        }
        
        return
    }
    
    private mutating func addReportToStudent() {
        printMessage(with: .addReportToStudent)
        guard let command = readLine(), !command.isEmpty else {
            printMessage(with: .invalidInput)
            return
        }
        
        let splitedCommand = command.split(separator: " ").map { String($0)}
        
        guard splitedCommand.count == 3 else {
            printMessage(with: .invalidInput)
            return
        }
        
        guard let subjectGrade:Grades  = Grades(rawValue: splitedCommand[2]) else {
            printMessage(with: .invalidInput)
            return
        }
        
        let studentName:String = splitedCommand[0]
        let subjectName:String = splitedCommand[1]
        
        let result = studentManager.addReportToStudent(studentName: studentName,
                                          subjectName: subjectName,
                                          subjectGrade: subjectGrade)
        if result {
            printMessage(with: .successofAddReportToStudent(studentName: studentName,
                                                            subjectName: subjectName,
                                                            subjectGrade: subjectGrade))
        } else {
            printMessage(with: .nonexistentStudent(name: studentName))
        }
        
    }
    
    private mutating func showReport() {
        printMessage(with: .showReport)
        
        guard let name = readLine(), !name.isEmpty else {
            printMessage(with: .invalidInput)
            return
        }
        
        if !studentManager.showReport(of:name) {
            printMessage(with: .nonexistentStudent(name: name))
        }
    }
    
    private mutating func deleteStudent() {
        printMessage(with: .deleteStudent)
        
        guard let name = readLine(), !name.isEmpty else {
            printMessage(with: .invalidInput)
            return
        }
        
        if studentManager.deleteStudent(with: name) {
            printMessage(with: .successOfDeleteStudent(name: name))
        } else {
            printMessage(with: .nonexistentStudent(name: name))
        }
        
    }
}

// MARK: - Util
extension MyCredidtManager {
    
    private func printMessage(with message:Message) {
        print(message.description)
    }
}

// MARK: - MainMenu
extension MyCredidtManager {
    enum MainMenu:String,CaseIterable {
        case addStuduent = "1"
        case deleteStudent = "2"
        case addGrade = "3"
        case deleteGrade = "4"
        case showGrade = "5"
        case exit = "X"
        
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
        case invalidInputForMain
        case addStudent
        case invalidInput
        case successOfAddStudent(name:String)
        case duplicatedName(name:String)
        case deleteStudent
        case successOfDeleteStudent(name:String)
        case nonexistentStudent(name:String)
        case addReportToStudent
        case showReport
        case successofAddReportToStudent(studentName:String,
                                         subjectName:String,
                                         subjectGrade:Grades)

        var description:String {
            switch self {
            case .mainPrompt:
                return """
                원하는 기능 입력해주세요
                \(MainMenu.allTitle)
                """
            case .exit:
                return "프로그램을 종료합니다..."
            case .invalidInputForMain:
                return  "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
            case .addStudent:
                return "추가할 학생의 이름을 입력해주세요"
            case .invalidInput:
                return "입력이 잘못되었습니다. 다시 확인해주세요"
            case .successOfAddStudent(let name):
                return "\(name) 학생을 추가했습니다."
            case .duplicatedName(let name):
                return "\(name)은 이미 존자해는 학생입니다. 추가하지 않습니다."
            case .deleteStudent:
                return "삭제할 학생의 이름을 입력해주세요"
            case .successOfDeleteStudent(let name):
                return "\(name) 학생을 삭제하였습니다."
            case .nonexistentStudent(let name):
                return "\(name) 학생을 찾지 못했습니다."
            case .addReportToStudent:
                return """
            성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
            입력예) Mickey Swift A+
            만약에 학생의 성적. 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
            """
            case .showReport:
                return "평점을 알고싶은 학생의 이름을 입력해주세요"
            case .successofAddReportToStudent(let studnetName, let subjectName, let subjectGrade):
                return "\(studnetName) 학생의 \(subjectName) 과목이. \(subjectGrade.rawValue)로 추가(변경)되었습니다."
            }
        }
    }
}
