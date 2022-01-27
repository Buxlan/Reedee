//
//  PhoneCode.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 23.01.2022.
//

struct PhoneCode {
    
    var dialCode: String
    var countryCode: String
    var name: String

    init(dialCode: String = "",
         countryCode: String = "",
         name: String = "") {
        self.dialCode = dialCode
        self.countryCode = countryCode
        self.name = name
    }
}

extension PhoneCode: Hashable {    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(dialCode.hashValue)
    }

    static func ==(lhs: PhoneCode, rhs: PhoneCode) -> Bool {
        if lhs.dialCode != rhs.dialCode {
            return false
        }
        return true
    }
    
}
