//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  StoreRepository.swift
//  Date: Apr 13, 2023
//  Version: 2.0
//

import Foundation
import FirebaseFirestore

protocol StoreRepositoryDelegate {
    func onStoreReceived(stores: [[String : String]])
}

class StoreRepository {
    private let delegate: StoreRepositoryDelegate
    private let firestore: Firestore
    private static let rootCollectionName = "Stores"
    private static let collectionName = "Models"
    private static let fieldName = "name"
    private static let fieldAddress = "address"
    private static let fieldPhone = "phone"
    private static let fieldHours = "hours"
    private static let fieldWebsite = "website"
    private static let fieldLat = "lat"
    private static let fieldLng = "lng"
    
    public init(delegate: StoreRepositoryDelegate) {
        self.delegate = delegate
        firestore = Firestore.firestore()
    }
    
    public func mapToStore(data: [String : Any]) -> Store {
        var store = Store()
        store.name = data[StoreRepository.fieldName] as! String
        store.address = data[StoreRepository.fieldAddress] as! String
        store.phone = data[StoreRepository.fieldPhone] as! String
        store.hours = data[StoreRepository.fieldHours] as! String
        store.website = data[StoreRepository.fieldWebsite] as! String
        store.lat = data[StoreRepository.fieldLat] as! String
        store.lng = data[StoreRepository.fieldLng] as! String
        return store
    }
    
    public func getStoresByBrand(brand: String) {
        firestore
            .collection(StoreRepository.rootCollectionName)
            .document(brand)
            .collection(StoreRepository.collectionName)
            .getDocuments { [unowned self] (documents, error) in
                guard let documents = documents else {
                    print("Fail to get stores")
                    return
                }
                
                var stores = [[String : String]]()
                for document in documents.documents {
                    let store = mapToStore(data: document.data())
                    stores.append(store.toMap())
                }
                delegate.onStoreReceived(stores: stores)
            }
    }
}
