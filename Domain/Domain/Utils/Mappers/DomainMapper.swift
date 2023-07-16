//
//  DomainMapper.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 7/7/23.
//

import Foundation

/**
 *# SOS!
 * DomainModel typealias: is the model from application Domain Model
 * Model typealias: is the model that we want to convert Application Model and via versa
 *
 *
 * Every Mapper object has to implement DomainMapper interface in order to provide 4 methods
 * - modelToDomain: converts target model to domain model
 * - domainToDto: converts domain model to target model
 * - mapModelLists: this method has a default implementation and is used in order to map list of domain model objects into target model lists
 * - mapDomainLists: this method has a default implementation and is used in order to map list of target model objects into domain model lists
 */
public protocol DomainMapper {
    associatedtype Model: Codable
    associatedtype DomainModel: Codable
        
    func modelToDomain(model: Model) -> DomainModel
    
    func domainToModel(domainModel: DomainModel) -> Model
    
    func mapModelLists(domainList: [DomainModel]) -> [Model]
    
    func mapDomainLists(modelList: [Model]) -> [DomainModel]
}

extension DomainMapper {
    public func mapModelLists(domainList: [DomainModel]) -> [Model] {
        return domainList.map {
            domainToModel(domainModel: $0)
        }
    }
    
    public func mapDomainLists(modelList: [Model]) -> [DomainModel] {
        return modelList.map {
            modelToDomain(model: $0)
        }
    }
}

public protocol PagingDataDomainMapper: DomainMapper {
    func domainToPagingData(
           response: PagedGenericResponse<[Model]>?
       ) -> PagedListResult<DomainModel>
}

extension PagingDataDomainMapper {
    public func domainToPagingData(
        response: PagedGenericResponse<[Model]>?
    ) -> PagedListResult<DomainModel> {
        let totalPages = response?.total_pages ?? 0
        let cur = response?.page ?? 0
        let next = cur != totalPages ? cur + 1 : cur
        let prev = min(cur - 1, 0)
        
        return PagedListResult(
            results : mapDomainLists(modelList: response?.results ?? []),
            next : next > cur ? next : nil,
            previous : prev < cur ? prev : nil,
            current : cur,
            total : response?.total_results
        )
    }
}

public class GenericPagingMapper<T: Codable>: PagingDataDomainMapper {
    
    public typealias Model = T
    
    public typealias DomainModel = T
    
    public init() {}
    
    public func modelToDomain(model: T) -> T {
        return model
    }
    
    public func domainToModel(domainModel: T) -> T {
        return domainModel
    }

}

