let list = [10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26]

// swap이 계속 발생할 때
func insertionSort(_ array: [Int]) -> [Int] {
    var sortedArray = array
    for index in 1 ..< sortedArray.count {    //1부터
        var currendIndex = index
        while currendIndex>0 && array[currendIndex] < array[currendIndex - 1] {
            sortedArray.swapAt(currendIndex-1, currendIndex)
            currendIndex -= 1
        }
    }
    return sortedArray
}


insertionSort(list)

// shift하다가 해당 index에 값 복사할 때
func insertionSortByCopy(_ array: [Int]) -> [Int] {
    var sortedArray = array
    for index in 1 ..< sortedArray.count {
        var currentIndex = index
        let temp = sortedArray[currentIndex]
        while currentIndex > 0 && temp < sortedArray[currentIndex-1] {  // 비교값이 크면 shift해서 오른쪽으로 옮기고
            sortedArray[currentIndex] = sortedArray[currentIndex-1]
            currentIndex -= 1
        }
        sortedArray[currentIndex] = temp    // 작을 때 temp에 담긴 값을 그 위치에 복사한다
    }
    return sortedArray
}

insertionSortByCopy(list)


// Generic으로 만들 때
func insertionSortGeneric<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    
    guard array.count > 1 else { return array }
    
    var sortedArray = array
    for index in 1 ..< sortedArray.count {
        var currentIndex = index
        let temp = sortedArray[currentIndex]
        while currentIndex > 0, isOrderedBefore(temp, sortedArray[currentIndex-1]) {  // 비교값이 크면 shift해서 오른쪽으로 옮기고
            sortedArray[currentIndex] = sortedArray[currentIndex-1]
            currentIndex -= 1
        }
        sortedArray[currentIndex] = temp    // 작을 때 temp에 담긴 값을 그 위치에 복사한다
    }
    return sortedArray
}


let strings = ["b", "a", "d", "c", "e"]
insertionSortGeneric(strings, <)



// Comparable 프로토콜을 따를 때
func insertionSortComparable<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }

    var sortedArray = array
    for index in 1..<sortedArray.count {
        var currentIndex = index
        let temp = sortedArray[currentIndex]
        while currentIndex > 0, temp < sortedArray[currentIndex - 1] {
            sortedArray[currentIndex] = sortedArray[currentIndex - 1]
            currentIndex -= 1
        }
        sortedArray[currentIndex] = temp
    }
    return sortedArray
}


var newList = [1, 2, 3]

// O(n log n)
// 원본 변화
newList.sort()          //[1, 2, 3]
newList.sort(by: >)     //[3, 2, 1]

print(newList)          //[3, 2, 1]

// O(n log n)
// 원본 미변화
newList.sorted()        //[1, 2, 3]
print(newList)          //[3, 2, 1]

