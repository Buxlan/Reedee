// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Actions {
    /// Ask a question
    internal static let askUs = L10n.tr("Localizable", "Actions.askUs")
    /// Contacts
    internal static let contacts = L10n.tr("Localizable", "Actions.contacts")
    /// Photos
    internal static let photoGallery = L10n.tr("Localizable", "Actions.photoGallery")
    /// Show on map
    internal static let showOnMap = L10n.tr("Localizable", "Actions.showOnMap")
    /// Training schedule
    internal static let showTrainingSchedule = L10n.tr("Localizable", "Actions.showTrainingSchedule")
    /// Join us
    internal static let signUpToClub = L10n.tr("Localizable", "Actions.signUpToClub")
  }

  internal enum App {
    /// Place
    internal static let name = L10n.tr("Localizable", "App.name")
  }

  internal enum Auth {
    /// Begin without registration
    internal static let anonymousSignIn = L10n.tr("Localizable", "Auth.anonymousSignIn")
    /// Sign in with Apple
    internal static let appleSignIn = L10n.tr("Localizable", "Auth.appleSignIn")
    /// Choose a login flow from one of the identity providers above.
    internal static let authDescription = L10n.tr("Localizable", "Auth.authDescription")
    /// Select an unchecked row to link the currently signed in user to that auth provider. To unlink the user from a linked provider, select its corresponding row marked with a checkmark.
    internal static let authLinkFooter = L10n.tr("Localizable", "Auth.authLinkFooter")
    /// Manage linking between providers
    internal static let authLinkHeader = L10n.tr("Localizable", "Auth.authLinkHeader")
    /// Log in with:
    internal static let authProvidersTitle = L10n.tr("Localizable", "Auth.authProvidersTitle")
    /// Email & Password login
    internal static let emailPasswordSignIn = L10n.tr("Localizable", "Auth.emailPasswordSignIn")
    /// Your e-mail
    internal static let emailPlaceholder = L10n.tr("Localizable", "Auth.emailPlaceholder")
    /// Login with Facebook
    internal static let facebookSignIn = L10n.tr("Localizable", "Auth.facebookSignIn")
    /// Places authorization
    internal static let firebaseSectionHeader = L10n.tr("Localizable", "Auth.firebaseSectionHeader")
    /// Forget password?
    internal static let forgotPassword = L10n.tr("Localizable", "Auth.forgotPassword")
    /// Sign in with Google
    internal static let googleSignIn = L10n.tr("Localizable", "Auth.googleSignIn")
    /// Your Password
    internal static let passwordPlaceholder = L10n.tr("Localizable", "Auth.passwordPlaceholder")
    /// Repeat your password
    internal static let repeatPasswordPlaceholder = L10n.tr("Localizable", "Auth.repeatPasswordPlaceholder")
    /// Sign up now
    internal static let signUp = L10n.tr("Localizable", "Auth.signUp")
    /// Joining us allow to share you own essay about variable places...
    internal static let title = L10n.tr("Localizable", "Auth.title")
    /// Your username
    internal static let usernamePlaceholder = L10n.tr("Localizable", "Auth.usernamePlaceholder")
    internal enum Buttons {
      /// Login
      internal static let login = L10n.tr("Localizable", "Auth.Buttons.Login")
      /// Haven't account?
      internal static let signUpSectionTitle = L10n.tr("Localizable", "Auth.Buttons.signUpSectionTitle")
    }
  }

  internal enum Common {
    /// at
    internal static let at = L10n.tr("Localizable", "Common.at")
    /// Back
    internal static let back = L10n.tr("Localizable", "Common.back")
    /// Close
    internal static let close = L10n.tr("Localizable", "Common.close")
    /// Confirm
    internal static let confirm = L10n.tr("Localizable", "Common.confirm")
    /// Date
    internal static let defaultDatePickerTitle = L10n.tr("Localizable", "Common.defaultDatePickerTitle")
    /// Export
    internal static let export = L10n.tr("Localizable", "Common.export")
    /// Next
    internal static let next = L10n.tr("Localizable", "Common.next")
    /// №
    internal static let numberSymbol = L10n.tr("Localizable", "Common.numberSymbol")
    /// number
    internal static let numberText = L10n.tr("Localizable", "Common.numberText")
    /// Готово
    internal static let ready = L10n.tr("Localizable", "Common.ready")
    /// Remain
    internal static let remain = L10n.tr("Localizable", "Common.remain")
  }

  internal enum Contacts {
    /// About club
    internal static let tabBarItemTitle = L10n.tr("Localizable", "Contacts.tabBarItemTitle")
    /// About club
    internal static let title = L10n.tr("Localizable", "Contacts.title")
    /// Call us now
    internal static let toCallUsTitle = L10n.tr("Localizable", "Contacts.toCallUsTitle")
  }

  internal enum Day {
    /// Friday
    internal static let friday = L10n.tr("Localizable", "Day.friday")
    /// Monday
    internal static let monday = L10n.tr("Localizable", "Day.monday")
    /// Saturday
    internal static let saturday = L10n.tr("Localizable", "Day.saturday")
    /// Sunday
    internal static let sunday = L10n.tr("Localizable", "Day.sunday")
    /// Thursday
    internal static let thursday = L10n.tr("Localizable", "Day.thursday")
    /// Tuesday
    internal static let tuesday = L10n.tr("Localizable", "Day.tuesday")
    /// Unknown
    internal static let unknown = L10n.tr("Localizable", "Day.unknown")
    /// Wednesday
    internal static let wednesday = L10n.tr("Localizable", "Day.wednesday")
  }

  internal enum Document {
    /// Add budjet descreases
    internal static let addDecreases = L10n.tr("Localizable", "Document.addDecreases")
    /// Add budjet increases
    internal static let addIncreases = L10n.tr("Localizable", "Document.addIncreases")
    /// Add mixed operations
    internal static let addVarious = L10n.tr("Localizable", "Document.addVarious")
    /// Comment
    internal static let comment = L10n.tr("Localizable", "Document.comment")
    /// Documents
    internal static let listTitle = L10n.tr("Localizable", "Document.listTitle")
    internal enum Decrease {
      /// Decrease
      internal static let title = L10n.tr("Localizable", "Document.Decrease.title")
    }
    internal enum Increase {
      /// Increase
      internal static let title = L10n.tr("Localizable", "Document.Increase.title")
    }
    internal enum Operation {
      /// Operation
      internal static let title = L10n.tr("Localizable", "Document.Operation.title")
    }
  }

  internal enum EditEventLabel {
    /// Away team
    internal static let awayTeamPlaceholder = L10n.tr("Localizable", "EditEventLabel.awayTeamPlaceholder")
    /// Bold text
    internal static let boldTextPlaceholder = L10n.tr("Localizable", "EditEventLabel.boldTextPlaceholder")
    /// Date
    internal static let datePlaceholder = L10n.tr("Localizable", "EditEventLabel.datePlaceholder")
    /// Delete
    internal static let deleteTypeTitle = L10n.tr("Localizable", "EditEventLabel.deleteTypeTitle")
    /// Type text here
    internal static let descriptionPlaceholder = L10n.tr("Localizable", "EditEventLabel.descriptionPlaceholder")
    /// Edit event
    internal static let editEventTitle = L10n.tr("Localizable", "EditEventLabel.editEventTitle")
    /// Edit
    internal static let editTypeTitle = L10n.tr("Localizable", "EditEventLabel.editTypeTitle")
    /// Change match
    internal static let existingMatchNavigationBarTitle = L10n.tr("Localizable", "EditEventLabel.existingMatchNavigationBarTitle")
    /// Home team
    internal static let homeTeamPlaceholder = L10n.tr("Localizable", "EditEventLabel.homeTeamPlaceholder")
    /// New event
    internal static let newEventTitle = L10n.tr("Localizable", "EditEventLabel.newEventTitle")
    /// Create match
    internal static let newMatchNavigationBarTitle = L10n.tr("Localizable", "EditEventLabel.newMatchNavigationBarTitle")
    /// Score
    internal static let scorePlaceholder = L10n.tr("Localizable", "EditEventLabel.scorePlaceholder")
    /// Select edit type
    internal static let selectEditTypeTitle = L10n.tr("Localizable", "EditEventLabel.selectEditTypeTitle")
    /// Type title here
    internal static let titlePlaceholder = L10n.tr("Localizable", "EditEventLabel.titlePlaceholder")
    /// Realy want to delete?
    internal static let wantDelete = L10n.tr("Localizable", "EditEventLabel.wantDelete")
  }

  internal enum EventDetail {
    /// Event
    internal static let title = L10n.tr("Localizable", "EventDetail.title")
  }

  internal enum Events {
    /// Editing event
    internal static let addEventTitle = L10n.tr("Localizable", "Events.addEventTitle")
    /// Append new event
    internal static let appendNew = L10n.tr("Localizable", "Events.appendNew")
    /// More
    internal static let defaultActionTitle = L10n.tr("Localizable", "Events.defaultActionTitle")
    /// Other
    internal static let inputBoldTextTitle = L10n.tr("Localizable", "Events.inputBoldTextTitle")
    /// Date
    internal static let inputDateTitle = L10n.tr("Localizable", "Events.inputDateTitle")
    /// Text
    internal static let inputTextTitle = L10n.tr("Localizable", "Events.inputTextTitle")
    /// Title
    internal static let inputTitle = L10n.tr("Localizable", "Events.inputTitle")
    /// Save
    internal static let save = L10n.tr("Localizable", "Events.Save")
    /// News
    internal static let selectNewEventTitle = L10n.tr("Localizable", "Events.selectNewEventTitle")
    /// Match result
    internal static let selectNewMatchResult = L10n.tr("Localizable", "Events.selectNewMatchResult")
    /// Select type
    internal static let selectTypeTitle = L10n.tr("Localizable", "Events.selectTypeTitle")
    /// Events
    internal static let tabBarItemTitle = L10n.tr("Localizable", "Events.tabBarItemTitle")
    /// Events
    internal static let title = L10n.tr("Localizable", "Events.title")
    /// Ad
    internal static let typeAd = L10n.tr("Localizable", "Events.typeAd")
    /// Soon
    internal static let typeComingSoon = L10n.tr("Localizable", "Events.typeComingSoon")
    /// News
    internal static let typeEvent = L10n.tr("Localizable", "Events.typeEvent")
    /// Match
    internal static let typeMatch = L10n.tr("Localizable", "Events.typeMatch")
    /// Other
    internal static let typeOther = L10n.tr("Localizable", "Events.typeOther")
    /// Photo
    internal static let typePhoto = L10n.tr("Localizable", "Events.typePhoto")
  }

  internal enum FavoritePlaces {
    /// Favorite
    internal static let title = L10n.tr("Localizable", "FavoritePlaces.title")
  }

  internal enum Finance {
    /// Balance
    internal static let balance = L10n.tr("Localizable", "Finance.balance")
    /// Balance for export
    internal static let exportBalance = L10n.tr("Localizable", "Finance.exportBalance")
    internal enum Reports {
      /// Reports
      internal static let title = L10n.tr("Localizable", "Finance.Reports.title")
    }
    internal enum Transactions {
      /// Activate
      internal static let activate = L10n.tr("Localizable", "Finance.Transactions.activate")
      /// Add costs
      internal static let addCosts = L10n.tr("Localizable", "Finance.Transactions.addCosts")
      /// Add income
      internal static let addIncome = L10n.tr("Localizable", "Finance.Transactions.addIncome")
      /// Amount (not requiered)
      internal static let amountPlaceholer = L10n.tr("Localizable", "Finance.Transactions.amountPlaceholer")
      /// Comment (not requiered)
      internal static let commentPlaceholder = L10n.tr("Localizable", "Finance.Transactions.commentPlaceholder")
      /// Costs
      internal static let costs = L10n.tr("Localizable", "Finance.Transactions.costs")
      /// Deactivate
      internal static let deactivate = L10n.tr("Localizable", "Finance.Transactions.deactivate")
      /// Income
      internal static let income = L10n.tr("Localizable", "Finance.Transactions.income")
      /// Select action
      internal static let selectAction = L10n.tr("Localizable", "Finance.Transactions.selectAction")
      /// Summary
      internal static let summary = L10n.tr("Localizable", "Finance.Transactions.summary")
      /// Switch activity
      internal static let switchActivity = L10n.tr("Localizable", "Finance.Transactions.switchActivity")
      /// Transactions
      internal static let title = L10n.tr("Localizable", "Finance.Transactions.title")
    }
  }

  internal enum HockeyPlayer {
    /// Defender
    internal static let positionDefender = L10n.tr("Localizable", "HockeyPlayer.positionDefender")
    /// Defenders
    internal static let positionDefenderPlural = L10n.tr("Localizable", "HockeyPlayer.positionDefenderPlural")
    /// Goalkeeper
    internal static let positionGoalkeeper = L10n.tr("Localizable", "HockeyPlayer.positionGoalkeeper")
    /// Goalkeepers
    internal static let positionGoalkeeperPlural = L10n.tr("Localizable", "HockeyPlayer.positionGoalkeeperPlural")
    /// Forwarder
    internal static let positionStriker = L10n.tr("Localizable", "HockeyPlayer.positionStriker")
    /// Forwarders
    internal static let positionStrikerPlural = L10n.tr("Localizable", "HockeyPlayer.positionStrikerPlural")
  }

  internal enum MatchResult {
    /// Append new match result
    internal static let appendNew = L10n.tr("Localizable", "MatchResult.appendNew")
    /// Match
    internal static let navigationBarTitle = L10n.tr("Localizable", "MatchResult.navigationBarTitle")
  }

  internal enum MatchStatus {
    /// Finished
    internal static let finishedTitle = L10n.tr("Localizable", "MatchStatus.finishedTitle")
    /// In progress
    internal static let inProgressTitle = L10n.tr("Localizable", "MatchStatus.inProgressTitle")
    /// Planned
    internal static let plannedTitle = L10n.tr("Localizable", "MatchStatus.plannedTitle")
  }

  internal enum NearestPlaces {
    /// Nearby
    internal static let title = L10n.tr("Localizable", "NearestPlaces.title")
  }

  internal enum News {
    /// Main
    internal static let navigationBarTitle = L10n.tr("Localizable", "News.navigationBarTitle")
    /// News
    internal static let tabBarTitle = L10n.tr("Localizable", "News.tabBarTitle")
    /// Coming events
    internal static let tableViewComingSectionTitle = L10n.tr("Localizable", "News.tableViewComingSectionTitle")
    /// News
    internal static let tableViewNewsSectionTitle = L10n.tr("Localizable", "News.tableViewNewsSectionTitle")
    /// 
    internal static let tableViewPinnedSectionTitle = L10n.tr("Localizable", "News.tableViewPinnedSectionTitle")
  }

  internal enum Onboarding {
    /// We're glad to see you at Place. Here are we're sharing thoughts, dreams and imaginations about favorite Saint-petersburg places
    internal static let onboardngText1 = L10n.tr("Localizable", "Onboarding.onboardngText1")
    /// Share your imaginations! Listen and share audio, text and pictures with other
    internal static let onboardngText2 = L10n.tr("Localizable", "Onboarding.onboardngText2")
    /// Joining us allow to share you own essay about variable places...
    internal static let onboardngText3 = L10n.tr("Localizable", "Onboarding.onboardngText3")
    /// Welcome
    internal static let onboardngTitle1 = L10n.tr("Localizable", "Onboarding.onboardngTitle1")
    /// Look, learn and share
    internal static let onboardngTitle2 = L10n.tr("Localizable", "Onboarding.onboardngTitle2")
    /// Join us
    internal static let onboardngTitle3 = L10n.tr("Localizable", "Onboarding.onboardngTitle3")
    internal enum Buttons {
      /// Next (1 from 3)
      internal static let futher1 = L10n.tr("Localizable", "Onboarding.Buttons.futher1")
      /// Next (2 from 3)
      internal static let futher2 = L10n.tr("Localizable", "Onboarding.Buttons.futher2")
      /// Maybe later
      internal static let later = L10n.tr("Localizable", "Onboarding.Buttons.Later")
      /// Skip
      internal static let skip = L10n.tr("Localizable", "Onboarding.Buttons.Skip")
    }
  }

  internal enum Other {
    /// Are you sure to discard changes?
    internal static let areYouSureToDiscardChanges = L10n.tr("Localizable", "Other.areYouSureToDiscardChanges")
    /// Back
    internal static let back = L10n.tr("Localizable", "Other.back")
    /// Report a bug
    internal static let bugReport = L10n.tr("Localizable", "Other.bugReport")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "Other.cancel")
    /// No, I'd like to continue
    internal static let continueEditing = L10n.tr("Localizable", "Other.continueEditing")
    /// Delete
    internal static let delete = L10n.tr("Localizable", "Other.delete")
    /// Discard changes
    internal static let discardChanges = L10n.tr("Localizable", "Other.discardChanges")
    /// Done
    internal static let done = L10n.tr("Localizable", "Other.done")
    /// Edit
    internal static let edit = L10n.tr("Localizable", "Other.edit")
    /// Report
    internal static let report = L10n.tr("Localizable", "Other.report")
    /// Save
    internal static let save = L10n.tr("Localizable", "Other.save")
    /// Select action
    internal static let selectAction = L10n.tr("Localizable", "Other.selectAction")
  }

  internal enum PlacesList {
    /// Top
    internal static let title = L10n.tr("Localizable", "PlacesList.title")
    /// Go to reviews
    internal static let toReviews = L10n.tr("Localizable", "PlacesList.toReviews")
  }

  internal enum Profile {
    /// Authentication
    internal static let authSectionTitle = L10n.tr("Localizable", "Profile.authSectionTitle")
    /// Change password
    internal static let changePassword = L10n.tr("Localizable", "Profile.changePassword")
    /// Change user photo
    internal static let changeUserPhoto = L10n.tr("Localizable", "Profile.changeUserPhoto")
    /// Communication
    internal static let communication = L10n.tr("Localizable", "Profile.communication")
    /// Edit profile
    internal static let edit = L10n.tr("Localizable", "Profile.edit")
    /// Log out
    internal static let logout = L10n.tr("Localizable", "Profile.logout")
    /// Author panel
    internal static let operationsSectionTitle = L10n.tr("Localizable", "Profile.operationsSectionTitle")
    /// Privacy
    internal static let privacy = L10n.tr("Localizable", "Profile.privacy")
    /// Sign in
    internal static let signIn = L10n.tr("Localizable", "Profile.signIn")
    /// Sign up
    internal static let signUp = L10n.tr("Localizable", "Profile.signUp")
    /// Profile
    internal static let title = L10n.tr("Localizable", "Profile.title")
  }

  internal enum Settings {
    /// Allow e-mails
    internal static let allowEmails = L10n.tr("Localizable", "Settings.allowEmails")
    /// Allow notifications
    internal static let allowNotifications = L10n.tr("Localizable", "Settings.allowNotifications")
    /// Crash reports
    internal static let crashReposts = L10n.tr("Localizable", "Settings.crashReposts")
    /// Email
    internal static let emails = L10n.tr("Localizable", "Settings.emails")
    /// Profile
    internal static let navigationBarTitle = L10n.tr("Localizable", "Settings.navigationBarTitle")
    /// Notifications
    internal static let notifications = L10n.tr("Localizable", "Settings.notifications")
    internal enum SectionTitles {
      /// Communication
      internal static let communication = L10n.tr("Localizable", "Settings.SectionTitles.communication")
      /// General
      internal static let general = L10n.tr("Localizable", "Settings.SectionTitles.general")
      /// Privacy
      internal static let privacy = L10n.tr("Localizable", "Settings.SectionTitles.privacy")
    }
  }

  internal enum Shop {
    /// Shop
    internal static let tabBarItemTitle = L10n.tr("Localizable", "Shop.tabBarItemTitle")
    /// Shop
    internal static let title = L10n.tr("Localizable", "Shop.title")
  }

  internal enum SignIn {
    /// Login
    internal static let title = L10n.tr("Localizable", "SignIn.title")
  }

  internal enum SignUp {
    /// Sign up
    internal static let title = L10n.tr("Localizable", "SignUp.title")
  }

  internal enum Squads {
    /// Coach: 
    internal static let coachTitle = L10n.tr("Localizable", "Squads.coachTitle")
    /// Squads
    internal static let listTitle = L10n.tr("Localizable", "Squads.listTitle")
    /// Squads: 
    internal static let sectionTitle = L10n.tr("Localizable", "Squads.sectionTitle")
    /// Count of squads: 
    internal static let squadsCountTitle = L10n.tr("Localizable", "Squads.squadsCountTitle")
    /// Squads
    internal static let tabBarItemTitle = L10n.tr("Localizable", "Squads.tabBarItemTitle")
    /// Trainings
    internal static let trainingTitle = L10n.tr("Localizable", "Squads.trainingTitle")
  }

  internal enum Staff {
    /// Coach
    internal static let coach = L10n.tr("Localizable", "Staff.coach")
    /// Coach
    internal static let coachDescription = L10n.tr("Localizable", "Staff.coachDescription")
    /// Player info
    internal static let player = L10n.tr("Localizable", "Staff.player")
    /// Description
    internal static let playerDescription = L10n.tr("Localizable", "Staff.playerDescription")
  }

  internal enum TabBar {
    /// Finance
    internal static let finance = L10n.tr("Localizable", "TabBar.finance")
  }

  internal enum Team {
    /// About club
    internal static let aboutClubTitle = L10n.tr("Localizable", "Team.aboutClubTitle")
    /// Address: 
    internal static let addressTitle = L10n.tr("Localizable", "Team.addressTitle")
    /// E-mail: 
    internal static let emailTitle = L10n.tr("Localizable", "Team.emailTitle")
    /// Teams
    internal static let listTitle = L10n.tr("Localizable", "Team.listTitle")
    /// on the map
    internal static let onTheMapTitle = L10n.tr("Localizable", "Team.onTheMapTitle")
    /// Phone: 
    internal static let phoneTitle = L10n.tr("Localizable", "Team.phoneTitle")
  }

  internal enum TrainingType {
    /// Gym
    internal static let gym = L10n.tr("Localizable", "TrainingType.gym")
    /// Ice
    internal static let ice = L10n.tr("Localizable", "TrainingType.ice")
    /// Unknown
    internal static let unknown = L10n.tr("Localizable", "TrainingType.unknown")
  }

  internal enum User {
    /// Unregistered user
    internal static let displayUnregistered = L10n.tr("Localizable", "User.displayUnregistered")
    /// Unregistered
    internal static let unregistered = L10n.tr("Localizable", "User.unregistered")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
