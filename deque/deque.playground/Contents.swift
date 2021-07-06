public struct Deque<T> {
    private var array: [T?]
    private var head: Int
    private var capacity: Int
    private let originalCapacity: Int
    
    public init(_ capacity: Int = 10) { //10개짜리 공간
        self.capacity = max(capacity, 1)
        originalCapacity = self.capacity
        array = [T?](repeating: nil, count: capacity)
        head = capacity //array 바깥쪽 맨 뒤
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeueBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }
    
    //원소가 용량 초과했을 때 조건 추가하기
    //head를 왼쪽으로 이동하면서 원소를 집어넣는다
    public mutating func enqueueFront(_ element: T) {
        if head == 0 {
            capacity *= 2
            let emptySpace = [T?](repeating: nil, count: capacity)
            array.insert(contentsOf: emptySpace, at: 0)
            head = capacity
        }
        
        head -= 1
        array[head] = element
    }
    
    //var numbers = [1, 2, 3, 4, 5]
    //numbers.insert(contentsOf: 100...103, at: 3)
    //print(numbers)
    // Prints "[1, 2, 3, 100, 101, 102, 103, 4, 5]"
    
    //원소가 있을 때
    //용량을 확장했지만 잘 쓰이지 않으면 체크해서 지운다
    //head에 있는 값을 초기화하고
    //head를 오른쪽으로 증가시킨다
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else {
            return nil
        }
        
        array[head] = nil
        head += 1
        
        if capacity >= originalCapacity && head >= capacity*2 { //처음 설정한 originalCapacity 보다 크고(확장했고), head가 용량의 두배보다 클 때
            let amountToRemove = capacity + capacity/2
            array.removeFirst(amountToRemove)
            head -= amountToRemove
            capacity /= 2
        }
        
        return element
    }
    
    //var bugs = ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]
    //bugs.removeFirst(3)
    //print(bugs)
    // Prints "["Damselfly", "Earwig"]"
    
    public func peekFront() -> T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
    
    public func peekBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.last!
        }
    }
}
