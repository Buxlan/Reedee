// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

/// Firebase Auth supported identity providers and other methods of authentication
enum AuthProvider: String {
    case registration = "registration"
    case google = "google.com"
    case facebook = "facebook.com"
    case emailPassword = "emailAuth"
    case anonymous = "anonymous"
    
    /// More intuitively named getter for `rawValue`.
    var id: String { self.rawValue }
    
    /// The UI friendly name of the `AuthProvider`. Used for finding item's image.
    var name: String {
        switch self {
        case .google:
            return "Google"
        case .facebook:
            return "Facebook"
        case .emailPassword:
            return "emailAuth"
        case .anonymous:
            return "anonymous"
        case .registration:
            return "personCropCircleBadgePlus"
        }
    }
    
    var title: String {
        switch self {
        case .google:
            return L10n.Auth.googleSignIn
        case .facebook:
            return L10n.Auth.facebookSignIn
        case .emailPassword:
            return L10n.Auth.emailPasswordSignIn
        case .anonymous:
            return L10n.Auth.anonymousSignIn
        case .registration:
            return L10n.Auth.signUp
        }
    }
    
    /// Failable initializer to create an `AuthProvider` from it's corresponding `name` value.
    /// - Parameter rawValue: String value representing `AuthProvider`'s name or type.
    init?(rawValue: String) {
        switch rawValue {
        case L10n.Auth.googleSignIn:
            self = .google
        case L10n.Auth.facebookSignIn:
            self = .facebook
        case L10n.Auth.emailPasswordSignIn:
            self = .emailPassword
        case L10n.Auth.anonymousSignIn:
            self = .anonymous
        case L10n.Auth.signUp:
            self = .registration
        default: return nil
        }
    }
}

// MARK: DataSourceProvidable

extension AuthProvider: DataSourceProvidable {
    private static var providers: [AuthProvider] {
        [.google, .facebook]
    }
    
    private static var firebaseProviders: [AuthProvider] {
        [.registration, .emailPassword]
    }
    
    static var providerSection: AuthSection {
        let providers = self.providers.map { AuthItem(title: $0.title, imageName: $0.name) }
        let header = L10n.Auth.authProvidersTitle
        return AuthSection(headerDescription: header, items: providers)
    }
    
    static var firebaseSection: AuthSection {
        var items = [AuthItem]()
        for provider in firebaseProviders {
            var item = AuthItem(title: provider.title, imageName: provider.name)
            item.hasNestedContent = true
            let image = item.image?.resizeImage(to: 32, aspectRatio: .current, with: .clear)
            item.image = image
            items.append(item)
        }
        
        let header = L10n.Auth.firebaseSectionHeader
        return AuthSection(headerDescription: header, items: items)
    }
    
    static var anonymousSection: AuthSection {
        let provider = AuthProvider.anonymous
        let item = AuthItem(title: provider.title, imageName: provider.name)
        let footer = L10n.Auth.authDescription
        return AuthSection(footerDescription: footer, items: [item])
    }
    
    static var sections: [AuthSection] {
        [firebaseSection, providerSection, anonymousSection]
    }
    
    static var authLinkSections: [AuthSection] {
        let allItems = AuthProvider.sections.flatMap { $0.items }
        let header = "Manage linking between providers"
        let footer =
            "Select an unchecked row to link the currently signed in user to that auth provider. To unlink the user from a linked provider, select its corresponding row marked with a checkmark."
        return [Section(headerDescription: header, footerDescription: footer, items: allItems)]
    }
    
    var sections: [AuthSection] { AuthProvider.sections }
}
