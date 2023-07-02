//
//  InjectDependencies.swift
//  Data
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Domain

private struct TvShowsDataContextProvider: InjectionKey {
    static var currentValue: TvShowsDataContext = TvShowsDatacontextImpl(networkProvider: NetworkProviderImpl())
}

extension InjectedValues {
    
    public var tvShowsDataContext: TvShowsDataContext {
        get { Self[TvShowsDataContextProvider.self] }
        set { Self[TvShowsDataContextProvider.self] = newValue }
    }
}
