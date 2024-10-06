import UIKit

// MARK: - Interface Segregation Principle (ISP)
// Do not force any client to implement an interface is irrelevant to them.


protocol GestureProtocol {
    func handleGesture()
    func handleLongGesture()
    func handleDoubleTapGesture()
}
// MARK: - The problem.
// now any button can confirm on this protocol and use the functions.
struct SuperButton: GestureProtocol {
    func handleGesture() {
        print("Handling gesture")
    }
    
    func handleLongGesture() {
        print("Handling long gesture")
    }
    
    func handleDoubleTapGesture() {
        
    }
}
// But if we have an button and this button need to take handleGesture func only, by confirm it to the GestureProtocol it will force him to use all functions and that not acceptable.
struct GestureHandler: GestureProtocol {
    func handleGesture() {
        print("Handling gesture")
    }
    
    func handleLongGesture() {
        print("Handling long gesture")
    }
    
    func handleDoubleTapGesture() {
        
    }
}

// MARK: - Solution using (ISP).
// create a protocol for each function.

protocol GestureTapProtocol {
    func handleGesture()
}
protocol LongGestureTapProtocol {
    func handleLongTapGesture()
}

protocol DoubleTapGestureProtocol {
    func handleDoubleTapGesture()
}

struct NewSuperButton: GestureTapProtocol,
                       LongGestureTapProtocol,
                       DoubleTapGestureProtocol {
    func handleGesture() {
        print("Handling gesture")
    }
    
    func handleLongTapGesture() {
        print("Handling long gesture")
    }
    
    func handleDoubleTapGesture() {
        
    }
}

struct DoubleTapHButton: DoubleTapGestureProtocol {
    func handleDoubleTapGesture() {}
}
// now if you want use all you can, also if you want use only one you can also.
