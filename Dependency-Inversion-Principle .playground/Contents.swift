import UIKit

// MARK: Dependency Inversion Principle (DIP)
// High-level module should not depend on low-level modules, but should depend on abstraction,
// if a high-level imports any low-level module then code becomes tightly coupled.
// changes in one class could break another class.

// MARK: - The problem

struct DebitCardPayment {
    func pay(amount: Double) {
        print("Debit Card Payment: \(amount)")
    }
}

struct StripePayment {
    func pay(amount: Double) {
        print("Stripe Payment: \(amount)")
    }
}

struct ApplePayPayment {
    func pay(amount: Double) {
        print("Apple Pay Payment: \(amount)")
    }
}

struct PaymentGateway {
    var debitCardPayment: DebitCardPayment?
    var stripePayment: StripePayment?
    var applePayPayment: ApplePayPayment?
}
let paymentMethod = DebitCardPayment()
let paymentGateway = PaymentGateway(debitCardPayment: paymentMethod,
                                    stripePayment: nil,
                                    applePayPayment: nil)
paymentGateway.debitCardPayment?.pay(amount: 100)
// This wrong because PaymentGateway depend on all low level methods.

// MARK: - Solution
// let's create a new copy of code.

struct NewDebitCardPayment:PaymentMethod {
    func pay(amount: Double) {
        print("Debit Card Payment: \(amount)")
    }
}

struct NewStripePayment:PaymentMethod {
    func pay(amount: Double) {
        print("Stripe Payment: \(amount)")
    }
}

struct NewApplePayPayment: PaymentMethod {
    func pay(amount: Double) {
        print("Apple Pay Payment: \(amount)")
    }
}
// we will need to create a protocol.

protocol PaymentMethod {
    func pay(amount: Double)
}

struct PaymentGatewayDIP {
    let paymentMethod: PaymentMethod // Abstraction
    
    func pay(amount: Double) {
        paymentMethod.pay(amount: amount)
    }
}
// let's use it.
let stripePayment = NewStripePayment()
let paymentGatewayDIP = PaymentGatewayDIP(paymentMethod: stripePayment)
paymentGatewayDIP.pay(amount: 300)


