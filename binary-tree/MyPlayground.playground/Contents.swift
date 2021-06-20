//노드에 값이 있거나, 왼쪽이나 오른쪽 노드가 있거나 없거나
//제한적인 상황만 필요하기 때문에 enum이 적절하다(값 타입)

//Recursive enum 'BinaryTree<T>' is not marked 'indirect'
//enum(값타입)은 메모리에 할당될 때 크키가 정해져있어야 하지만 recusive한 경우 그 크기가 정해져있지 않다
//포인터를 사용해 변수에 액세스하는 것과 같은 indirection(간접성)을 사용하기 위해 indirect 키워드를 사용한다
indirect enum BinaryTree<T: Comparable> {   // new Value와 old Value를 비교해야하기 때문에 Comparable 추가
    case empty
    case node(BinaryTree, T, BinaryTree)    //recursive
    
    // 전체 노드 개수 세기
    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
    
    // MARK: - 삽입
    // 값타입이 바뀔 땐 mutating 키워드 써주기
//    mutating func naiveInsert(newValue: T) {
//        // 노드가 비어있으면 새로운 노드 생성하기
//        guard case .node(var left, let value, var right) = self else {
//            self = .node(.empty, newValue, .empty)
//            return
//        }
//        if newValue < value {
//            left.naiveInsert(newValue: newValue)
//        } else {
//            right.naiveInsert(newValue: newValue)
//        }
//    }
    
    // enum으로 BinaryTree가 선언되어 있어 Copy On Write가 발생하기 때문에 (트리 복제가 계속 일어남) 새로운 값과 이전 값 연결해주는 삽입 -> O(n)
    // class로 선언된 경우 Copy On Write가 발생하지 않아서 시간복잡도는 일반적으로 O(logN)이 된다.
    private func newTreeWithInsertedValue(newValue: T) -> BinaryTree {
        switch self {
        // 트리가 비어있으면 새로운 노드를 생성하고
        case .empty:
            return .node(.empty, newValue, .empty)
        // 노드가 있으면 왼쪽이나 오른쪽의 자식 노드를 생성한다
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.newTreeWithInsertedValue(newValue: newValue), value, right)
            } else {
                return .node(left, value, right.newTreeWithInsertedValue(newValue: newValue))
            }
        }
        
    }
    
    mutating func insert(newValue: T) {
        self = newTreeWithInsertedValue(newValue: newValue)
    }
    
    // MARK: - Traversal algorithms 순회 O(n)
    //n은 노드의 개수
    //In-order Traversal 중위순회 (노드를 오름차순으로 정렬)
    func traverseInOrder(process: (T) -> ()) {
        switch self {
        // 노드가 비어있으면 멈춘다
        case .empty:
            return
        // 노드가 비어있지 않으면,
        case let .node(left, value, right):
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }
    
    //전위순회
    func traversePreOrder(process: (T) -> ()) {
        switch self {
        // 노드가 비어있으면 멈춘다
        case .empty:
            return
        // 노드가 비어있지 않으면,
        case let .node(left, value, right):
            process(value)
            left.traversePreOrder(process: process)
            right.traversePreOrder(process: process)
        }
    }
    
    //후위순회
    func traversePostOrder(process: (T) -> ()) {
        switch self {
        // 노드가 비어있으면 멈춘다
        case .empty:
            return
        // 노드가 비어있지 않으면,
        case let .node(left, value, right):
            left.traversePostOrder(process: process)
            right.traversePostOrder(process: process)
            process(value)
        }
    }
    
    //MARK:- searching
    func search(searchValue: T) -> BinaryTree? {
        switch self {
        case .empty:
            return nil
        case let .node(left, value, right):
            if searchValue == value {
                return self
            }
            if searchValue < value {
                return left.search(searchValue: searchValue)
            } else {
                return right.search(searchValue: searchValue)
            }
        }
    }
}

// leaf nodes
//let node5 = BinaryTree.node(.empty, "5", .empty)
//let nodeA = BinaryTree.node(.empty, "a", .empty)
//let node10 = BinaryTree.node(.empty, "10", .empty)
//let node4 = BinaryTree.node(.empty, "4", .empty)
//let node3 = BinaryTree.node(.empty, "3", .empty)
//let nodeB = BinaryTree.node(.empty, "b", .empty)
//
//// intermediate nodes on the left 루트 왼쪽
//let Aminus10 = BinaryTree.node(nodeA, "-", node10)
//let timeLeft = BinaryTree.node(node5, "*", Aminus10)
//
//// intermediate nodes on the right 루트 오른쪽
//let minus4 = BinaryTree.node(.empty, "-", node4)
//let divide3andB = BinaryTree.node(node3, "/", nodeB)
//let timesRight = BinaryTree.node(minus4, "*", divide3andB)
//
//// root node
//let tree = BinaryTree.node(timeLeft, "+", timesRight)
//print(tree.count)   //12 (전체 노드의 개수)

extension BinaryTree: CustomStringConvertible {
    var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [" + left.description + "], right = [" + right.description + "]"
        case .empty:
            return ""
        }
    }
}

// Copy on Write 성질 때문에
// 새로운 값이 이전 값과 연결되지 않기 때문에, 새로운 값이 업데이트되지 않는다.
var binaryTree: BinaryTree<Int> = .empty
binaryTree.insert(newValue: 5)
binaryTree.insert(newValue: 7)
binaryTree.insert(newValue: 9)

print(binaryTree.description)
//"value: 5, left = [], right = [value: 7, left = [], right = [value: 9, left = [], right = []]]\n"

var tree: BinaryTree<Int> = .empty
tree.insert(newValue: 7)
tree.insert(newValue: 10)
tree.insert(newValue: 2)
tree.insert(newValue: 1)
tree.insert(newValue: 5)
tree.insert(newValue: 9)

tree.traverseInOrder { print($0) }   // 1 2 5 7 9 10
tree.traversePreOrder { print($0) }  // 7 2 1 5 10 9
tree.traversePostOrder { print($0) } // 1 5 2 9 10 7
tree.search(searchValue: 5) //value: 5, left = [], right = []

