//func quicksort<T: Comparable>(_ a: [T]) -> [T] {
//  guard a.count > 1 else { return a }
//
//  let pivot = a[a.count/2]
//  let less = a.filter { $0 < pivot }
//  let equal = a.filter { $0 == pivot }
//  let greater = a.filter { $0 > pivot }
//
//  return quicksort(less) + equal + quicksort(greater)
//}
//
//let list = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
//quicksort(list)



func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    
    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            a.swapAt(i, j)
            i += 1
        }
    }
    
    a.swapAt(i, high)
    return i
}

var list = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]

func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionLomuto(&a, low: low, high: high)
        quicksortLomuto(&a, low: low, high: p-1)
        quicksortLomuto(&a, low: p+1, high: high)
    }
}

quicksortLomuto(&list, low: 0, high: list.count-1)
