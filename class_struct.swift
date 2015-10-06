struct Resolution {
    var width = 0;
    var height = 0;
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someVideoMode = VideoMode()

print("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280

print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

let vga = Resolution(width: 640, height: 480)

print("The width of vga is \(vga.width)")

//all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries 
//are value types, and are implemented as structures behind the scenes.
//NSString, NSArray, and NSDictionary in Foundation are implemented as classes, not structures.
//NSString, NSArray, and NSDictionary instances are always assigned and passed around as a reference to
//an existing instance, rather than as a copy.

// All structures and enumerations are value types in Swift.

let hd = Resolution(width: 1920, height: 1080)

var cinema = hd

cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}
// prints "The remembered direction is still .West"

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// prints "The frameRate property of tenEighty is now 30.0"


if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."

//A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C,
//but is not a direct pointer to an address in memory, and does not require you to write an asterisk (*)
//to indicate that you are creating a reference.
//Instead, these references are defined like any other constant or variable in Swift.

