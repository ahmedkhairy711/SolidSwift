import SwiftUI
import UIKit
import Foundation



// MARK: - (SRP)
// A class should have only one thing to do or should only be responsible for one thing.


// MARK: - The problem -> "The bad way"
// we have here more than one responsibility for this struct.

struct Product {
    let price: Double
    
}

struct Invoice {
    var products: [Product]
    let id = NSUUID().uuidString
    var discountPercentage: Double = 0
    
    // 1
    var total: Double {
        let total = products.map({$0.price}).reduce(0, {$0  + $1})
        let discount = total * (discountPercentage / 100)
        return total - discount
    }
    
    // 2
    func printInvoice() {
        print("Invoice iD \(id)")
        print("Total cost $\(total)")
        print("Discount \(discountPercentage)")
    }
    
    // 3
    func saveInvoice() {
        print("Invoice saved with iD \(id)")
    }
}

/*
 So how to solve this problem and make this struct use SRP.
 -> extract this functionality in another struct.
 */

// MARK: - Solution -> "The better way"
struct NewInvoice {
    var products: [Product]
    let id = NSUUID().uuidString
    var discountPercentage: Double = 0
    
    // 1
    var total: Double {
        let total = products.map({$0.price}).reduce(0, {$0  + $1})
        let discount = total * (discountPercentage / 100)
        return total - discount
    }
    
    // Here we have two ways you can keep the function in the same struct but the implementation out side.
    // MARK: - Better for scale but not good for testing.
    // or you can remove it and you already have every thing out side.
    func printInvoice() {
        let printer = InvoicePrinter(invoice: self)
        printer.printInvoice()
    }
    
  
    func saveInvoice() {
        let persistence = InvoicePersistence(invoice: self)
        persistence.saveInvoice()
    }
}

// for print.
struct InvoicePrinter {
    let invoice: NewInvoice
    
    func printInvoice() {
        print("Invoice iD \(invoice.id)")
        print("Total cost $\(invoice.total)")
        print("Discount \(invoice.discountPercentage)")
    }
    
}

// for save.
struct InvoicePersistence{
    let invoice: NewInvoice
    
    func saveInvoice() {
        print("Invoice saved with iD \(invoice.id)")
    }
    
}

// MARK: - Time to use it.
let products: [Product] = [
    .init(price: 299.99),
    .init(price: 99.99),
    .init(price: 9.99)
]

// from out side.
let invoice = NewInvoice(products: products,
                         discountPercentage: 20)
let printer = InvoicePrinter(invoice: invoice)
let persistence = InvoicePersistence(invoice: invoice)
printer.printInvoice()
persistence.saveInvoice()

// from in side.
print("----------------")
let newInvoice = NewInvoice(products: products,
                         discountPercentage: 20)

newInvoice.printInvoice()
newInvoice.saveInvoice()

print("----------------")
// MARK: - if you want use it twice (out side).
let invoice2 = NewInvoice(products: products,
                         discountPercentage: 40)
let printer2 = InvoicePrinter(invoice: invoice2)
let persistence2 = InvoicePersistence(invoice: invoice2)
printer2.printInvoice()
persistence2.saveInvoice()

// MARK: - if you want use it twice (in side).ˆ
print("----------------")
let newInvoice2 = NewInvoice(products: products,
                         discountPercentage: 30)

newInvoice2.printInvoice()
newInvoice2.saveInvoice()



