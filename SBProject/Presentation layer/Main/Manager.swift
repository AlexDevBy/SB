//
//  Manager.swift
//  SBProject
//
//  Created by Alex Misko on 25.01.22.
//
import Foundation
import UIKit

class Manager {
    
    static let shared = Manager()
    private init() {}
    
    func addQuestionArray(_ image: Question) {
        var images = self.loadQuestionArray()
        images.append(image)
        UserDefaults.standard.set(encodable: images, forKey: "question")
    }
    
    func loadQuestionArray() -> [Question] {
        guard let results = UserDefaults.standard.value([Question].self, forKey: "question") else {
            return []
        }
        return results
    }

}
