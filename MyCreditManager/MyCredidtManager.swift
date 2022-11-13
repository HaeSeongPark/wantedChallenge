//
//  MyCredidtManager.swift
//  MyCreditManager
//
//  Created by rhino Q on 2022/11/11.
//

import Foundation

struct MyCredidtManager {
    
    func start() {
        while true {
            
            printMessage(with: .mainPrompt)
                        
            guard let command = readLine(), let menu = MainMenu(rawValue: command) else {
                printMessage(with: .invalidInputForMain)
                continue
            }
            
            switch menu {
            case .addStuduent:
                print("학생 추가")
            case .deleteStudent:
                print("학생 삭제")
            case .addGrade:
                print("성적추가(변경)")
            case .deleteGrade:
                print("성적 삭제")
            case .showGrade:
                print("평점보기")
            case .exit:
                printMessage(with: .exit)
                exit(0)
            }
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
            }
        }
    }
}
