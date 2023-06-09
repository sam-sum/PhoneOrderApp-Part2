//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  PhoneRepository.swift
//  Date: Apr 13, 2023
//  Version: 2.0
//

import Foundation
import FirebaseFirestore

protocol PhoneRepositoryDelegate {
    func onPhonesReceived(phones: [Phone])
}

class PhoneRepository {
    private let delegate: PhoneRepositoryDelegate
    private let firestore: Firestore
    private static let rootCollectionName = "Phones"
    private static let collectionName = "Models"
    private static let fieldModel = "model"
    private static let fieldPrice = "price"
    private static let fieldColors = "colors"
    private static let fieldStoragesAndPrices = "storagesAndPrices"
    
    public init(delegate: PhoneRepositoryDelegate) {
        self.delegate = delegate
        firestore = Firestore.firestore()
    }
    
    public func mapToPhone(data: [String : Any]) -> Phone {
        var phone = Phone()
        phone.model = data[PhoneRepository.fieldModel] as! String
        phone.price = data[PhoneRepository.fieldPrice] as! Double
        phone.colors = data[PhoneRepository.fieldColors] as? [String] ?? [String]()
        phone.storagesAndPrices = data[PhoneRepository.fieldStoragesAndPrices] as? [String : Double] ?? [String : Double]()
        return phone
    }
    
    public func getPhonesByBrand(brand: String) {
        firestore
            .collection(PhoneRepository.rootCollectionName)
            .document(brand)
            .collection(PhoneRepository.collectionName)
            .getDocuments { [unowned self] (documents, error) in
                guard let documents = documents else {
                    print("Fail to get phones")
                    return
                }
                
                var phones = [Phone]()
                for document in documents.documents {
                    let phone = mapToPhone(data: document.data())
                    phones.append(phone)
                }
                delegate.onPhonesReceived(phones: phones)
            }
    }
}
