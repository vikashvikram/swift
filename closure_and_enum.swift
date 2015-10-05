func sayHello(personName: String, _ alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return "Hello again \(personName)"
    } else {
        return "Hello \(personName)"
    }
}

print(sayHello("Tim", true))

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

// var reversed = names.sort(backwards)

//var reversed = names.sort( { (s1: String, s2: String) -> Bool in return s1 > s2 } )

//var reversed = names.sort( { s1, s2 in return s1 > s2 } )

//var reversed = names.sort( { s1, s2 in s1 > s2 } )

//var reversed = names.sort( { $0 > $1 } )

//var reversed = names.sort() { $0 > $1 }

//var reversed = names.sort { $0 > $1 }

var reversed = names.sort(>)

print(reversed)

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

var incrementer = makeIncrementer(forIncrement: 2)

print(incrementer())
print(incrementer())

enum CompassPoint {
    case North
    case South
    case East
    case West
}

var directionToHead = CompassPoint.West

directionToHead = .South

switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)

switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

enum NewPlanet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let earthsOrder = NewPlanet.Earth.rawValue

print(earthsOrder)

enum NewCompassPoint: String {
    case North, South, East, West
}

print(NewCompassPoint.West.rawValue)

let positionToFind = 9
if let somePlanet = NewPlanet(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
