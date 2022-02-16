//
//  AppendTransactionsStepByStepViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import Foundation

struct AppendTransactionsStepByStepViewModel {
    
    let type: TransactionType
    
    let pattern = "^[0-9]*[.)]{0,2}[\\s;:]*(?<name>[А-ЯЁа-яёA-Za-z]*\\s*[А-ЯЁа-яёA-Za-z]*)[\\s;:]*(?<number>[#]*\\d+)[\\s;:]*(?<amount>[\\d.]*)[\\s;:]*(?<comment>[А-Яа-яёЁA-Za-z+\\d\\s]*)$"
    
    func isTextValid(_ text: String) -> Bool {
        return true
    }
    
    func parseText(_ text: String) -> [FinanceTransaction] {
        
        guard let regex = try? NSRegularExpression(pattern: pattern,
                                                   options: .caseInsensitive)
        else {
            return []
        }
        
        let substrings = text.components(separatedBy: "\n")
        let transactions = substrings.compactMap { str -> FinanceTransaction? in
            log.debug("Next string is: \(str)")
            
            var transaction = FinanceTransactionImpl()
            transaction.isActive = true
            transaction.type = type
            
            guard let match = regex.firstMatch(in: str,
                                               options: [],
                                               range: NSRange(location: 0, length: str.utf16.count)) else {
                return nil
            }
            
            if let range = Range(match.range(withName: "name"), in: str) {
                transaction.name = String(str[range])
            }
            if let range = Range(match.range(withName: "number"), in: str) {
                transaction.number = String(str[range])
            }
            if let range = Range(match.range(withName: "amount"), in: str),
               let amount = Double(str[range]) {
                    transaction.amount = amount
            }
            if let range = Range(match.range(withName: "comment"), in: str) {
                transaction.comment = String(str[range])
            }
            
            guard !(transaction.name.isEmpty && transaction.number.isEmpty) else {
                return nil
            }
            
            return transaction
        }
        
        log.debug("Found transactions are: \(transactions)")
        return transactions
        
    }
    
}
