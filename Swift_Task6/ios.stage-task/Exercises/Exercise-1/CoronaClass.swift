import Foundation

class CoronaClass {
    
    struct Desk {
        let index: Int
        let leftDistance: Int
        let rightDistance: Int
    }
    
    var seats: [Int] {
        get {
            occupiedSeats.sorted()
        }
    }
    var occupiedSeats = [Int]()
    let n: Int
    
    init(n: Int) {
        self.n = n
    }
    
    func closest(array: Array<Int>, x: Int) -> Int? {
        return array.first(where: { $0 > x })
    }
    
    func seat() -> Int {
        
        if !occupiedSeats.contains(0) {
            occupiedSeats.append(0)
            return 0
        }
        
        var tempDesks = [Desk]()
        for item in 0..<n where seats.contains(item) {
            var desksElementRange = [Desk]()
            if let innerLoopEnd = closest(array: seats, x: item) {
                for nextItem in item+1..<innerLoopEnd {
                    let distanceToLeft = seats.distance(from: item, to: nextItem) - 1
                    let distanceToRight = seats.distance(from: nextItem, to: closest(array: seats, x: nextItem)!) - 1
                    desksElementRange.append(Desk(index: nextItem, leftDistance: distanceToLeft, rightDistance: distanceToRight))
                }
            } else if !seats.contains(n-1) {
                desksElementRange.append(Desk(index: n-1, leftDistance: n-1 - item , rightDistance: -1))
            }
            
            desksElementRange = desksElementRange.sorted{abs($0.leftDistance - $0.rightDistance) < abs($1.leftDistance - $1.rightDistance)}
            
            if let tempDesk = desksElementRange.first {
                tempDesks.append(tempDesk)
            }
        }
        
        if let value = tempDesks.max(by: { $0.leftDistance < $1.leftDistance }) {
            occupiedSeats.append(value.index)
            return value.index
        }
        return 0
    }
    
    func leave(_ p: Int) {
        if let index = occupiedSeats.firstIndex(of: p) {
            occupiedSeats.remove(at: index)
        }
    }
    
}
