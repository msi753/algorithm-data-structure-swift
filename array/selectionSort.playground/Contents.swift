public func selectionSort<T: Comparable>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else { return array }
    
    var a = array
    for x in 0..<a.count-1 {
        var lowest = x
        for y in x+1..<a.count {
            if isOrderedBefore(a[y], a[lowest]) {
                lowest = y
            }
        }
        
        if x != lowest {
            a.swapAt(x, lowest)
        }
    }
    
    return a
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
selectionSort(list, <)
