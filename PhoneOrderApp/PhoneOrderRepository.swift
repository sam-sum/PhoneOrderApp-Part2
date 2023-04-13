//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  PhoneOrderRepository.swift
//  Date: Apr 11, 2023
//  Version: 2.0
//

import Foundation
import FirebaseFirestore

protocol PhoneOrderRepositoryDelegate {
    func onPhoneOrderSaved(order: PhoneOrder)
    func onPhoneOrdersReceived(orders: [PhoneOrder])
}

class PhoneOrderRepository {
    private let delegate: PhoneOrderRepositoryDelegate
    private let firestore: Firestore
    private static let rootCollectionName = "CustomerDatas"
    private static let collectionName = "PhoneOrders"
    private static let fieldModel = "model"
    private static let fieldPrice = "price"
    private static let fieldStorage = "storage"
    private static let fieldColor = "color"
    private static let fieldCustomerName = "customerName"
    private static let fieldPhoneNum = "phoneNum"
    private static let fieldAddress = "address"
    private static let fieldCity = "city"
    private static let fieldPostalCode = "postalCode"
    private static let fieldCreditCardNum = "creditCardNum"
    private static let fieldCreditCardExpiryDate = "creditCardExpiryDate"
    private static let fieldCreditCardCVV = "creditCardCVV"
    private static let fieldCreditCardHolder = "creditCardHolder"
    private static let fieldStatus = "status"
    private static let fieldCreateDate = "createDate"
    
    public init(delegate: PhoneOrderRepositoryDelegate) {
        self.delegate = delegate
        firestore = Firestore.firestore()
    }
    
    public func phoneOrderToMap(order: PhoneOrder) -> [String : Any] {
        var data: [String : Any] = [String : Any]()
        data[PhoneOrderRepository.fieldModel] = order.model
        data[PhoneOrderRepository.fieldPrice] = order.price
        data[PhoneOrderRepository.fieldStorage] = order.storage
        data[PhoneOrderRepository.fieldColor] = order.color
        data[PhoneOrderRepository.fieldCustomerName] = order.customerName
        data[PhoneOrderRepository.fieldPhoneNum] = order.phoneNum
        data[PhoneOrderRepository.fieldAddress] = order.address
        data[PhoneOrderRepository.fieldCity] = order.city
        data[PhoneOrderRepository.fieldPostalCode] = order.postalCode
        data[PhoneOrderRepository.fieldCreditCardNum] = order.creditCardNum
        data[PhoneOrderRepository.fieldCreditCardExpiryDate] = order.creditCardExpiryDate
        data[PhoneOrderRepository.fieldCreditCardCVV] = order.creditCardCVV
        data[PhoneOrderRepository.fieldCreditCardHolder] = order.creditCardHolder
        data[PhoneOrderRepository.fieldStatus] = order.status
        data[PhoneOrderRepository.fieldCreateDate] = order.createDate
        return data
    }
    
    public func mapToPhoneOrder(data: [String : Any]) -> PhoneOrder {
        var order = PhoneOrder()
        order.model = data[PhoneOrderRepository.fieldModel] as! String
        order.price = data[PhoneOrderRepository.fieldPrice] as! Double
        order.storage = data[PhoneOrderRepository.fieldStorage] as! String
        order.color = data[PhoneOrderRepository.fieldColor] as! String
        order.customerName = data[PhoneOrderRepository.fieldCustomerName] as! String
        order.phoneNum = data[PhoneOrderRepository.fieldPhoneNum] as! String
        order.address = data[PhoneOrderRepository.fieldAddress] as! String
        order.city = data[PhoneOrderRepository.fieldCity] as! String
        order.postalCode = data[PhoneOrderRepository.fieldPostalCode] as! String
        order.creditCardNum = data[PhoneOrderRepository.fieldCreditCardNum] as! String
        order.creditCardExpiryDate = data[PhoneOrderRepository.fieldCreditCardExpiryDate] as! String
        order.creditCardCVV = data[PhoneOrderRepository.fieldCreditCardCVV] as! String
        order.creditCardHolder = data[PhoneOrderRepository.fieldCreditCardHolder] as! String
        order.status = data[PhoneOrderRepository.fieldStatus] as! String
        order.createDate = data[PhoneOrderRepository.fieldCreateDate] as! String
        return order
    }
    
    public func docToPhoneOrder(doc: DocumentSnapshot) -> PhoneOrder {
        var order = mapToPhoneOrder(data: doc.data()!)
        order.id = doc.documentID
        return order
    }
    
    public func savePhoneOrder(customerId: String, order: PhoneOrder) {
        var data: [String : Any] = phoneOrderToMap(order: order)
        firestore
            .collection(PhoneOrderRepository.rootCollectionName)
            .document(customerId)
            .collection(PhoneOrderRepository.collectionName)
            .addDocument(data: data)
            .getDocument { [unowned self] (document, error) in
                guard let document = document else {
                    print("Fail to save phone order")
                    return
                }
                
                let resultOrder = docToPhoneOrder(doc: document)
                delegate.onPhoneOrderSaved(order: resultOrder)
            }
    }
    
    public func getAllPhoneOrders(customerId: String) {
        firestore
            .collection(PhoneOrderRepository.rootCollectionName)
            .document(customerId)
            .collection(PhoneOrderRepository.collectionName)
            .getDocuments { [unowned self] (documents, error) in
                guard let documents = documents else {
                    print("Fail to get orders")
                    return
                }
                
                var orders = [PhoneOrder]()
                for document in documents.documents {
                    let order = docToPhoneOrder(doc: document)
                    orders.append(order)
                }
                delegate.onPhoneOrdersReceived(orders: orders)
            }
    }
    
    public func updatePhoneOrder(customerId: String, order: PhoneOrder) {
        let data = phoneOrderToMap(order: order)
        firestore
            .collection(PhoneOrderRepository.rootCollectionName)
            .document(customerId)
            .collection(PhoneOrderRepository.collectionName)
            .document(order.id)
            .setData(data)
    }
}
