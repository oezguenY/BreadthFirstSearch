import Foundation


class Node<T> {
    var value: T
    var left: Node<T>?
    var right: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct BinarySearchTree<T: Comparable> {
    var root: Node<T>? = nil
    
    mutating func insert(value: T) {
        
        var currentNode = root
        let newNode = Node(value: value)
        
        if currentNode == nil {
            root = newNode
            return
        } else {
            while true {
                guard value != currentNode!.value else { break }
                if value < currentNode!.value {
                    if currentNode?.left == nil {
                        currentNode?.left = newNode
                        break
                    } else {
                        currentNode = currentNode?.left
                    }
                } else if value > currentNode!.value {
                    if currentNode?.right == nil {
                        currentNode?.right = newNode
                        break
                    } else {
                        currentNode = currentNode?.right
                    }
                }
            }
        }
    }
    
    func findNode(_ value: T) -> Bool {
        var currentNode = root
        
        if value == currentNode?.value {
            return true
        } else {
            while true {
                if value < currentNode!.value {
                    currentNode = currentNode?.left
                    if value == currentNode?.value {
                        return true
                    }
                    guard currentNode?.left != nil else {
                        return false
                    }
                        
                } else if value > currentNode!.value {
                    currentNode = currentNode?.right
                    if value == currentNode?.value {
                        return true
                    }
                    guard currentNode?.right != nil else {
                        return false
                    }
                }
            }
        }
    }
    
    func bfs() -> [Node<T>?] {
        var node = self.root // 10
        var data = [Node<T>?]()
        var queue = [Node<T>?]()
        queue.append(node) // [10]
        
        while !queue.isEmpty {
            // FIFO Approach; The first element in the array is removed
            node = queue.removeFirst() // 10, 6, 15, 3, 8
            data.append(node) // [10], [10,6], [10,6,15], [10,6,15,3],                         [10,6,15,3,8], [10,6,15,3,8,20]
            if let leftNode = node?.left {
                queue.append(leftNode) // [6], [15,3]
            }
            if let rightNode = node?.right {
                queue.append(rightNode) // [6,15], [15,3,8], [3,8,20]
            }
        }
        // check whether the sequence of the array is correct
        let nodeValues = data.compactMap { $0?.value }
        print(nodeValues)
        return data
    }
}

/*
 We are building the following tree:
 
 
 Sequence                 Tree
     1 ->                  10
     2 ->         6                  15
     3 ->   3           8                   20
 
 
 So, the printed out array has to be:
->         [10,6,15,3,8,20]
 
 We are traversing the tree first horizontally, before we go vertically
 
 */


var bst = BinarySearchTree<Int>()
bst.insert(value: 10)
bst.insert(value: 6)
bst.insert(value: 8)
bst.insert(value: 3)
bst.insert(value: 15)
bst.insert(value: 20)
bst.bfs()
