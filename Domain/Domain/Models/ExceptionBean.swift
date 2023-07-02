//
//  ExceptionBean.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation

// MARK: - ExceptionBean
public struct ExceptionBean: Codable {
    public let errors: [ErrorBean]?
    public let total: Int?
    
    public init(errors: [ErrorBean]?, total: Int?) {
        self.errors = errors
        self.total = total
    }
}

// MARK: - ErrorBean
public struct ErrorBean: Codable {
    public let code: Int?
    public let datetime, debug, errorDescription, redirect: String?
    public let title: String?
    public let exceptionCode: String?
    
    public init(code: Int? = nil, datetime: String? = nil, debug: String? = nil, errorDescription: String? = nil, redirect: String? = nil, title: String? = nil, exceptionCode: String? = nil) {
        self.code = code
        self.datetime = datetime
        self.debug = debug
        self.errorDescription = errorDescription
        self.redirect = redirect
        self.title = title
        self.exceptionCode = exceptionCode
    }
    
    public enum CodingKeys: String, CodingKey {
        case code, datetime, debug
        case errorDescription = "description"
        case redirect, title, exceptionCode
    }
    
    public enum ExceptionCode: String, Codable, SafeEnumType {
        public static var defaultCase: ErrorBean.ExceptionCode = .unexpected
        
        case unauthorized = "UNAUTHORIZED"
        case unexpected = "UNEXPECTED"
        case feignException = "FEIGN_EXCEPTION"
        case optimisticLockingFailureException = "OPTIMISTIC_LOCKING_FAILURE_EXCEPTION"
        case errandIdValidation = "ERRAND_ID_VALIDATION"
        case errandCancelled = "ERRAND_CANCELLED"
        case errandAssignedToAnother = "ERRAND_ASSIGNED_TO_ANOTHER"
        case errandCannotServed = "ERRAND_CANNOT_SERVED"
        case notFound = "NOT_FOUND"
        case badRequest = "BAD_REQUEST"
        case materialCostValidationError = "MATERIAL_COST_VALIDATION_ERROR"
        case walletException = "WALLET_EXCEPTION"
        case errandTimeChanged = "ERRAND_TIME_CHANGED"
        case errandTimeAddressChanged = "ERRAND_TIME_ADDRESS_CHANGED"
        case errandAddressChanged = "ERRAND_ADDRESS_CHANGED"
        case errandDisputeCancelled = "ERRAND_DISPUTE_CANCELLED"
        case errandCancelledAssignment = "ERRAND_CANCELLED_ASSIGNMENT"
        case errandCompleted = "ERRAND_COMPLETED"
        case errandTimeChangedAssigned = "ERRAND_TIME_CHANGED_ASSIGNED"
        case errandTaskerCancelled = "ERRAND_TASKER_CANCELLED"
        case assetAnalyticsRetrievalError = "ASSET_ANALYTICS_RETRIEVAL_ERROR"
        case invalidTimespan = "INVALID_TIMESPAN"
        case productEmptyList = "PRODUCT_EMPTY_LIST"
        case productNotFound = "PRODUCT_NOT_FOUND"
        case providerNotFound = "PROVIDER_NOT_FOUND"
        case dataSaveError = "DATA_SAVE_ERROR"
        case assetRetrievalError = "ASSET_RETRIEVAL_ERROR"
        case balanceNotUpToDate = "BALANCE_NOT_UP_TO_DATE"
        case invalidBucketModification = "INVALID_BUCKET_MODIFICATION"
        case notificationsRetrievalError = "NOTIFICATIONS_RETRIEVAL_ERROR"
        case genericError = "GENERIC_ERROR"
        case badData = "BAD_DATA"
        case telcoMobileSwapData = "TELCO_MOBILE_SWAP_ERROR"
        case areaTooComplicated = "AREA_TOO_COMPLICATED"
        case areaTooBig = "AREA_TOO_BIG"
        case areaOutOfCountry = "AREA_OUT_OF_COUNTRY"
        case areaGeneralError = "AREA_GENERAL_ERROR"
        case minCashoutReached = "MIN_CASHOUT_REACHED"
        case kycLvl1LimitExceded = "WAL_CBB_5001"
        case walletPaymentRejected = "WAL_SIA_9904"
        case passwordExpired = "PASSWORD EXPIRED"
        case cardActivationWrongInput = "WALLET_CARD_ACTIVATION_WRONG_INPUT"
        case cardActivatioMaxTryFails = "WALLET_CARD_ACTIVATION_MAX_FAILS"
    }
}
