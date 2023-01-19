//
//  ConfigFactory.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 17.12.2022.
//

import Foundation

struct ConfigFactory {
    static func getCountries(ip: String?) -> ApiRequestConfig<CountryParser> {
        return ApiRequestConfig(endPoint: SBApiEndPoint.countries(ip: ip), parser: CountryParser())
    }
//    static func setPremium() -> ApiRequestConfig<SetPremiumParser> {
//        return ApiRequestConfig(endPoint: BlazrApiEndPoint.setPremium(days: nil), parser: SetPremiumParser())
//    }
//    static func revokeAppleToken(token: String,
//                                 secret: String,
//                                 clientId: String) -> ApiRequestConfig<AppleRevokeTokenParser> {
//        return ApiRequestConfig(endPoint: AppleApiEndPoint.revokeAppleToken(clientId: clientId, clientSecret: secret, clientToken: token), parser: AppleRevokeTokenParser())
//    }
//    static func loadLink() -> ApiRequestConfig<LinkParser> {
//        return ApiRequestConfig(endPoint: BlazrJSONEndPoint.link, parser: LinkParser())
//    }
//    static func deleteProfile() -> ApiRequestConfig<DeleteParser> {
//        return ApiRequestConfig(endPoint: BlazrApiEndPoint.delete, parser: DeleteParser())
//    }
    static func auth(code: String) -> ApiRequestConfig<AppleAuthParser> {
        return ApiRequestConfig(endPoint: SBApiEndPoint.appleAuth(code), parser: AppleAuthParser())
    }
    static func auth(token: String) -> ApiRequestConfig<AuthParser> {
        return ApiRequestConfig(endPoint: SBApiEndPoint.auth(token), parser: AuthParser())
    }
    static func savePushToken(token: String, country: String) -> ApiRequestConfig<SavePushTokenParser> {
        return ApiRequestConfig(endPoint: SBApiEndPoint.updatePushToken(pushToken: token, countryCode: country), parser: SavePushTokenParser())
    }
    static func revokeAppleToken(appleId: String) -> ApiRequestConfig<AppleRevokeTokenParser> {
        return ApiRequestConfig(endPoint: SBApiEndPoint.revokeAppleToken(appleId: appleId), parser: AppleRevokeTokenParser())
    }
}
