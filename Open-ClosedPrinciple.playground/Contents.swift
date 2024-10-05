import UIKit

// MARK: - Open/Closed Principle (OCP)
// Softwere entities (classes, modules, functions, etc.) should be open for extension, but closed for modification.
// meaning if we want to add new functionality we should not touch the existing code.


// MARK: - The problem -> if we have an class or struct and it's doing one job like total job here.
// and we want to add some other jobs like print or save the bad way to come and add all in the same place like this example.

struct Product {
    let price: Double
    
}

struct BadInvoice {
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

// MARK: - Solution using (SRP) and (OCP) if we remember from (SRP) we should make each other functionality out side so what we can do here ?
// you can come and make something like this : -

extension BadInvoice {
    func saveInvoiceX() {
        print("Invoice saved with iD \(id)")
    }
}
// but there's a best and clean way to do it in swift using (Protocol), and because also swift depend on (POP).
// so what we should do here ?
// we will create (Protocol) for each new functionality and new struct to implement the logic.
// first let's create a new copy

struct Invoice {
    var products: [Product]
    let id = NSUUID().uuidString
    var discountPercentage: Double = 0
    // you will understand this line, complete to the end ⬇️.
    let printable: InvoicePrintable
    
    // you will understand this line, complete to the end ⬇️.
    func printInvoice() {
        printable.printInvoice(invoice: self)
    }
    
    var total: Double {
        let total = products.map({$0.price}).reduce(0, {$0  + $1})
        let discount = total * (discountPercentage / 100)
        return total - discount
    }
}
// protocol for print function.
protocol InvoicePrintable {
    func printInvoice(invoice: Invoice)
}

// new struct for implementation.
struct ConsoleInvoicePrintable: InvoicePrintable {
    func printInvoice(invoice: Invoice) {
        // print logic
        print("Invoice saved with iD \(invoice.id)")
        print("Invoice saved with total \(invoice.total)")
        print("Invoice saved with discount \(invoice.discountPercentage)")
    }
}
// now we will initialese the protocol in our main struct ⬆️ .
// create a function to call the print logic.

// MARK: - Time to use it.
let products: [Product] = [
    .init(price: 420.99),
    .init(price: 120.99),
    .init(price: 20.99),
]
let printable = ConsoleInvoicePrintable()
let invoice = Invoice(products: products,
                      discountPercentage: 20,
                      printable: printable)
invoice.printInvoice()

