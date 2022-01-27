//
//  SportTeamTheme.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 22.01.2022.
//

import Foundation
import UIKit

public protocol AppTheme {
    func getItunesAppId() -> String
    func getImageLogoHeader() -> String
    func getImageLogoVertical() -> String

    // Ссылка на пользовательское соглашение, перекрывает настройки сервера
    func getPrivacyURL() -> URL?
    func getProductionServer() -> String
    // не используется, приходит с сервера
    func getSupportPhone() -> String
    func tintColor() -> UIColor
    func mainColor() -> UIColor
    func secondColor() -> UIColor
    func getNavigationElementsColor() -> UIColor
    func registrationButtonStyle() -> ComponentStyle
    // не используется
    func isOneDutyDoctor() -> Bool
    func isNameRequiredOnRegistration() -> Bool
    func isBirthdayRequiredOnRegistration() -> Bool
    // показывает время ближайшей консультации
    func isShowTimeToAppointment() -> Bool
    func getDoctorUserpicImage() -> String
    func getColorForDutyDoctorTitle() -> UIColor

    func isShowPatientNameOnPayment() -> Bool
    // Если false то по кнопке "Зарегистрироваться" показывается алерт
    func isRegistrationAllowed() -> Bool
    // Прячет кнопку "Зарегистрироваться"
    func isHideRegistrationButton() -> Bool
    // регистрация через восстановление пароля
    func isRequestRegistration() -> Bool
    // Скрыть цены, при запуске приложения кидает сразу на логин
    func isShowMoney() -> Bool
    func getYandexMetricaId() -> String?
    func getDoctorListTabBarIcon() -> String
    func getPartnerId() -> String
    // скрытие кнопки логаут для сдк
    func isExternalAuthentication() -> Bool
    // Убрает кнопку "записаться" в окне списка врачей
    func isShowMakeAppointmentButton() -> Bool
    // Вместо имени врача показывается название очереди
    func isShowQueueNameInChat() -> Bool
    // Показывать во вкладке таб бара количество непрочитанных сообщений во всех консультациях
    // (если false то показывать количество активных консультаций)
    func isShowNewMessagesCountOnBadge() -> Bool
    // Показывать или нет блок с условиями обслуживания в профиле
    func isShowConditionsInProfile() -> Bool

    // Скрыть блок с дежурными
    func isHideDutyDoctors() -> Bool

    // Выводить или нет табы навигации по разделам приложения для незалогиненного пользователя. Если false то
    // показывается только вкладка и окно NotLoggedInViewController
    func isShowNavigationTabsWhenNotLoggedIn() -> Bool

    // Включает функционал семейных кабинетов
    func isFamilySwitchedOn() -> Bool

    // chat customization
    // 3f923f
    func getCallControllersColorFirst() -> UIColor
    func getCallControllersColorSecond() -> UIColor
    func getHangupColor() -> UIColor
    func getCallBackgroundColor() -> UIColor
    func getIncomeBubbleColor() -> UIColor
    func getOutcomeBubbleColor() -> UIColor

    // Font
    func getRegularFontName() -> String
    func getMediumFontName() -> String
    func getBoldFontName() -> String

    // Токен для сервиса mixpanel
    func getEventServiceToken() -> String?

    // Показывать или скрывать таб бар, это сновной жлемент навигации
    func isShowMainTabBar() -> Bool

    // Активировать ли IQKeyboardManager.shared.enableAutoToolbar
    func isKeyboardToolBarEnabled() -> Bool

    // HealthDiary
    func getHealthMainColor() -> UIColor
    func getHealthSecondColor() -> UIColor
    func getHealthMeasureBackPlateColor() -> UIColor
    func getHealthMeasureTagCloudBackPlateColor() -> UIColor
    func getHealthBackPlateColor() -> UIColor
    
    // Показывать ли кнопку "Забыли пароль?"
    func isShowForgotPasswordButton() -> Bool

    // Показывать в настройках пункт "Изменить пароль"
    func isShowChangePasswordSettings() -> Bool
    
    // Получить код страны при вводе номера телефона
    func getCodeCountry() -> String

    // Добавить во все запросы заголовки Partner-Only и Partner-Code
    func isPartnerOnly() -> Bool
    
    // Тестовый пользватель из апстор, можно не указывать
    func getAppleTestUserLogin() -> String?

    // При старте приложения показывать сначала страницу логина
    func isStartFromLoginView() -> Bool
    
    // Показывать таб "Уведомления по SMS"
    func isShowTabBySMS() -> Bool
    
    // AppsFlyer
    func getAppsFlyDevKey() -> String?
    func getAppsFlyAppId() -> String?

    // Показывать кнопку авторизации через ЕСИА
    func isShowESIALogin() -> Bool

    // Показывать функционал авторизации по логину и паролю
    func isShowLoginByEmail() -> Bool

    // Показывать на экране логина кнопку "О компании"
    func isShowAboutCompanyLink() -> Bool
    
    // Показывать номера телефонов в alert-е с ошибкой регистрации
    func isShowPhoneNumberViews() -> Bool

    // Показывать форму ввода промокодов(раньше убиралось вместе с выключением isShowMoney)
    // работает совместно с isShowConditionsInProfile
    func isShowPromocodes() -> Bool
    
    // Показывать возрастной фильтр
    func isShowAgeFilter() -> Bool
    
    // Проверить, есть ли на сегодня консультации
    func shouldCheckNextAppointment() -> Bool

    // Проверять, завершена ли консультация автоматически (для ДЗМ)
    func shouldCheckRefuseAppointments() -> Bool
    
    // Возможность отправки логов приложения
    func isSendLogs() -> Bool
}

public protocol TMKThemeExtensional {
    var mainColorPartner: UIColor? { get set }
    var secondColorPartner: UIColor? { get set }
    var logoPartner: String? { get set }
}

