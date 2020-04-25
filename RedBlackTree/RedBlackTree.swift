//
//  RedBlackTree.swift
//  RedBlackTree
//
//  Created by Nick Raptis on 4/25/20.
//  Copyright © 2020 Nick Raptis. All rights reserved.
//

// This logic works, I guarantee it.
//
// I don't take credit for inventing this, I have simply tested and combined
// some other peoples' implementations until I finally arriving at a red/black
// tree that could pass all of the unit tests that I built.

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
    fileprivate func isRed(_ node: RedBlackTreeNode?) -> Bool {
        if let node = node {
            return node.color == 0
        }
        return false
    }
    fileprivate func isBlack(_ node: RedBlackTreeNode?) -> Bool {
        if let node = node {
            return node.color == 1
        }
        return true
    }
    
    fileprivate func invertColors(_ node: RedBlackTreeNode!) {
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
    
    fileprivate func rotateRight(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        let transplant: RedBlackTreeNode! = node.left
        node.left = transplant.right
        transplant.right = node
        transplant.color = transplant.right.color
        transplant.right.color = 0
        return transplant
    }

    fileprivate func rotateLeft(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        let transplant: RedBlackTreeNode! = node.right
        node.right = transplant.left
        transplant.left = node
        transplant.color = transplant.left.color
        transplant.left.color = 0
        return transplant
    }
    
    fileprivate func sendRedLeft(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        var node: RedBlackTreeNode! = node
        invertColors(node)
        if isRed(node.right.left) {
            node.right = rotateRight(node.right)
            node = rotateLeft(node)
            invertColors(node)
            
        }
        return node
    }
    
    fileprivate func sendRedRight(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        var node: RedBlackTreeNode! = node
        invertColors(node)
        if isRed(node.left.left) {
            node = rotateRight(node)
            invertColors(node)
            
        }
        return node
    }
    
    fileprivate func rebalance(_ node: RedBlackTreeNode) -> RedBlackTreeNode {
        var node: RedBlackTreeNode! = node
        if isRed(node.right) {
            node = rotateLeft(node)
        }
        if isRed(node.left) && isRed(node.left.left) {
            node = rotateRight(node)
        }
        if isRed(node.left) && isRed(node.right) {
            invertColors(node)
        }
        return node
    }
}

extension RedBlackTree {
    
    func search(_ target: RedBlackTreeNode?) -> Bool {
        return searchInternal(target) !== nil
    }
    
    func contains(_ target: RedBlackTreeNode?) -> Bool {
        return searchInternal(target) !== nil
    }
    
    func exists(_ target: RedBlackTreeNode?) -> Bool {
        return searchInternal(target) !== nil
    }
    
    fileprivate func searchInternal(_ target: RedBlackTreeNode?) -> RedBlackTreeNode! {
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
        _root = insertInternal(_root, node)
        _root.color = 1
        _count += 1
    }
    
    internal func insertInternal(_ root: RedBlackTreeNode!, _ node: RedBlackTreeNode!) -> RedBlackTreeNode! {
        
        if root === nil {
            node.color = 0
            return node
        }
        
        var root: RedBlackTreeNode! = root
        
        if node < root {
            root.left = insertInternal(root.left, node)
        } else if node > root {
            root.right = insertInternal(root.right, node)
        }
        
        if isRed(root.right) && isBlack(root.left) {
            root = rotateLeft(root)
        }
        
        if isRed(root.left) && isRed(root.left.left) {
            root = rotateRight(root)
        }
        
        if isRed(root.left) && isRed(root.right) {
            invertColors(root)
        }
        
        return root
    }
}

extension RedBlackTree {
    internal func remove(_ target: RedBlackTreeNode?) {
        if let node = searchInternal(target) {
            if isBlack(_root.left) && isBlack(_root.right) { _root.color = 0 }
            _root = removeInternal(_root, node)
            if _root !== nil { _root.color = 1 }
            _count -= 1
        }
    }
    
    internal func removeInternal(_ root: RedBlackTreeNode!, _ node: RedBlackTreeNode!) -> RedBlackTreeNode! {
        
        var root: RedBlackTreeNode! = root
        
        if node < root {
            if isBlack(root.left) && isBlack(root.left.left) {
                root = sendRedLeft(root)
            }
            root.left = removeInternal(root.left, node)
            
        } else {
            if isRed(root.left) {
                root = rotateRight(root)
            }
            
            if node === root && root.right === nil {
                return nil
            }
            
            if isBlack(root.right) && isBlack(root.right.left) {
                root = sendRedRight(root)
            }
            
            if node === root {
                let transplant: RedBlackTreeNode! = minElement(root.right)
                root.value = transplant.value
                root.right = popMinInternal(root.right)
                
            } else {
                root.right = removeInternal(root.right, node)
            }
        }
        return rebalance(root)
    }
}

extension RedBlackTree {
    
    func minElement() -> RedBlackTreeNode? {
        guard _root !== nil else {
            return nil
        }
        
        var result: RedBlackTreeNode! = _root
        while result.left !== nil {
            result = result.left
        }
        return result
    }
    
    fileprivate func minElement(_ node: RedBlackTreeNode!) -> RedBlackTreeNode! {
        var result: RedBlackTreeNode! = node
        while result.left != nil {
            result = result.left
        }
        return result
    }
    
    func popMin() -> RedBlackTreeNode? {
        
        guard _root !== nil else {
            return nil
        }
        
        let result: RedBlackTreeNode! = minElement()
        
        if isBlack(_root.left) && isBlack(_root.right) {
            _root.color = 0
        }

        _root = popMinInternal(_root)
        
        if _root !== nil {
            _root.color = 1
        }
        
        _count -= 1
        return result
    }
    
    internal func popMinInternal(_ node: RedBlackTreeNode) -> RedBlackTreeNode! {
        var node: RedBlackTreeNode! = node
        
        if node.left === nil {
            return nil
        }
        
        if isBlack(node.left) && isBlack(node.left.left) {
            node = sendRedLeft(node)
        }
        
        node.left = popMinInternal(node.left)
        return rebalance(node)
    }
    
    func maxElement() -> RedBlackTreeNode? {
        
        guard _root !== nil else {
            return nil
        }
        
        var result: RedBlackTreeNode! = _root
        while result.right !== nil {
            result = result.right
        }
        return result
    }

    func popMax() -> RedBlackTreeNode? {
        
        guard _root !== nil else {
            return nil
        }
        
        let result: RedBlackTreeNode! = maxElement()
        
        if isBlack(_root.left) && isBlack(_root.right) {
            _root.color = 0
        }

        _root = popMaxInternal(_root)
        
        if _root !== nil {
            _root.color = 1
        }
        
        _count -= 1
        return result
    }
    
    internal func popMaxInternal(_ node: RedBlackTreeNode) -> RedBlackTreeNode! {
        var node: RedBlackTreeNode! = node
        
        if isRed(node.left) {
            node = rotateRight(node)
        }

        if node.right === nil {
            return nil
        }

        if isBlack(node.right) && isBlack(node.right.left) {
            node = sendRedRight(node)
        }
        
        node.right = popMaxInternal(node.right)
        return rebalance(node)
    }
}


