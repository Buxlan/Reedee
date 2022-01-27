//
//  SystemSettings.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 23.01.2022.
//

import Foundation

public class SystemSettings: NSObject, NSCoding {
    var technicalSupportPhone: String = ""
    var foreighnTechnicalSupportPhone: String = ""
    var termsOfUseLink: String = ""
    var analyticsApiToken: String = ""
    var currencySymbol: String = ""
    var aboutCompanyLink: String? = ""

    public init(_ termsOfUseLink: String = "") {
        self.termsOfUseLink = termsOfUseLink
    }
    
    public required init(coder decoder: NSCoder) {
        self.technicalSupportPhone = decoder.decodeObject(forKey: "technicalSupportPhone") as? String ?? ""
        self.foreighnTechnicalSupportPhone = decoder.decodeObject(forKey: "foreighnTechnicalSupportPhone") as? String ?? ""
        self.termsOfUseLink = decoder.decodeObject(forKey: "termsOfUseLink") as? String ?? ""
        self.analyticsApiToken = decoder.decodeObject(forKey: "analyticsApiToken") as? String ?? ""
        self.currencySymbol = decoder.decodeObject(forKey: "currencySymbol") as? String ?? ""
        self.aboutCompanyLink = decoder.decodeObject(forKey: "aboutCompanyLink") as? String ?? nil
    }

    public func encode(with coder: NSCoder) {
        coder.encode(technicalSupportPhone, forKey: "technicalSupportPhone")
        coder.encode(foreighnTechnicalSupportPhone, forKey: "foreighnTechnicalSupportPhone")
        coder.encode(termsOfUseLink, forKey: "termsOfUseLink")
        coder.encode(analyticsApiToken, forKey: "analyticsApiToken")
        coder.encode(currencySymbol, forKey: "currencySymbol")
        coder.encode(aboutCompanyLink, forKey: "aboutCompanyLink")        
    }
}

