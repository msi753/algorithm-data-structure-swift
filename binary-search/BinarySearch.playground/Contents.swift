let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
numbers.firstIndex(of: 43)  //O(n)

// 선형탐색은 시간복잡도가 O(n)이지만, 값이 없을 경우 탐색이 무의미해진다
func linearSearch<T: Equatable>(_ a: [T], _ key: T) -> Int? {
    for i in 0 ..< a.count {
        if a[i] == key {
            return i
        }
    }
    return nil
}
linearSearch(numbers, 43)

// 이진탐색의 선행조건은 정렬이 된 상태여야한다는 것이다
// 재귀적인 방식
func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    } else {
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
        } else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex+1 ..< range.upperBound)
        } else {
            return midIndex
        }
    }
}

let binaryNumbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
binarySearch(binaryNumbers, key: 43, range: 0 ..< numbers.count)    //13

//반복문 방식
func binarySearch<T: Comparable>(_ a: [T], _ key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound-lowerBound)/2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}

binarySearch(binaryNumbers, 43) //13
