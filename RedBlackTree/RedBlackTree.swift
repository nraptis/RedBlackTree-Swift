//
//  RedBlackTree.swift
//  RedBlackTree
//
//  Created by Nick Raptis on 4/25/20.
//  Copyright © 2020 Nick Raptis. All rights reserved.
//

// This logic works, I guarantee it. It is a left-leaning red black tree,
// so there are no references to parent nodes. If you need to traverse
// a sorted list in O(N) time, then you can add parent nodes.
//
// I don't take credit for inventing this, I have simply tested and combined
// some other peoples' implementations until I finally arriving at a red/black
// tree that could pass all of the unit tests that I built.
//
// A warning to the wise, this performs SLOWER than a basic array unless
// you have a lot of elements. The real use case for it is popMin and popMax,
// so it is great for a home brewed priority queue (one or two sides) where
// elements are added or deleted at random intervals.
//
// Should you just use an array? Maybe. A red black tree will not give you
// a noticable speed up or slow down, until your elements / operations
// becomes a sufficiently high number. I would try the red black tree
// if you are building some type of fancy priority queue or combining
// data structures into a custom container class.

import UIKit

public class RedBlackTreeNode {
    
    init(_ value: Int) {
        self.value = value
    }
    
    init() {
        self.value = -1
    }
    
    func clone() -> RedBlackTreeNode {
        let result = RedBlackTreeNode(value)
        return result
    }
    
    internal var left: RedBlackTreeNode!
    internal var right: RedBlackTreeNode!
    
    public var value: Int
    
    //0 = red
    //1 = black
    internal var color: Int = 0
}

extension RedBlackTreeNode: Comparable {
    public static func < (lhs: RedBlackTreeNode, rhs: RedBlackTreeNode) -> Bool {
        return lhs.value < rhs.value
    }
    
    public static func == (lhs: RedBlackTreeNode, rhs: RedBlackTreeNode) -> Bool {
        return lhs.value == rhs.value
    }
}

extension RedBlackTreeNode: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

extension RedBlackTreeNode: CustomStringConvertible {
    public var description: String {
        return "{\(value)|\(color == 0 ? "R" : "B")}"
    }
}

public class RedBlackTree {
    
    internal var _root: RedBlackTreeNode!
    
    fileprivate var _count = 0
    var count: Int {
        return _count
    }
    
    required init() {
        
    }
}

extension RedBlackTree {
    
    public func contains(_ target: RedBlackTreeNode?) -> Bool {
        return _search(target) !== nil
    }
    
    fileprivate func _search(_ target: RedBlackTreeNode?) -> RedBlackTreeNode? {
        if let target = target {
            var node: RedBlackTreeNode! = _root
            while node != nil {
                if node == target {
                    return node
                } else if target < node {
                    node = node.left
                } else {
                    node = node.right
                }
            }
        }
        return nil
    }
}

extension RedBlackTree {
    
    internal func insert(_ node: RedBlackTreeNode) {
        _root = _insert(_root, node)
        _root.color = 1
        _count += 1
    }
    
    internal func _insert(_ root: RedBlackTreeNode?, _ node: RedBlackTreeNode) -> RedBlackTreeNode {
        
        if root === nil {
            node.color = 0
            return node
        }
        
        var root = root!
        
        if node < root {
            root.left = _insert(root.left, node)
        } else if node > root {
            root.right = _insert(root.right, node)
        }
        
        if _isRed(root.right) && _isBlack(root.left) {
            root = _rotateLeft(root)
        }
        
        if _isRed(root.left) && _isRed(root.left.left) {
            root = _rotateRight(root)
        }
        
        if _isRed(root.left) && _isRed(root.right) {
            _invertColors(root)
        }
        
        return root
    }
}

extension RedBlackTree {
    internal func remove(_ target: RedBlackTreeNode?) {
        if let node = _search(target) {
            if _isBlack(_root.left) && _isBlack(_root.right) { _root.color = 0 }
            _root = _remove(_root, node)
            if _root !== nil { _root.color = 1 }
            _count -= 1
        }
    }
    
    internal func _remove(_ root: RedBlackTreeNode, _ node: RedBlackTreeNode) -> RedBlackTreeNode? {
        var root = root
        if node < root {
            if _isBlack(root.left) && _isBlack(root.left.left) {
                root = _sendRedLeft(root)
            }
            root.left = _remove(root.left, node)
            
        } else {
            if _isRed(root.left) {
                root = _rotateRight(root)
            }
            
            if node === root && root.right === nil {
                return nil
            }
            
            if _isBlack(root.right) && _isBlack(root.right.left) {
                root = _sendRedRight(root)
            }
            
            if node === root {
                let transplant: RedBlackTreeNode! = _minElement(root.right)
                root.value = transplant.value
                root.right = _popMin(root.right)
                
            } else {
                root.right = _remove(root.right, node)
            }
        }
        return _balance(root)
    }
}

