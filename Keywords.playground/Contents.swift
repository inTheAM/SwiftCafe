import Foundation

// MARK: - Inheritance

/// In general, when we create classes, we can use inheritance to create subclasses.
/// In the example below, `Table` inherits from `Furniture`, therefore, it gains access to all the capabilities
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
    // No implementation needed
}

// Inherited implementation
let diningTable = Table(numberOflegs: 4)

diningTable.printNumberOfLegs()
// Prints "Number of legs: 4"

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
/// For example, below, `Vehicle` can be inherited from, but the `start()` method cannot be overriden.
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
///
/// Using the `final` keyword also improves performance when the code is run.
/// Let's look at it from the system's perspective;
/// If you have an instance of a class and access for example a function in the class,
/// eg in the above example, `Chair` inherits from `Furniture` and overrides the `printNumberOfLegs` method.
/// When the code is run, the system has to:
/// - Check if the class being used has been inherited from, or if it is inheriting from another class,
/// - Check for any property or method of the class that has been overriden and the number overrides,
/// - Check which implementations are available to the class being used,
/// - Determine the correct implementation to use in this case then use that correct implementation.
/// This process is called `DynamicDispatch`
///
/// This process takes more time and power, and the efficiency of the code reduces.
/// Using final eliminates this process and moves the checks to the compiler, which means when the code is run, the checks are already done,
/// so the system can directly use the correct implementation without worrying if there exist any overrides.
/// This is called `StaticDispatch`.





// MARK: - Access control

/// Access control means setting up how the properties, methods, classes, structs in our code are accessed within the project.
///
/// Use the `private` keyword to restrict access to a property or method to only within that struct or class.

struct Student {
    
    // This property will only be accessible within this struct ie within the opening and closing braces.
    // Extensions will not have any access.
    private var id = 12345
}

var antonio = Student()

// Attempting to access or modify the id of antonio throws an error.

// print(antonio.id)
// antonio.id = 54321




/// In some cases, you may want to be able to access the property, but not to modify it.
/// In such a case, use `private(set)` to restrict the property to be readable from outside the struct/class but only modifiable within the struct/class.

struct AcademyStudent {
    private(set) var name: String
}

var student = AcademyStudent(name: "Antonia")

print(student.name)
// Prints "Antonia"

// Trying to modify the name causes an error.
// student.name = "John"

/// If we have more than one struct/class in one file, sometimes we would wish to allow the property to be accessed within the same file.
/// In this case, use `fileprivate` to restrict access to only within that file.

struct Car {
    fileprivate var model = "Toyota"
}

var car = Car()

// model can be accessed within the same file.
print(car.model)
// Prints "Toyota

// model can be modified within the same file.
car.model = "Jeep"




// MARK: Access Control - Extended

/// There exist other methods of access control.
/// Sometimes, a project consists of multiple targets/modules.
/// In this case, one module may be imported into another, eg `import MODULE1` in a file in MODULE2
///
/// Some classes/structs/properties/methods in one module may be needed only inside that module, while we may want to expose
/// some of them to other modules that `import` it.
/// Three keywords are used in this case: `internal`, `public` and `open`
///
/// `internal` means that the class/struct/property/method will only be accessible within the same module.
/// Other modules that `import` it will not have access to that implementation.
///
/// # IMPORTANT: By default, all declarations made without a specified level of access control are marked `internal`.

// MODULE1
internal struct Fruit {
    internal var name = "Apple"
}

// MODULE2
// import Module1
// Fruit will be inaccessible from here.


/// If we would like the modules that `import`Module A to be able to access, but NOT modify or override the implentation,
/// the `public` keyword is used.

// MODULE1
// Access allowed, Inheritance and overriding only allowed within MODULE A but NOT allowed for other modules.
public class Cat: ObservableObject {
    public var breed = "Savannah"
    internal var age = 2
    
    public func printDetails() {
        print("Guppi is a", breed, "aged", age)
        // Prints "Guppi is a Savannah aged 2"
    }
}

// MODULE 2
// Cat will be accessible from here.
let guppi = Cat()

// breed is accessible
print("Guppi is a", guppi.breed)
// Prints "Guppi is a Savannah"

// age is not accessible
// print(guppi.age)

// Inheritance and overriding not allowed.
// This causes an error:
// class Kitten: Cat {
//     override func printDetails() {
//         print("Guppi is a", breed)
//     }
// }


/// If we would like to allow inheritance and overriding from MODULE1 in MODULE2 the `open` keyword is used.
///
// MODULE1
// Access allowed, Inheritance and overriding only allowed for open methods.
open class Dog {
    public var breed = "Bulldog"
    public var name = "Biter"
    internal var age = 3
    
    open func printDetails() {
        print(name, "is a", breed, "aged", age)
        // Prints "Biter is a Bulldog aged 3"
    }
}

// MODULE 2
// Dog is accessible.
let dog = Dog()

// breed and name are accessible.
print("the dog is a ", dog.breed)
print("The dog is called", dog.name)

// age is not accessible
// print(dog.age)

// Inheritance and overriding open methods is allowed.
class Puppy: Dog {
    override func printDetails() {
        print(name, "is a", breed)
        // Prints "Biter is a Bulldog"
    }
}
