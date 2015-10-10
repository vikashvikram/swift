// weak to avoid strong reference cycle
//use when both properties can be nil
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
// prints "John Appleseed is being initialized"


reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil

reference3 = nil
// prints "John Appleseed is being deinitialized"

var john: Person?
var unit4A: Apartment?

//The strong reference cycle
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil // prints "John Appleseed is being deinitialized"
unit4A = nil // prints "unit4A is being deinitialized"

//unknowned to avoid strong reference cycle
//use when one property can be nil but other can never be nil
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var vik: Customer?

vik = Customer(name: "Vikram")
vik!.card = CreditCard(number: 1234_5678_9012_3456, customer: vik!)

vik = nil

// when both properties cannot be nil once initialized
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// prints "Canada's capital city is called Ottawa"


//closures can create strong reference cycle
// here two properties are not two class instances but one class instance and one closure
// closures are also reference types
class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// prints "<h1>some default text</h1>"

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// prints "<p>hello, world</p>"

//Unfortunately, the HTMLElement class, as written above, 
//creates a strong reference cycle between an HTMLElement instance and 
//the closure used for its default asHTML value


//The instance’s asHTML property holds a strong reference to its closure. 
//However, because the closure refers to self within its body (as a way to reference self.name and self.text), 
//the closure captures self, which means that it holds a strong reference back to the HTMLElement instance.

class NewHTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

var paragraph1: NewHTMLElement? = NewHTMLElement(name: "p", text: "hello, world")
print(paragraph1!.asHTML())
// prints "<p>hello, world</p>"

paragraph1 = nil
// prints "p is being deinitialized"