extension RedBlackTree {
    
    public func minElement() -> RedBlackTreeNode? {
        guard _root !== nil else {
            return nil
        }
        
        var result: RedBlackTreeNode! = _root
        while result.left !== nil {
            result = result.left
        }
        return result
    }
    
    public func popMin() -> RedBlackTreeNode? {
        
        guard _root !== nil else {
            return nil
        }
        
        let result: RedBlackTreeNode! = minElement()
        
        if _isBlack(_root.left) && _isBlack(_root.right) {
            _root.color = 0
        }

        _root = _popMin(_root)
        
        if _root !== nil {
            _root.color = 1
        }
        
        _count -= 1
        return result
    }
    
    fileprivate func _minElement(_ node: RedBlackTreeNode) -> RedBlackTreeNode? {
        var result: RedBlackTreeNode = node
        while result.left != nil {
            result = result.left
        }
        return result
    }
    
    fileprivate func _popMin(_ node: RedBlackTreeNode) -> RedBlackTreeNode? {
        var node: RedBlackTreeNode = node
        
        if node.left === nil {
            return nil
        }
        
        if _isBlack(node.left) && _isBlack(node.left.left) {
            node = _sendRedLeft(node)
        }
        
        node.left = _popMin(node.left)
        return _balance(node)
    }
}

extension RedBlackTree {
    
    public func maxElement() -> RedBlackTreeNode? {
        
        guard _root !== nil else {
            return nil
        }
        
        var result: RedBlackTreeNode! = _root
        while result.right !== nil {
            result = result.right
        }
        return result
    }
    
    public func popMax() -> RedBlackTreeNode? {
        
        guard _root !== nil else {
            return nil
        }
        
        let result: RedBlackTreeNode! = maxElement()
        
        if _isBlack(_root.left) && _isBlack(_root.right) {
            _root.color = 0
        }

        _root = _popMax(_root)
        
        if _root !== nil {
            _root.color = 1
        }
        
        _count -= 1
        return result
    }
    
    fileprivate func _maxElement(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        var result = node
        while result.right != nil {
            result = result.right!
        }
        return result
    }

    fileprivate func _popMax(_ node: RedBlackTreeNode) -> RedBlackTreeNode? {
        var node = node
        
        if _isRed(node.left) {
            node = _rotateRight(node)
        }

        if node.right === nil {
            return nil
        }

        if _isBlack(node.right) && _isBlack(node.right.left) {
            node = _sendRedRight(node)
        }
        
        node.right = _popMax(node.right)
        return _balance(node)
    }
}

extension RedBlackTree {
    fileprivate func _isRed(_ node: RedBlackTreeNode?) -> Bool {
        if let node = node {
            return node.color == 0
        }
        return false
    }
    fileprivate func _isBlack(_ node: RedBlackTreeNode?) -> Bool {
        if let node = node {
            return node.color == 1
        }
        return true
    }
    
    fileprivate func _invertColors(_ node: RedBlackTreeNode) {
        if node.color == 0 {
            node.color = 1
        } else {
            node.color = 0
        }
        
        if node.left.color == 0 {
            node.left.color = 1
        } else {
            node.left.color = 0
        }
        
        if node.right.color == 0 {
            node.right.color = 1
        } else {
            node.right.color = 0
        }
    }
}

extension RedBlackTree {
    
    fileprivate func _rotateRight(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        let transplant: RedBlackTreeNode! = node.left
        node.left = transplant.right
        transplant.right = node
        transplant.color = transplant.right.color
        transplant.right.color = 0
        return transplant
    }

    fileprivate func _rotateLeft(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        let transplant: RedBlackTreeNode! = node.right
        node.right = transplant.left
        transplant.left = node
        transplant.color = transplant.left.color
        transplant.left.color = 0
        return transplant
    }
    
    fileprivate func _sendRedLeft(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        var node = node
        _invertColors(node)
        if _isRed(node.right.left) {
            node.right = _rotateRight(node.right)
            node = _rotateLeft(node)
            _invertColors(node)
            
        }
        return node
    }
    
    fileprivate func _sendRedRight(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        var node = node
        _invertColors(node)
        if _isRed(node.left.left) {
            node = _rotateRight(node)
            _invertColors(node)
            
        }
        return node
    }
    
    fileprivate func _balance(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        var node = node
        if _isRed(node.right) {
            node = _rotateLeft(node)
        }
        if _isRed(node.left) && _isRed(node.left.left) {
            node = _rotateRight(node)
        }
        if _isRed(node.left) && _isRed(node.right) {
            _invertColors(node)
        }
        return node
    }
}
