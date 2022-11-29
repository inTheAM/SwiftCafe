import Foundation

// MARK: - Inheritance

/// In general, when we create classes, we can use inheritance to create subclasses.
/// In the example below, the `Table` class inherits from `Furniture`, therefore, it gains access to all the capabilities
/// defined in the parent class (`Furniture`).

class Furniture {
    let numberOfLegs: Int
    
    init(numberOflegs: Int) {
        self.numberOfLegs = numberOflegs
    }
    
    func printNumberOfLegs() {
        print("Number of legs:", numberOfLegs)
    }
}

/// `Table` inherits from `Furniture`.
class Table: Furniture {
    
}

// Inherited capability
let diningTable = Table(numberOflegs: 4)

diningTable.printNumberOfLegs()
// Prints (4)

/// We can also override the properties and functions of the parent class `Furniture`, to customize the specific
/// behavior of the subclass `Chair`.
class Chair: Furniture {
    
    override func printNumberOfLegs() {
        print("A chair has 4 legs. Anything else is an impostor.")
    }
}


/// Sometimes, we do not want this kind of behavior.
/// In some cases, the implementations of the classes we create are not supposed to be changed.
/// To prevent a class from being inherited from, use the `final` keyword.

final class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func printName() {
        print("This person is ", name)
    }
}

// If we now try to inherit from this class, the compiler will throw an error.
// Uncomment the code below to view the error.

//class Student: Person {
//
//}

/// This can also be applied to individual properties and functions in the class.
/// This allows for inheritance with restrictions.
/// For example, below, `Vehicle` can be inherited from.
class Vehicle {
    let numberOfWheels: Int
    
    init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
    }
    
    final func start() {
        print("The vehicle is starting.")
    }
}

/// We can inherit from `Vehicle`.
class Truck: Vehicle {
    
    // But trying to override the start function causes an error.
    
//    override func start() {
//        print("The truck is starting.")
//    }
}


let cyberTruck = Truck(numberOfWheels: 4)

cyberTruck.start()
// Prints "The vehicle is starting."


/// #  Performance benefits of using `final`:
/// Using the `final` keyword also improves performance when the code is run.
/// Let's look at it from the system's perspective;
/// If you have an instance of a class and access for example a function in the class,
/// eg in the above example, `Chair` inherits from `Furniture` and overrides the `printNumberOfLegs` method.
/// When the code is run, the system has to:
/// - Check if the class being used has been inherited from, or if it is inheriting from another class,
/// - Check for any property or method of the class that has been overriden and the number overrides,
/// - Check which implementations are available to the class being used,
/// - Determine the correct implementation to use in this case then use that correct implementation.
///
/// This process takes more time and power, and the efficiency of the code reduces.
/// Using final eliminates this process and moves the checks to the compiler, which means when the code is run, the checks are already done,
/// so the system can directly use the correct implementation without worrying if there exist any overrides.


