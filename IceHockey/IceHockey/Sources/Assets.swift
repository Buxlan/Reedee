// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let apple = ImageAsset(name: "Apple")
  internal static let facebook = ImageAsset(name: "Facebook")
  internal static let gitHub = ImageAsset(name: "GitHub")
  internal static let google = ImageAsset(name: "Google")
  internal static let microsoft = ImageAsset(name: "Microsoft")
  internal static let twitter = ImageAsset(name: "Twitter")
  internal static let yahoo = ImageAsset(name: "Yahoo")
  internal static let accent0 = ColorAsset(name: "accent0")
  internal static let accent1 = ColorAsset(name: "accent1")
  internal static let accent2 = ColorAsset(name: "accent2")
  internal static let accent3 = ColorAsset(name: "accent3")
  internal static let facebookLogin = ColorAsset(name: "facebookLogin")
  internal static let main0 = ColorAsset(name: "main0")
  internal static let main1 = ColorAsset(name: "main1")
  internal static let main2 = ColorAsset(name: "main2")
  internal static let other0 = ColorAsset(name: "other0")
  internal static let other1 = ColorAsset(name: "other1")
  internal static let other2 = ColorAsset(name: "other2")
  internal static let other3 = ColorAsset(name: "other3")
  internal static let textColor = ColorAsset(name: "textColor")
  internal static let firebaseIcon = ImageAsset(name: "firebaseIcon")
  internal static let firebaseLogo = ImageAsset(name: "firebaseLogo")
  internal static let conference = ImageAsset(name: "Conference")
  internal static let crowd = ImageAsset(name: "Crowd")
  internal static let hockeyField = ImageAsset(name: "HockeyField")
  internal static let hockeyGlove = ImageAsset(name: "HockeyGlove")
  internal static let hockeyHelmet = ImageAsset(name: "HockeyHelmet")
  internal static let hockeyMask = ImageAsset(name: "HockeyMask")
  internal static let iceHockeyStick = ImageAsset(name: "IceHockeyStick")
  internal static let jockeySkates = ImageAsset(name: "JockeySkates")
  internal static let join = ImageAsset(name: "Join")
  internal static let arrowRight = ImageAsset(name: "arrow.right")
  internal static let buildingColumns = ImageAsset(name: "buildingColumns")
  internal static let buildingColumnsFill = ImageAsset(name: "buildingColumnsFill")
  internal static let camera = ImageAsset(name: "camera")
  internal static let chevronRight = ImageAsset(name: "chevronRight")
  internal static let contacts = ImageAsset(name: "contacts")
  internal static let emailAuth = ImageAsset(name: "emailAuth")
  internal static let exclamationmarkCircle = ImageAsset(name: "exclamationmarkCircle")
  internal static let eye = ImageAsset(name: "eye")
  internal static let eyeFill = ImageAsset(name: "eyeFill")
  internal static let gear = ImageAsset(name: "gear")
  internal static let gearFill = ImageAsset(name: "gearFill")
  internal static let heart = ImageAsset(name: "heart")
  internal static let heartFill = ImageAsset(name: "heartFill")
  internal static let home = ImageAsset(name: "home")
  internal static let homeFill = ImageAsset(name: "homeFill")
  internal static let lock = ImageAsset(name: "lock")
  internal static let map = ImageAsset(name: "map")
  internal static let micFill = ImageAsset(name: "mic.fill")
  internal static let mic = ImageAsset(name: "mic")
  internal static let news = ImageAsset(name: "news")
  internal static let paintbrushPointedFill = ImageAsset(name: "paintbrushPointedFill")
  internal static let pencil = ImageAsset(name: "pencil")
  internal static let person = ImageAsset(name: "person")
  internal static let person3 = ImageAsset(name: "person3")
  internal static let person3Fill = ImageAsset(name: "person3Fill")
  internal static let personCircleFill = ImageAsset(name: "personCircleFill")
  internal static let personCropCircleBadgePlus = ImageAsset(name: "personCropCircleBadgePlus")
  internal static let personCropCircleFillBadgePlus = ImageAsset(name: "personCropCircleFillBadgePlus")
  internal static let photo = ImageAsset(name: "photo")
  internal static let play = ImageAsset(name: "play")
  internal static let plus = ImageAsset(name: "plus")
  internal static let plusSquare = ImageAsset(name: "plusSquare")
  internal static let questionMark = ImageAsset(name: "questionMark")
  internal static let share = ImageAsset(name: "share")
  internal static let shoppingCart = ImageAsset(name: "shoppingCart")
  internal static let timetable = ImageAsset(name: "timetable")
  internal static let xmark = ImageAsset(name: "xmark")
  internal static let coach0 = ImageAsset(name: "coach0")
  internal static let coach1 = ImageAsset(name: "coach1")
  internal static let event0 = ImageAsset(name: "event0")
  internal static let event1 = ImageAsset(name: "event1")
  internal static let event2 = ImageAsset(name: "event2")
  internal static let event3 = ImageAsset(name: "event3")
  internal static let event4 = ImageAsset(name: "event4")
  internal static let event5 = ImageAsset(name: "event5")
  internal static let event6 = ImageAsset(name: "event6")
  internal static let event7 = ImageAsset(name: "event7")
  internal static let login = ImageAsset(name: "login")
  internal static let logo = ImageAsset(name: "logo")
  internal static let logoRedBGColor = ImageAsset(name: "logoRedBGColor")
  internal static let noImage256 = ImageAsset(name: "noImage256")
  internal static let onboarding1 = ImageAsset(name: "onboarding1")
  internal static let onboarding2 = ImageAsset(name: "onboarding2")
  internal static let onboarding3 = ImageAsset(name: "onboarding3")
  internal static let player0 = ImageAsset(name: "player0")
  internal static let squad2012 = ImageAsset(name: "squad2012")
  internal static let squadLogo = ImageAsset(name: "squadLogo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
