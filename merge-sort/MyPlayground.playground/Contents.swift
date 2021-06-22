let array = [7, 2, 6, 3, 9]

func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    //split
    guard array.count>1 else { return array }   //recursion, 원소가 1개 남으면 종료한다
    let middleIndex = array.count/2
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    
    return merge(leftArray, rightArray)
}

// 이렇게 구현하게 되면 left와 right가 sorted한 상태로 들어와야 한다
//func merge(_ left: [Int], _ right: [Int]) -> [Int] {
//  let combinedArray = left + right
//  return combinedArray.sorted(<)
//}

//merge
func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedArray: [T] = []
    
    //미리 비교해서 정렬하기
    while leftIndex < left.count && rightIndex < right.count {
      let leftElement = left[leftIndex]
      let rightElement = right[rightIndex]

      if leftElement < rightElement { // 2
        orderedArray.append(leftElement)
        leftIndex += 1
      } else if leftElement > rightElement { // 3
        orderedArray.append(rightElement)
        rightIndex += 1
      } else { // 4
        orderedArray.append(leftElement)
        leftIndex += 1
        orderedArray.append(rightElement)
        rightIndex += 1
      }
    }

    while leftIndex < left.count {
        orderedArray.append(left[leftIndex])
        leftIndex += 1
    }

    while rightIndex < right.count {
        orderedArray.append(right[rightIndex])
        rightIndex += 1
    }
    
    return orderedArray
}
mergeSort(array)
