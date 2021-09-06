//
//  User.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import Firebase

// MARK: - Extending a `Firebase User` to conform to `DataSourceProvidable`
extension User: DataSourceProvidable {
    private var infoSection: AuthSection {
        let items = [AuthItem(title: providerID, detailTitle: "Provider ID"),
                     AuthItem(title: uid, detailTitle: "UUID"),
                     AuthItem(title: displayName ?? "––", detailTitle: "Display Name", isEditable: true),
                     AuthItem(
                        title: photoURL?.absoluteString ?? "––",
                        detailTitle: "Photo URL",
                        isEditable: true
                     ),
                     AuthItem(title: email ?? "––", detailTitle: "Email", isEditable: true),
                     AuthItem(title: phoneNumber ?? "––", detailTitle: "Phone Number")]
        return AuthSection(headerDescription: "Info", items: items)
    }
    
    private var metaDataSection: AuthSection {
        let metadataRows = [
            AuthItem(title: metadata.lastSignInDate?.description, detailTitle: "Last Sign-in Date"),
            AuthItem(title: metadata.creationDate?.description, detailTitle: "Creation Date")
        ]
        return AuthSection(headerDescription: "Firebase Metadata", items: metadataRows)
    }
    
    private var otherSection: AuthSection {
        let otherRows = [AuthItem(title: isAnonymous ? "Yes" : "No", detailTitle: "Is User Anonymous?"),
                         AuthItem(title: isEmailVerified ? "Yes" : "No", detailTitle: "Is Email Verified?")]
        return AuthSection(headerDescription: "Other", items: otherRows)
    }
    
    private var actionSection: AuthSection {
        let actionsRows = [
            AuthItem(title: AuthUserAction.refreshUserInfo.rawValue, textColor: .systemBlue),
            AuthItem(title: AuthUserAction.signOut.rawValue, textColor: .systemBlue),
            AuthItem(title: AuthUserAction.link.rawValue, textColor: .systemBlue, hasNestedContent: true),
            AuthItem(title: AuthUserAction.requestVerifyEmail.rawValue, textColor: .systemBlue),
            AuthItem(title: AuthUserAction.tokenRefresh.rawValue, textColor: .systemBlue),
            AuthItem(title: AuthUserAction.delete.rawValue, textColor: .systemRed)
        ]
        return AuthSection(headerDescription: "Actions", items: actionsRows)
    }
    
    var sections: [AuthSection] {
        [infoSection, metaDataSection, otherSection, actionSection]
    }
}
