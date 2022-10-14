// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Loading
  internal static let loading = L10n.tr("Localizable", "Loading", fallback: "Loading")
  internal enum Actions {
    /// Ask a question
    internal static let askUs = L10n.tr("Localizable", "Actions.askUs", fallback: "Ask a question")
    /// Contacts
    internal static let contacts = L10n.tr("Localizable", "Actions.contacts", fallback: "Contacts")
    /// Photos
    internal static let photoGallery = L10n.tr("Localizable", "Actions.photoGallery", fallback: "Photos")
    /// Show on map
    internal static let showOnMap = L10n.tr("Localizable", "Actions.showOnMap", fallback: "Show on map")
    /// Training schedule
    internal static let showTrainingSchedule = L10n.tr("Localizable", "Actions.showTrainingSchedule", fallback: "Training schedule")
    /// Actions
    internal static let signUpToClub = L10n.tr("Localizable", "Actions.signUpToClub", fallback: "Join us")
  }
  internal enum App {
    /// Our money
    internal static let name = L10n.tr("Localizable", "App.name", fallback: "Our money")
  }
  internal enum Auth {
    /// Begin without registration
    internal static let anonymousSignIn = L10n.tr("Localizable", "Auth.anonymousSignIn", fallback: "Begin without registration")
    /// Sign in with Apple
    internal static let appleSignIn = L10n.tr("Localizable", "Auth.appleSignIn", fallback: "Sign in with Apple")
    /// Choose a login flow from one of the identity providers above.
    internal static let authDescription = L10n.tr("Localizable", "Auth.authDescription", fallback: "Choose a login flow from one of the identity providers above.")
    /// Select an unchecked row to link the currently signed in user to that auth provider. To unlink the user from a linked provider, select its corresponding row marked with a checkmark.
    internal static let authLinkFooter = L10n.tr("Localizable", "Auth.authLinkFooter", fallback: "Select an unchecked row to link the currently signed in user to that auth provider. To unlink the user from a linked provider, select its corresponding row marked with a checkmark.")
    /// Manage linking between providers
    internal static let authLinkHeader = L10n.tr("Localizable", "Auth.authLinkHeader", fallback: "Manage linking between providers")
    /// Log in with:
    internal static let authProvidersTitle = L10n.tr("Localizable", "Auth.authProvidersTitle", fallback: "Log in with:")
    /// Email & Password login
    internal static let emailPasswordSignIn = L10n.tr("Localizable", "Auth.emailPasswordSignIn", fallback: "Email & Password login")
    /// Your e-mail
    internal static let emailPlaceholder = L10n.tr("Localizable", "Auth.emailPlaceholder", fallback: "Your e-mail")
    /// Login with Facebook
    internal static let facebookSignIn = L10n.tr("Localizable", "Auth.facebookSignIn", fallback: "Login with Facebook")
    /// Places authorization
    internal static let firebaseSectionHeader = L10n.tr("Localizable", "Auth.firebaseSectionHeader", fallback: "Places authorization")
    /// Forget password?
    internal static let forgotPassword = L10n.tr("Localizable", "Auth.forgotPassword", fallback: "Forget password?")
    /// Sign in with Google
    internal static let googleSignIn = L10n.tr("Localizable", "Auth.googleSignIn", fallback: "Sign in with Google")
    /// Your Password
    internal static let passwordPlaceholder = L10n.tr("Localizable", "Auth.passwordPlaceholder", fallback: "Your Password")
    /// Repeat your password
    internal static let repeatPasswordPlaceholder = L10n.tr("Localizable", "Auth.repeatPasswordPlaceholder", fallback: "Repeat your password")
    /// Sign up now
    internal static let signUp = L10n.tr("Localizable", "Auth.signUp", fallback: "Sign up now")
    /// Joining us allow to share you own essay about variable places...
    internal static let title = L10n.tr("Localizable", "Auth.title", fallback: "Joining us allow to share you own essay about variable places...")
    /// Your username
    internal static let usernamePlaceholder = L10n.tr("Localizable", "Auth.usernamePlaceholder", fallback: "Your username")
    internal enum Buttons {
      /// Login
      internal static let login = L10n.tr("Localizable", "Auth.Buttons.Login", fallback: "Login")
      /// Haven't account?
      internal static let signUpSectionTitle = L10n.tr("Localizable", "Auth.Buttons.signUpSectionTitle", fallback: "Haven't account?")
    }
  }
  internal enum Common {
    /// at
    internal static let at = L10n.tr("Localizable", "Common.at", fallback: "at")
    /// Back
    internal static let back = L10n.tr("Localizable", "Common.back", fallback: "Back")
    /// Close
    internal static let close = L10n.tr("Localizable", "Common.close", fallback: "Close")
    /// Confirm
    internal static let confirm = L10n.tr("Localizable", "Common.confirm", fallback: "Confirm")
    /// Select date
    internal static let defaultDatePickerTitle = L10n.tr("Localizable", "Common.defaultDatePickerTitle", fallback: "Select date")
    /// Export
    internal static let export = L10n.tr("Localizable", "Common.export", fallback: "Export")
    /// Next
    internal static let next = L10n.tr("Localizable", "Common.next", fallback: "Next")
    /// №
    internal static let numberSymbol = L10n.tr("Localizable", "Common.numberSymbol", fallback: "№")
    /// number
    internal static let numberText = L10n.tr("Localizable", "Common.numberText", fallback: "number")
    /// Готово
    internal static let ready = L10n.tr("Localizable", "Common.ready", fallback: "Готово")
    /// Remain
    internal static let remain = L10n.tr("Localizable", "Common.remain", fallback: "Remain")
  }
  internal enum Contacts {
    /// Contacts
    internal static let tabBarItemTitle = L10n.tr("Localizable", "Contacts.tabBarItemTitle", fallback: "About club")
    /// About club
    internal static let title = L10n.tr("Localizable", "Contacts.title", fallback: "About club")
    /// Call us now
    internal static let toCallUsTitle = L10n.tr("Localizable", "Contacts.toCallUsTitle", fallback: "Call us now")
  }
  internal enum Day {
    /// Friday
    internal static let friday = L10n.tr("Localizable", "Day.friday", fallback: "Friday")
    /// Monday
    internal static let monday = L10n.tr("Localizable", "Day.monday", fallback: "Monday")
    /// Saturday
    internal static let saturday = L10n.tr("Localizable", "Day.saturday", fallback: "Saturday")
    /// Sunday
    internal static let sunday = L10n.tr("Localizable", "Day.sunday", fallback: "Sunday")
    /// Thursday
    internal static let thursday = L10n.tr("Localizable", "Day.thursday", fallback: "Thursday")
    /// Tuesday
    internal static let tuesday = L10n.tr("Localizable", "Day.tuesday", fallback: "Tuesday")
    /// Unknown
    internal static let unknown = L10n.tr("Localizable", "Day.unknown", fallback: "Unknown")
    /// Wednesday
    internal static let wednesday = L10n.tr("Localizable", "Day.wednesday", fallback: "Wednesday")
  }
  internal enum Document {
    /// Add budjet descreases
    internal static let addDecreases = L10n.tr("Localizable", "Document.addDecreases", fallback: "Add budjet descreases")
    /// Add budjet increases
    internal static let addIncreases = L10n.tr("Localizable", "Document.addIncreases", fallback: "Add budjet increases")
    /// Add mixed operations
    internal static let addVarious = L10n.tr("Localizable", "Document.addVarious", fallback: "Add mixed operations")
    /// Comment
    internal static let comment = L10n.tr("Localizable", "Document.comment", fallback: "Comment")
    /// Documents
    internal static let listTitle = L10n.tr("Localizable", "Document.listTitle", fallback: "Documents")
    internal enum Decrease {
      /// Decrease
      internal static let title = L10n.tr("Localizable", "Document.Decrease.title", fallback: "Decrease")
    }
    internal enum Increase {
      /// Increase
      internal static let title = L10n.tr("Localizable", "Document.Increase.title", fallback: "Increase")
    }
    internal enum Operation {
      /// Type comment
      internal static let commentPlaceholder = L10n.tr("Localizable", "Document.Operation.commentPlaceholder", fallback: "Type comment")
      /// Edit operation doc
      internal static let editTitle = L10n.tr("Localizable", "Document.Operation.editTitle", fallback: "Edit operation doc")
      /// New operation doc
      internal static let newTitle = L10n.tr("Localizable", "Document.Operation.newTitle", fallback: "New operation doc")
      /// Type number
      internal static let numberPlaceholder = L10n.tr("Localizable", "Document.Operation.numberPlaceholder", fallback: "Type number")
      /// Operation
      internal static let title = L10n.tr("Localizable", "Document.Operation.title", fallback: "Operation")
    }
    internal enum Transaction {
      /// Type amount
      internal static let amountPlaceholder = L10n.tr("Localizable", "Document.Transaction.amountPlaceholder", fallback: "Type amount")
      /// Type comment
      internal static let commentPlaceholder = L10n.tr("Localizable", "Document.Transaction.commentPlaceholder", fallback: "Type comment")
      /// Type name
      internal static let namePlaceholder = L10n.tr("Localizable", "Document.Transaction.namePlaceholder", fallback: "Type name")
      /// Type number
      internal static let numberPlaceholder = L10n.tr("Localizable", "Document.Transaction.numberPlaceholder", fallback: "Type number")
    }
  }
  internal enum EditEventLabel {
    /// Away team
    internal static let awayTeamPlaceholder = L10n.tr("Localizable", "EditEventLabel.awayTeamPlaceholder", fallback: "Away team")
    /// Bold text
    internal static let boldTextPlaceholder = L10n.tr("Localizable", "EditEventLabel.boldTextPlaceholder", fallback: "Bold text")
    /// Date
    internal static let datePlaceholder = L10n.tr("Localizable", "EditEventLabel.datePlaceholder", fallback: "Date")
    /// Delete
    internal static let deleteTypeTitle = L10n.tr("Localizable", "EditEventLabel.deleteTypeTitle", fallback: "Delete")
    /// Type text here
    internal static let descriptionPlaceholder = L10n.tr("Localizable", "EditEventLabel.descriptionPlaceholder", fallback: "Type text here")
    /// Edit event
    internal static let editEventTitle = L10n.tr("Localizable", "EditEventLabel.editEventTitle", fallback: "Edit event")
    /// Edit
    internal static let editTypeTitle = L10n.tr("Localizable", "EditEventLabel.editTypeTitle", fallback: "Edit")
    /// Change match
    internal static let existingMatchNavigationBarTitle = L10n.tr("Localizable", "EditEventLabel.existingMatchNavigationBarTitle", fallback: "Change match")
    /// Home team
    internal static let homeTeamPlaceholder = L10n.tr("Localizable", "EditEventLabel.homeTeamPlaceholder", fallback: "Home team")
    /// Edit event labels
    internal static let newEventTitle = L10n.tr("Localizable", "EditEventLabel.newEventTitle", fallback: "New event")
    /// Create match
    internal static let newMatchNavigationBarTitle = L10n.tr("Localizable", "EditEventLabel.newMatchNavigationBarTitle", fallback: "Create match")
    /// Score
    internal static let scorePlaceholder = L10n.tr("Localizable", "EditEventLabel.scorePlaceholder", fallback: "Score")
    /// Select edit type
    internal static let selectEditTypeTitle = L10n.tr("Localizable", "EditEventLabel.selectEditTypeTitle", fallback: "Select edit type")
    /// Type title here
    internal static let titlePlaceholder = L10n.tr("Localizable", "EditEventLabel.titlePlaceholder", fallback: "Type title here")
    /// Realy want to delete?
    internal static let wantDelete = L10n.tr("Localizable", "EditEventLabel.wantDelete", fallback: "Realy want to delete?")
  }
  internal enum Error {
    /// Network is unavailable
    internal static let networkUnavailable = L10n.tr("Localizable", "Error.networkUnavailable", fallback: "Network is unavailable")
  }
  internal enum EventDetail {
    /// Event
    internal static let title = L10n.tr("Localizable", "EventDetail.title", fallback: "Event")
  }
  internal enum Events {
    /// Editing event
    internal static let addEventTitle = L10n.tr("Localizable", "Events.addEventTitle", fallback: "Editing event")
    /// Append new event
    internal static let appendNew = L10n.tr("Localizable", "Events.appendNew", fallback: "Append new event")
    /// More
    internal static let defaultActionTitle = L10n.tr("Localizable", "Events.defaultActionTitle", fallback: "More")
    /// Other
    internal static let inputBoldTextTitle = L10n.tr("Localizable", "Events.inputBoldTextTitle", fallback: "Other")
    /// Date
    internal static let inputDateTitle = L10n.tr("Localizable", "Events.inputDateTitle", fallback: "Date")
    /// Text
    internal static let inputTextTitle = L10n.tr("Localizable", "Events.inputTextTitle", fallback: "Text")
    /// Title
    internal static let inputTitle = L10n.tr("Localizable", "Events.inputTitle", fallback: "Title")
    /// Save
    internal static let save = L10n.tr("Localizable", "Events.Save", fallback: "Save")
    /// News
    internal static let selectNewEventTitle = L10n.tr("Localizable", "Events.selectNewEventTitle", fallback: "News")
    /// Match result
    internal static let selectNewMatchResult = L10n.tr("Localizable", "Events.selectNewMatchResult", fallback: "Match result")
    /// Events
    internal static let selectTypeTitle = L10n.tr("Localizable", "Events.selectTypeTitle", fallback: "Select type")
    /// Events
    internal static let tabBarItemTitle = L10n.tr("Localizable", "Events.tabBarItemTitle", fallback: "Events")
    /// Events
    internal static let title = L10n.tr("Localizable", "Events.title", fallback: "Events")
    /// Ad
    internal static let typeAd = L10n.tr("Localizable", "Events.typeAd", fallback: "Ad")
    /// Soon
    internal static let typeComingSoon = L10n.tr("Localizable", "Events.typeComingSoon", fallback: "Soon")
    /// News
    internal static let typeEvent = L10n.tr("Localizable", "Events.typeEvent", fallback: "News")
    /// Match
    internal static let typeMatch = L10n.tr("Localizable", "Events.typeMatch", fallback: "Match")
    /// Other
    internal static let typeOther = L10n.tr("Localizable", "Events.typeOther", fallback: "Other")
    /// Photo
    internal static let typePhoto = L10n.tr("Localizable", "Events.typePhoto", fallback: "Photo")
  }
  internal enum FavoritePlaces {
    /// Favorite places
    internal static let title = L10n.tr("Localizable", "FavoritePlaces.title", fallback: "Favorite")
  }
  internal enum Finance {
    /// Balance
    internal static let balance = L10n.tr("Localizable", "Finance.balance", fallback: "Balance")
    /// rub.
    internal static let currency = L10n.tr("Localizable", "Finance.currency", fallback: "rub.")
    /// Balance for export
    internal static let exportBalance = L10n.tr("Localizable", "Finance.exportBalance", fallback: "Balance for export")
    /// Type filter
    internal static let searchPlaceholder = L10n.tr("Localizable", "Finance.searchPlaceholder", fallback: "Type filter")
    internal enum Reports {
      /// Reports
      internal static let title = L10n.tr("Localizable", "Finance.Reports.title", fallback: "Reports")
    }
    internal enum Transactions {
      /// Activate
      internal static let activate = L10n.tr("Localizable", "Finance.Transactions.activate", fallback: "Activate")
      /// Add costs
      internal static let addCosts = L10n.tr("Localizable", "Finance.Transactions.addCosts", fallback: "Add costs")
      /// Add income
      internal static let addIncome = L10n.tr("Localizable", "Finance.Transactions.addIncome", fallback: "Add income")
      /// Amount (not requiered)
      internal static let amountPlaceholer = L10n.tr("Localizable", "Finance.Transactions.amountPlaceholer", fallback: "Amount (not requiered)")
      /// Comment (not requiered)
      internal static let commentPlaceholder = L10n.tr("Localizable", "Finance.Transactions.commentPlaceholder", fallback: "Comment (not requiered)")
      /// Costs
      internal static let costs = L10n.tr("Localizable", "Finance.Transactions.costs", fallback: "Costs")
      /// Deactivate
      internal static let deactivate = L10n.tr("Localizable", "Finance.Transactions.deactivate", fallback: "Deactivate")
      /// Decreases
      internal static let decreases = L10n.tr("Localizable", "Finance.Transactions.decreases", fallback: "Decreases")
      /// Income
      internal static let income = L10n.tr("Localizable", "Finance.Transactions.income", fallback: "Income")
      /// Increases
      internal static let increases = L10n.tr("Localizable", "Finance.Transactions.increases", fallback: "Increases")
      /// Select action
      internal static let selectAction = L10n.tr("Localizable", "Finance.Transactions.selectAction", fallback: "Select action")
      /// Summary
      internal static let summary = L10n.tr("Localizable", "Finance.Transactions.summary", fallback: "Summary")
      /// Switch activity
      internal static let switchActivity = L10n.tr("Localizable", "Finance.Transactions.switchActivity", fallback: "Switch activity")
      /// Transactions
      internal static let title = L10n.tr("Localizable", "Finance.Transactions.title", fallback: "Transactions")
    }
  }
  internal enum HockeyPlayer {
    /// Defender
    internal static let positionDefender = L10n.tr("Localizable", "HockeyPlayer.positionDefender", fallback: "Defender")
    /// Defenders
    internal static let positionDefenderPlural = L10n.tr("Localizable", "HockeyPlayer.positionDefenderPlural", fallback: "Defenders")
    /// Goalkeeper
    internal static let positionGoalkeeper = L10n.tr("Localizable", "HockeyPlayer.positionGoalkeeper", fallback: "Goalkeeper")
    /// Goalkeepers
    internal static let positionGoalkeeperPlural = L10n.tr("Localizable", "HockeyPlayer.positionGoalkeeperPlural", fallback: "Goalkeepers")
    /// Hockey players
    internal static let positionStriker = L10n.tr("Localizable", "HockeyPlayer.positionStriker", fallback: "Forwarder")
    /// Forwarders
    internal static let positionStrikerPlural = L10n.tr("Localizable", "HockeyPlayer.positionStrikerPlural", fallback: "Forwarders")
  }
  internal enum MatchResult {
    /// Append new match result
    internal static let appendNew = L10n.tr("Localizable", "MatchResult.appendNew", fallback: "Append new match result")
    /// Match
    internal static let navigationBarTitle = L10n.tr("Localizable", "MatchResult.navigationBarTitle", fallback: "Match")
  }
  internal enum MatchStatus {
    /// Finished
    internal static let finishedTitle = L10n.tr("Localizable", "MatchStatus.finishedTitle", fallback: "Finished")
    /// In progress
    internal static let inProgressTitle = L10n.tr("Localizable", "MatchStatus.inProgressTitle", fallback: "In progress")
    /// Match status
    internal static let plannedTitle = L10n.tr("Localizable", "MatchStatus.plannedTitle", fallback: "Planned")
  }
  internal enum NearestPlaces {
    /// Nearest places
    internal static let title = L10n.tr("Localizable", "NearestPlaces.title", fallback: "Nearby")
  }
  internal enum News {
    /// Main
    internal static let navigationBarTitle = L10n.tr("Localizable", "News.navigationBarTitle", fallback: "Main")
    /// News
    internal static let tabBarTitle = L10n.tr("Localizable", "News.tabBarTitle", fallback: "News")
    /// Coming events
    internal static let tableViewComingSectionTitle = L10n.tr("Localizable", "News.tableViewComingSectionTitle", fallback: "Coming events")
    /// News
    internal static let tableViewNewsSectionTitle = L10n.tr("Localizable", "News.tableViewNewsSectionTitle", fallback: "News")
    /// 
    internal static let tableViewPinnedSectionTitle = L10n.tr("Localizable", "News.tableViewPinnedSectionTitle", fallback: "")
  }
  internal enum Onboarding {
    /// We're glad to see you at Place. Here are we're sharing thoughts, dreams and imaginations about favorite Saint-petersburg places
    internal static let onboardngText1 = L10n.tr("Localizable", "Onboarding.onboardngText1", fallback: "We're glad to see you at Place. Here are we're sharing thoughts, dreams and imaginations about favorite Saint-petersburg places")
    /// Share your imaginations! Listen and share audio, text and pictures with other
    internal static let onboardngText2 = L10n.tr("Localizable", "Onboarding.onboardngText2", fallback: "Share your imaginations! Listen and share audio, text and pictures with other")
    /// Joining us allow to share you own essay about variable places...
    internal static let onboardngText3 = L10n.tr("Localizable", "Onboarding.onboardngText3", fallback: "Joining us allow to share you own essay about variable places...")
    /// Welcome
    internal static let onboardngTitle1 = L10n.tr("Localizable", "Onboarding.onboardngTitle1", fallback: "Welcome")
    /// Look, learn and share
    internal static let onboardngTitle2 = L10n.tr("Localizable", "Onboarding.onboardngTitle2", fallback: "Look, learn and share")
    /// Join us
    internal static let onboardngTitle3 = L10n.tr("Localizable", "Onboarding.onboardngTitle3", fallback: "Join us")
    internal enum Buttons {
      /// Continue
      internal static let `continue` = L10n.tr("Localizable", "Onboarding.Buttons.Continue", fallback: "Continue")
      /// Next (1 from 3)
      internal static let futher1 = L10n.tr("Localizable", "Onboarding.Buttons.futher1", fallback: "Next (1 from 3)")
      /// Next (2 from 3)
      internal static let futher2 = L10n.tr("Localizable", "Onboarding.Buttons.futher2", fallback: "Next (2 from 3)")
      /// Maybe later
      internal static let later = L10n.tr("Localizable", "Onboarding.Buttons.Later", fallback: "Maybe later")
      /// Skip
      internal static let skip = L10n.tr("Localizable", "Onboarding.Buttons.Skip", fallback: "Skip")
    }
  }
  internal enum Other {
    /// Are you sure to discard changes?
    internal static let areYouSureToDiscardChanges = L10n.tr("Localizable", "Other.areYouSureToDiscardChanges", fallback: "Are you sure to discard changes?")
    /// Back
    internal static let back = L10n.tr("Localizable", "Other.back", fallback: "Back")
    /// Report a bug
    internal static let bugReport = L10n.tr("Localizable", "Other.bugReport", fallback: "Report a bug")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "Other.cancel", fallback: "Cancel")
    /// No, I'd like to continue
    internal static let continueEditing = L10n.tr("Localizable", "Other.continueEditing", fallback: "No, I'd like to continue")
    /// Delete
    internal static let delete = L10n.tr("Localizable", "Other.delete", fallback: "Delete")
    /// Discard changes
    internal static let discardChanges = L10n.tr("Localizable", "Other.discardChanges", fallback: "Discard changes")
    /// Other
    internal static let done = L10n.tr("Localizable", "Other.done", fallback: "Done")
    /// Edit
    internal static let edit = L10n.tr("Localizable", "Other.edit", fallback: "Edit")
    /// Ok
    internal static let ok = L10n.tr("Localizable", "Other.ok", fallback: "Ok")
    /// Report
    internal static let report = L10n.tr("Localizable", "Other.report", fallback: "Report")
    /// Save
    internal static let save = L10n.tr("Localizable", "Other.save", fallback: "Save")
    /// Select action
    internal static let selectAction = L10n.tr("Localizable", "Other.selectAction", fallback: "Select action")
  }
  internal enum PlacesList {
    /// Place list
    internal static let title = L10n.tr("Localizable", "PlacesList.title", fallback: "Top")
    /// Go to reviews
    internal static let toReviews = L10n.tr("Localizable", "PlacesList.toReviews", fallback: "Go to reviews")
  }
  internal enum Profile {
    /// Authentication
    internal static let authSectionTitle = L10n.tr("Localizable", "Profile.authSectionTitle", fallback: "Authentication")
    /// Change password
    internal static let changePassword = L10n.tr("Localizable", "Profile.changePassword", fallback: "Change password")
    /// Change user photo
    internal static let changeUserPhoto = L10n.tr("Localizable", "Profile.changeUserPhoto", fallback: "Change user photo")
    /// Communication
    internal static let communication = L10n.tr("Localizable", "Profile.communication", fallback: "Communication")
    /// Edit profile
    internal static let edit = L10n.tr("Localizable", "Profile.edit", fallback: "Edit profile")
    /// Forget password?
    internal static let forgetPassword = L10n.tr("Localizable", "Profile.forgetPassword", fallback: "Forget password?")
    /// Log out
    internal static let logout = L10n.tr("Localizable", "Profile.logout", fallback: "Log out")
    /// Author panel
    internal static let operationsSectionTitle = L10n.tr("Localizable", "Profile.operationsSectionTitle", fallback: "Author panel")
    /// Privacy
    internal static let privacy = L10n.tr("Localizable", "Profile.privacy", fallback: "Privacy")
    /// Sign in
    internal static let signIn = L10n.tr("Localizable", "Profile.signIn", fallback: "Sign in")
    /// Sign up
    internal static let signUp = L10n.tr("Localizable", "Profile.signUp", fallback: "Sign up")
    /// Don't have an account? 
    internal static let signUpHint = L10n.tr("Localizable", "Profile.signUpHint", fallback: "Don't have an account? ")
    /// Profile
    internal static let title = L10n.tr("Localizable", "Profile.title", fallback: "Profile")
  }
  internal enum Settings {
    /// Allow e-mails
    internal static let allowEmails = L10n.tr("Localizable", "Settings.allowEmails", fallback: "Allow e-mails")
    /// Allow notifications
    internal static let allowNotifications = L10n.tr("Localizable", "Settings.allowNotifications", fallback: "Allow notifications")
    /// Crash reports
    internal static let crashReposts = L10n.tr("Localizable", "Settings.crashReposts", fallback: "Crash reports")
    /// Email
    internal static let emails = L10n.tr("Localizable", "Settings.emails", fallback: "Email")
    /// Settings
    internal static let navigationBarTitle = L10n.tr("Localizable", "Settings.navigationBarTitle", fallback: "Profile")
    /// Settings
    internal static let notifications = L10n.tr("Localizable", "Settings.notifications", fallback: "Notifications")
    internal enum SectionTitles {
      /// Communication
      internal static let communication = L10n.tr("Localizable", "Settings.SectionTitles.communication", fallback: "Communication")
      /// General
      internal static let general = L10n.tr("Localizable", "Settings.SectionTitles.general", fallback: "General")
      /// Privacy
      internal static let privacy = L10n.tr("Localizable", "Settings.SectionTitles.privacy", fallback: "Privacy")
    }
  }
  internal enum Shop {
    /// Shop
    internal static let tabBarItemTitle = L10n.tr("Localizable", "Shop.tabBarItemTitle", fallback: "Shop")
    /// Shop
    internal static let title = L10n.tr("Localizable", "Shop.title", fallback: "Shop")
  }
  internal enum SignIn {
    /// Authentication
    internal static let title = L10n.tr("Localizable", "SignIn.title", fallback: "Login")
  }
  internal enum SignUp {
    /// Sign up
    internal static let title = L10n.tr("Localizable", "SignUp.title", fallback: "Sign up")
  }
  internal enum Squads {
    /// Coach: 
    internal static let coachTitle = L10n.tr("Localizable", "Squads.coachTitle", fallback: "Coach: ")
    /// Squads
    internal static let listTitle = L10n.tr("Localizable", "Squads.listTitle", fallback: "Squads")
    /// Squads: 
    internal static let sectionTitle = L10n.tr("Localizable", "Squads.sectionTitle", fallback: "Squads: ")
    /// Count of squads: 
    internal static let squadsCountTitle = L10n.tr("Localizable", "Squads.squadsCountTitle", fallback: "Count of squads: ")
    /// Squads
    internal static let tabBarItemTitle = L10n.tr("Localizable", "Squads.tabBarItemTitle", fallback: "Squads")
    /// Trainings
    internal static let trainingTitle = L10n.tr("Localizable", "Squads.trainingTitle", fallback: "Trainings")
  }
  internal enum Staff {
    /// Staff
    internal static let coach = L10n.tr("Localizable", "Staff.coach", fallback: "Coach")
    /// Coach
    internal static let coachDescription = L10n.tr("Localizable", "Staff.coachDescription", fallback: "Coach")
    /// Player info
    internal static let player = L10n.tr("Localizable", "Staff.player", fallback: "Player info")
    /// Description
    internal static let playerDescription = L10n.tr("Localizable", "Staff.playerDescription", fallback: "Description")
  }
  internal enum TabBar {
    /// Contacts
    internal static let contacts = L10n.tr("Localizable", "TabBar.contacts", fallback: "Contacts")
    /// Finance
    internal static let finance = L10n.tr("Localizable", "TabBar.finance", fallback: "Finance")
    /// Main tab bar
    internal static let news = L10n.tr("Localizable", "TabBar.news", fallback: "News")
    /// Profile
    internal static let profile = L10n.tr("Localizable", "TabBar.profile", fallback: "Profile")
    /// Squads
    internal static let squads = L10n.tr("Localizable", "TabBar.squads", fallback: "Squads")
    /// Schedule
    internal static let trainingSchedule = L10n.tr("Localizable", "TabBar.trainingSchedule", fallback: "Schedule")
  }
  internal enum Team {
    /// About club
    internal static let aboutClubTitle = L10n.tr("Localizable", "Team.aboutClubTitle", fallback: "About club")
    /// Address: 
    internal static let addressTitle = L10n.tr("Localizable", "Team.addressTitle", fallback: "Address: ")
    /// E-mail: 
    internal static let emailTitle = L10n.tr("Localizable", "Team.emailTitle", fallback: "E-mail: ")
    /// Teams
    internal static let listTitle = L10n.tr("Localizable", "Team.listTitle", fallback: "Teams")
    /// on the map
    internal static let onTheMapTitle = L10n.tr("Localizable", "Team.onTheMapTitle", fallback: "on the map")
    /// Phone: 
    internal static let phoneTitle = L10n.tr("Localizable", "Team.phoneTitle", fallback: "Phone: ")
  }
  internal enum TrainingType {
    /// Gym
    internal static let gym = L10n.tr("Localizable", "TrainingType.gym", fallback: "Gym")
    /// Ice
    internal static let ice = L10n.tr("Localizable", "TrainingType.ice", fallback: "Ice")
    /// Unknown
    internal static let unknown = L10n.tr("Localizable", "TrainingType.unknown", fallback: "Unknown")
  }
  internal enum User {
    /// Unregistered user
    internal static let displayUnregistered = L10n.tr("Localizable", "User.displayUnregistered", fallback: "Unregistered user")
    /// User
    internal static let unregistered = L10n.tr("Localizable", "User.unregistered", fallback: "Unregistered")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
