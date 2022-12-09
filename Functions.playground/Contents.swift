import Foundation
import _Concurrency

// MARK: - Function Parameters

/// A basic function is one that takes no parameters and returns nothing, only performing a specific action.
/// For example, a function that simply prints a message to the console.
func greet() {
    print("Hello!")
}

greet()
// Prints Hello!



/// A function can also accept parameters and use them in its action.
func meet(person: String) {
    print("Nice to meet you, \(person)")
}

meet(person: "Pasquale")
// Prints Nice to meet you, Pasquale



/// Parameters can use two names.
/// The first one is then used when calling the function, and the second is used inside the function itself to refer to the parameter.
/// This can make code more readable.
func drive(to place: String) {
    // The second parameter name `place` is used inside the function.
    print("Beginning drive to \(place). Fasten your seatbelt!")
}

// The first parameter name `to` is used when calling the function.
drive(to: "Sorrento")
// Prints Beginning drive to Sorrento. Fasten your seatbelt!



/// The first parameter name can also be ignored by using an underscore `_` in place of the parameter name.
func rate(_ food: String) {
    print("\(food) is a 5 star meal!")
}

rate("Pasta")
// Prints Pasta is a 5 star meal!



/// Functions can also accept multiple parameters of different types.
func assign(task: String, to colleague: String, on date: Date) {
    print("\(task) has been assigned to \(colleague) on \(date.formatted(date: .complete, time: .omitted))")
}

assign(task: "Log-in View implementation", to: "Vincenzo", on: Date())
// Prints Log-in View implementation has been assigned to Vincenzo on Weekday, Month Date, Year





/// Variadic functions are functions that take any number of parameters of the same type.
/// Swift will then convert the parameters into an array that can be used inside the function.
/// Make a function variadic by adding `...` to the parameter type eg `Int...`
func listTeamMembers(_ members: String...) {
    for member in members {
        print("\(member) is a team member")
    }
}

listTeamMembers("Ahmed", "Fabio", "Salvatore", "Anja")
// Prints   Ahmed is a team member
//          Fabio is a team member
//          Salvatore is a team member
//          Anja is a team member

/// A good example of a variadic function is the `print()` function.
/// You can pass in as many parameters and they will all be printed out to the console with spaces between them.
print(5, 6, 7, 8, "Start dancing!")
// Prints 5 6 7 8 Start dancing!




// MARK: - Function Outputs

/// Functions can also return values from the action they perform.
/// This means that functions can be used to assign values to properties.
func product(a: Int, b: Int) -> Int {
    return a * b
}

// Assigning the return value to a property
let calculatedProduct = product(a: 5, b: 7)
print(calculatedProduct)
// Prints 35




// MARK: - Functions as parameters

/// Functions can also take other functions as parameters.
/// This is done using closures.
/// In Swift, closures are defined using the `() -> ()` notation, in which the first set of parentheses represents the parameters and the second set represents the output.
/// Empty parentheses mean that the function accepts no parameters and returns nothing.
/// For example, `(Int) -> (String)` defines a closure that accepts an `Int` as a parameter and returns a `String`.
/// In the above examples, the `product()` function would be denoted as `(Int, Int) -> (String)`.
/// Below, `description` is a closure that accepts an `Int` as a parameter and returns nothing.
func sum(a: Int, b: Int, description: (Int) -> ()) {
    let sum = a + b
    
    // We can then call the closure parameter and pass in the sum as the `Int` parameter for it.
    description(sum)
}



/// When calling functions that accept closures, the closure is appended using curly braces after the parameter list.
/// The `in` keyword is used here to show that the closure is receiving an `Int`, in this case `calculatedSum` from the function and can perform an action using it.
sum(a: 12, b: 11) { calculatedSum in
    print("The sum is \(calculatedSum)")
}
// Prints The sum is 23




// MARK: - Throwing functions

/// Functions can also throw an error in case the action they perform fail.
/// To define a throwing function, add the `throws` keyword after the list of parameters.
/// We can define a custom `Error` type to customize the type of error thrown using an `enum` that conforms to the Error protocol.
/// For example, consider a function that only accepts names that are part of a pre-defined list
/// If a name that isn't part of the list is passed to the function, the function could throw an error.

enum NameError: Error {
    case invalidName
}
func validate(name: String) throws {
    let allowedNames = ["Sonia", "Tanya", "Danilo", "Umberto", "Roberta"]
    
    // Checking for the name in the allowed list.
    guard allowedNames.contains(name)
    // Throwing an error if it doesn't exist in the allowed list.
    else { throw NameError.invalidName }
    
    print("\(name) is a valid name")
}



/// To call a function that can throw an error, use the `try` keyword.
/// To handle the error, place the function call inside a `do catch` block.
do {
    try validate(name: "Antonio")
} catch {
    // The catch keyword gives the error without explicitly checking for it.
    print(error)
}
// Prints invalidName

do {
    try validate(name: "Sonia")
} catch {
    // The catch keyword gives the error without explicitly checking for it.
    print(error)
}
// Prints Sonia is a valid name




// MARK: - Synchronous & Asynchronous Functions

/// All the functions thus far are synchronous functions in that they perform their action on one thread and dont exit until the action is complete.
/// Therefore, if the task is time consuming, the thread will be blocked until the action is complete.
/// For most cases, this is fine, for example in the above functions that are executed quickly.
/// Sometimes, the action performed may take some time to complete, eg a network request.
/// To avoid blocking the thread, the action may be performed in the background, freeing up the thread to perform other work.
/// When the action is complete in the background, Swift notifies that the action is complete.

/// To create an asynchronous function, add the `async` keyword after the parameters list.
func fetchStudentList() async -> String {
    // Perform a network request
    return "The student list has been fetched"
}

/// To call an asynchronous function, use the `await` keyword.
/// If the async function is running in a synchronous context, eg in this playground, wrap the async call in a `Task`.
Task {
    let status = await fetchStudentList()
    print(status)
}
// Prints The student list has been fetched




/// Another way of handling asynchronous functions is by using closure parameters as discussed above.
/// In such a case, the closure provided is called after the action is complete.
/// Use the `@escaping` keyword
func fetchResource(_ completionHandler: @escaping () -> ()) {
    // Create a url
    let url = URL(string: "https://dogapi.dog/api/v2/facts")!
    
    // Make a request,
    URLSession.shared.dataTask(with: url) { data, response, error in
        completionHandler()
    }
    .resume()
    
    // The function exits
}

fetchResource {
    print("The resource has been fetched")
}
// After some time, prints The resource has been fetched
