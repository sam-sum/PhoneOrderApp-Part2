//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  CustomerRepository.swift
//  Date: Apr 13, 2023
//  Version: 2.0
//

import Foundation
import FirebaseFirestore

protocol CustomerRepositoryDelegate {
    func onCustomerSaved(customer: Customer)
    func onCustomerReceived(customer: Customer)
    func onCustomerUpdated(customer: Customer)
}

class CustomerRepository {
    private let delegate: CustomerRepositoryDelegate
    private let firestore: Firestore
    private static let rootCollectionName = "CustomerDatas"
    private static let fieldName = "name"
    private static let fieldPhoneNum = "phoneNum"
    private static let fieldAddress = "address"
    private static let fieldCity = "city"
    private static let fieldPostalCode = "postalCode"
    
    public init(delegate: CustomerRepositoryDelegate) {
        self.delegate = delegate
        firestore = Firestore.firestore()
    }
    
    public func customerToMap(customer: Customer) -> [String : Any] {
        var data: [String : Any] = [String : Any]()
        data[CustomerRepository.fieldName] = customer.name
        data[CustomerRepository.fieldPhoneNum] = customer.phoneNum
        data[CustomerRepository.fieldAddress] = customer.address
        data[CustomerRepository.fieldCity] = customer.city
        data[CustomerRepository.fieldPostalCode] = customer.postalCode
        return data
    }
    
    public func mapToCustomer(data: [String : Any]) -> Customer {
        var customer = Customer()
        customer.name = data[CustomerRepository.fieldName] as! String
        customer.phoneNum = data[CustomerRepository.fieldPhoneNum] as! String
        customer.address = data[CustomerRepository.fieldAddress] as! String
        customer.city = data[CustomerRepository.fieldCity] as! String
        customer.postalCode = data[CustomerRepository.fieldPostalCode] as! String
        return customer
    }
    
    public func docToCustomer(doc: DocumentSnapshot) -> Customer {
        var customer = mapToCustomer(data: doc.data()!)
        customer.id = doc.documentID
        return customer
    }
    
    public func saveCustomer(customer: Customer) {
        var data: [String : Any] = customerToMap(customer: customer)
        firestore
            .collection(CustomerRepository.rootCollectionName)
            .addDocument(data: data)
            .getDocument { [unowned self] (document, error) in
                guard let document = document else {
                    print("Fail to save customer")
                    return
                }
                
                let resultCustomer = docToCustomer(doc: document)
                delegate.onCustomerSaved(customer: resultCustomer)
            }
    }
    
    public func getCustomer(customerId: String) {
        firestore
            .collection(CustomerRepository.rootCollectionName)
            .document(customerId)
            .getDocument { [unowned self] (document, error) in
                guard let document = document else {
                    print("Fail to get customer")
                    return
                }
                
                let resultCustomer = docToCustomer(doc: document)
                delegate.onCustomerReceived(customer: resultCustomer)
            }
    }
    
    public func updateCustomer(customer: Customer) {
        let data = customerToMap(customer: customer)
        firestore
            .collection(CustomerRepository.rootCollectionName)
            .document(customer.id)
            .setData(data)
        delegate.onCustomerUpdated(customer: customer)
    }
}
