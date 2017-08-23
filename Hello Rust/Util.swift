public func dotProduct(_ vector1: [Double], vector2: [Double]) -> Double {

    return zip(vector1, vector2)
        .lazy
        .map(*)
        .reduce(0, +)
}

public func generateRandomArrayOfSize(_ size: Int) -> [Double] {
    var size = size
    var result: [Double] = []
    while size > 0 {
        result.append(randomDoubleBetween(0.0, andUpper: 100.0))
        size = size - 1
    }
    return result
}

public func randomDoubleBetween(_ lower: Double, andUpper upper: Double) -> Double {
    let arc4randomMax: Double = 0x100000000
    let result = (Double(arc4random()) / arc4randomMax) * (upper - lower) + lower
    return result
}
