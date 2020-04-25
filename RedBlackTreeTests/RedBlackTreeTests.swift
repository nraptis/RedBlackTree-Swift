//
//  RedBlackTreeTests.swift
//  RedBlackTreeTests
//
//  Created by Nick Raptis on 4/25/20.
//  Copyright © 2020 Nick Raptis. All rights reserved.
//

import XCTest
@testable import RedBlackTree

class RedBlackTreeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    /// Mark: Testing data node comparison reliability
    
    func testComparisons1() {
        let node1 = RedBlackTreeNode(5)
        let node2 = RedBlackTreeNode(5)
        if node1 != node2 { XCTFail("basic equality failed") }
    }
    
    func testComparisons2() {
        let node1 = RedBlackTreeNode(10)
        let node2 = RedBlackTreeNode(5)
        if node1 == node2 { XCTFail("basic equality failed") }
        if node1 < node2 { XCTFail("basic equality failed") }
        if node2 > node1 { XCTFail("basic equality failed") }
    }
    
    func testComparisons3() {
        let node1 = RedBlackTreeNode(5)
        let node2 = RedBlackTreeNode(10)
        if node1 == node2 { XCTFail("basic equality failed") }
        if node1 > node2 { XCTFail("basic equality failed") }
        if node2 < node1 { XCTFail("basic equality failed") }
    }
    
    func testInsertion1() {
        let bucket = RedBlackTree()
        let node = spawn(5)
        bucket.insert(node.clone())
    }
    
    func testInsertion2() {
        let masterList = generateSequence(15)
        let bucket = RedBlackTree()
        for node in masterList {
            bucket.insert(node.clone())
        }
        for node in masterList {
            if !bucket.search(node) {
                XCTFail("couldnt find node \(node)")
                return
            }
        }
    }
    
    func testInsertionMixer() {
        for i in 2..<8 {
            let masterList = generateSequence(i)
            let permutations = allPermutions(masterList)
            for permutation in permutations {
                let bucket = RedBlackTree()
                for node in permutation {
                    bucket.insert(node.clone())
                }
                for node in permutation {
                    if !bucket.search(node) {
                        XCTFail("couldnt find node \(node)")
                        return
                    }
                }
            }
        }
    }
    
    func testInsertionLargeSequentialDataSets() {
        var masterList = generateSequence(500)
        for i in 0..<2 {
            if i == 1 {
                masterList.reverse()
            }
            
            let bucket = RedBlackTree()
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            for node in masterList {
                if !bucket.search(node) {
                    XCTFail("couldnt find node \(node)")
                    return
                }
            }
        }
    }
    
    func testInsertionLargeShuffledDataSets() {
        var masterList = generateSequence(5000)
        for _ in 0..<50 {
            shuffle(&masterList)
            
            let bucket = RedBlackTree()
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            for node in masterList {
                if !bucket.search(node) {
                    XCTFail("couldnt find node \(node)")
                    return
                }
            }
        }
    }
    
    func testDeletion1() {
        let bucket = RedBlackTree()
        let node = spawn(5)
        bucket.insert(node.clone())
        bucket.remove(node.clone())
        XCTAssertFalse(bucket.search(node.clone()))
    }
    
    func testDeletion2() {
        let masterList = generateSequence(15)
        for node in masterList {
            let bucket = RedBlackTree()
            for insert in masterList {
                bucket.insert(insert.clone())
            }
            
            bucket.remove(node.clone())
            if bucket.search(node) {
                XCTFail("found deleted node \(node)")
                return
            }
        }
        XCTAssertTrue(true)
    }
    
    func testDeletion3() {
        
        let s1 = spawn(2)
        let s2 = spawn(0)
        let s3 = spawn(1)
        let s4 = spawn(3)
        
        let bucket = RedBlackTree()
        
        bucket.insert(s1.clone())
        bucket.insert(s2.clone())
        bucket.insert(s3.clone())
        bucket.insert(s4.clone())
        
        bucket.remove(s1.clone())
        
        if bucket.search(s1) {
            XCTFail("found deleted node \(s1)")
        }
        
        if !bucket.search(s2) {
            XCTFail("lost inserted node \(s2)")
        }
        
        if !bucket.search(s3) {
            XCTFail("lost inserted node \(s3)")
        }
        
        if !bucket.search(s4) {
            XCTFail("lost inserted node \(s4)")
        }
    }
    
    func testDeletion4() {
        
        let s1 = spawn(3)
        let s2 = spawn(0)
        let s3 = spawn(2)
        let s4 = spawn(1)
        let s5 = spawn(4)
        
        let bucket = RedBlackTree()
        
        bucket.insert(s1.clone())
        bucket.insert(s2.clone())
        bucket.insert(s3.clone())
        bucket.insert(s4.clone())
        bucket.insert(s5.clone())
        bucket.remove(s1.clone())
        
        if bucket.search(s1) {
            XCTFail("found deleted node \(s1)")
        }
        
        if !bucket.search(s2) {
            XCTFail("lost inserted node \(s2)")
        }
        
        if !bucket.search(s3) {
            XCTFail("lost inserted node \(s3)")
        }
        
        if !bucket.search(s4) {
            XCTFail("lost inserted node \(s4)")
        }
        
        if !bucket.search(s5) {
            XCTFail("lost inserted node \(s4)")
        }
    }
    
    func testDeletion5() {
        
        let s1 = spawn(1)
        let s2 = spawn(2)
        let s3 = spawn(0)
        
        let bucket = RedBlackTree()
        
        bucket.insert(s1.clone())
        bucket.insert(s2.clone())
        bucket.insert(s3.clone())
        
        bucket.remove(s3.clone())
        bucket.remove(s1.clone())
        
        if bucket.search(s1) {
            XCTFail("found deleted node \(s1)")
        }
        
        if !bucket.search(s2) {
            XCTFail("lost inserted node \(s2)")
        }
        
        if bucket.search(s3) {
            XCTFail("found deleted node \(s1)")
        }
    }
    
    func testDeletion6() {
        
        let s1 = spawn(1)
        let s2 = spawn(2)
        let s3 = spawn(0)
        let s4 = spawn(5)
        let s5 = spawn(3)
        let s6 = spawn(4)
        
        let bucket = RedBlackTree()
        
        bucket.insert(s1.clone())
        bucket.insert(s2.clone())
        bucket.insert(s3.clone())
        bucket.insert(s4.clone())
        bucket.insert(s5.clone())
        bucket.insert(s6.clone())
        
        bucket.remove(s3.clone())
        bucket.remove(s5.clone())
        
        if bucket.search(s3) {
            XCTFail("found deleted node \(s3)")
        }
        
        if bucket.search(s5) {
            XCTFail("found deleted node \(s5)")
        }
        
        if !bucket.search(s1) {
            XCTFail("lost inserted node \(s1)")
        }
        
        if !bucket.search(s2) {
            XCTFail("lost inserted node \(s2)")
        }
        
        if !bucket.search(s4) {
            XCTFail("lost inserted node \(s4)")
        }
        
        if bucket.search(s5) {
            XCTFail("found deleted node \(s5)")
        }
    }
    
    func testDeletion7() {
        
        let s1 = spawn(1)
        let s2 = spawn(2)
        let s3 = spawn(3)
        let s4 = spawn(0)
        
        let bucket = RedBlackTree()
        
        bucket.insert(s1.clone())
        bucket.insert(s2.clone())
        bucket.insert(s3.clone())
        bucket.insert(s4.clone())
        
        bucket.remove(s2.clone())
        
        if bucket.search(s2) {
            XCTFail("found deleted node \(s2)")
        }
        
        if !bucket.search(s1) {
            XCTFail("lost inserted node \(s1)")
        }
        
        if !bucket.search(s3) {
            XCTFail("lost inserted node \(s3)")
        }
        
        if !bucket.search(s4) {
            XCTFail("lost inserted node \(s4)")
        }
    }
    
    func testDeletionSingleNodeMixer() {
        for i in 2..<8 {
            let masterList = generateSequence(i)
            let permutations = allPermutions(masterList)
            for permutation in permutations {
                
                for deletionTarget in masterList {
                    let clone = deletionTarget.clone()
                    
                    let bucket = RedBlackTree()
                    for node in permutation {
                        bucket.insert(node.clone())
                    }
                    
                    bucket.remove(clone)
                    
                    if bucket.search(clone) {
                        XCTFail("found deleted node \(clone) \(permutation) {\(clone)}")
                        return
                    }
                }
            }
        }
    }
    
    func testDeletionDoubleNodeMixer() {
        for i in 2..<6 {
            let masterList = generateSequence(i)
            let permutations = allPermutions(masterList)
            for permutation in permutations {
                
                for deletionTarget1 in masterList {
                    let clone1 = deletionTarget1.clone()
                    for deletionTarget2 in masterList where deletionTarget2 != deletionTarget1 {
                        let clone2 = deletionTarget2.clone()
                        
                        let bucket = RedBlackTree()
                        for node in permutation {
                            bucket.insert(node.clone())
                        }
                        
                        bucket.remove(clone1)
                        bucket.remove(clone2)
                        
                        if bucket.search(clone1) {
                            XCTFail("found deleted node 1 \(clone1)")
                            return
                        }
                        
                        if bucket.search(clone2) {
                            XCTFail("found deleted node 2 \(clone2)")
                            return
                        }
                    }
                }
            }
        }
    }
    
    func testBSTAddLargeSequence() {
        var masterList = generateSequence(25000)
        shuffle(&masterList)
        let bucket = RedBlackTree()
        for node in masterList {
            bucket.insert(node.clone())
        }
    }
    
    func testBSTAddDeleteLargeSequence() {
        var masterList = generateSequence(25000)
        shuffle(&masterList)
        let bucket = RedBlackTree()
        for node in masterList {
            bucket.insert(node.clone())
        }
        shuffle(&masterList)
        for node in masterList {
            bucket.remove(node.clone())
        }
        if bucket.count > 0 {
            XCTFail("Failed to delete all 1M nodes")
            return
        }
    }
    
    func testBSTAddDeletionSetMixer() {
        
        // there are just way too many permutations to do them all, so we will
        // just randomize the order a few hundred times. This should be good enough.
        
        var masterListSize = 3
        while masterListSize < 8 {
            for i in 0..<500 {
                var masterList = generateSequence(masterListSize)
                shuffle(&masterList) //This is a "permutation" - hopefully this is enough shuffles for high statistical confidence.
                
                let deleteSets = allSubsets(masterList)
                for deleteList in deleteSets {
                    
                    let bucket = RedBlackTree()
                    for node in masterList {
                        bucket.insert(node.clone())
                    }
                    
                    let deleteSet = Set<RedBlackTreeNode>(deleteList)
                    let keepSet = Set<RedBlackTreeNode>(masterList).subtracting(deleteSet)
                    
                    for node in deleteSet {
                        bucket.remove(node.clone())
                    }
                    
                    for node in keepSet {
                        if !bucket.search(node) {
                            XCTFail("missing keep node iter \(i) \(node) ks: \(keepSet) ds: \(deleteSet), ml: \(masterList)")
                            return
                        }
                    }
                    
                    for node in deleteSet {
                        if bucket.search(node) {
                            XCTFail("retaining delete node iter \(i) \(node) ks: \(keepSet) ds: \(deleteSet), ml: \(masterList)")
                            return
                        }
                    }
                }
            }
            masterListSize += 1
        }
    }
    
    func testBSTAddAllDeleteAllInOrder() {
        for _ in 0..<2000 {
            let masterList = generateMediumOrShortSequence()
            
            let bucket = RedBlackTree()
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            for node in masterList {
                bucket.remove(node.clone())
            }
            
            for node in masterList {
                if bucket.search(node) {
                    XCTFail("node was retained ml: \(masterList)")
                    return
                }
            }
            
            if bucket.count > 0 {
                XCTFail("wrong count")
                return
            }
        }
    }
    
    func testBSTAddAllDeleteAllAddAllDeleteAll() {
        for _ in 0..<5000 {
            var masterList = generateMediumOrShortSequence()
            
            let bucket = RedBlackTree()
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            shuffle(&masterList)
            
            for node in masterList {
                bucket.remove(node.clone())
            }
            
            for node in masterList {
                if bucket.search(node) {
                    XCTFail("node was retained ml: \(masterList)")
                    return
                }
            }
            
            if bucket.count > 0 {
                XCTFail("wrong count")
                return
            }
        }
    }
    
    func testBSTSplitAddReAdd() {
        for _ in 0..<2500 {
            var masterList = generateMediumOrShortSequence()
            
            //Add all the nodes...
            let bucket = RedBlackTree()
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            var half1 = [RedBlackTreeNode]()
            var half2 = [RedBlackTreeNode]()
            randomSplit(&masterList, half1: &half1, half2: &half2)
            
            // delete everything from half 1, make sure they are gone...
            for node in half1 {
                bucket.remove(node.clone())
            }
            
            //everything in half 2 should still be here...
            for node in half2 {
                if !bucket.search(node) {
                    XCTFail("missing keep node")
                    return
                }
            }
            
            //everything in half 1 should be gone...
            for node in half1 {
                if bucket.search(node) {
                    XCTFail("retaining delete node")
                    return
                }
             }
            
            // re-add everything from half 1, make sure they are here...
            for node in half1 {
                bucket.insert(node.clone())
            }
            
            //everything in half 1 should be here...
            for node in half1 {
                if !bucket.search(node) {
                    XCTFail("missing keep node")
                    return
                }
             }
            
            //Delete everything from half 1 again...
            for node in half1 {
                bucket.remove(node.clone())
            }
            
            //everything in half 1 should be gone...
            for node in half1 {
                if bucket.search(node) {
                    XCTFail("retaining delete node")
                    return
                }
             }
            
            //everything in half 2 should still be here...
            for node in half2 {
                if !bucket.search(node) {
                    XCTFail("missing keep node")
                    return
                }
            }
            
            //Delete everything from half 2
            for node in half2 {
                bucket.remove(node.clone())
            }
            
            //Everything should be gone.
            if bucket.count > 0 || bucket._root !== nil {
                XCTFail("not empty, should be...")
            }
        }
    }
    
    func testPopMinBasic() {
        
        let bucket = RedBlackTree()
        for length in 1..<10 {
            let masterList = generateSequence(length)
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            var sortedList = Array(masterList.reversed())
            
            var i = sortedList.count - 1
            while i >= 0 {
                
                let expectedMin = sortedList.removeLast()
                let actualMin = bucket.popMin()!
                if expectedMin != actualMin {
                    XCTFail("Wrong min. \(actualMin) (actual) vs \(expectedMin) (expected)")
                }
                
                i -= 1
            }
            
            if bucket.popMin() !== nil {
                XCTFail("Dangling min.")
            }
        }
    }
    
    func testPopMinSequential() {
        
        for _ in 1..<2000 {
            
            var masterList = generateMediumOrShortSequence()
            
            shuffle(&masterList)
            
            let bucket = RedBlackTree()
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            var sortedList = Array(masterList.sorted().reversed())
            
            var i = sortedList.count - 1
            while i >= 0 {
                let expectedMin = sortedList.removeLast()
                let actualMin = bucket.popMin()!
                if expectedMin != actualMin {
                    XCTFail("Wrong min. \(actualMin) (actual) vs \(expectedMin) (expected)")
                }
                
                i -= 1
            }
            
            if bucket.popMin() !== nil {
                XCTFail("Dangling min.")
            }
        }
    }
    
    func testPopMaxBasic() {
        let bucket = RedBlackTree()
        for length in 1..<10 {
            let masterList = generateSequence(length)
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            var sortedList = Array(masterList)
            
            var i = sortedList.count - 1
            while i >= 0 {
                
                let expectedMax = sortedList.removeLast()
                let actualMax = bucket.popMax()!
                if expectedMax != actualMax {
                    XCTFail("Wrong max. \(actualMax) (actual) vs \(expectedMax) (expected)")
                }
                
                i -= 1
            }
            
            if bucket.popMax() !== nil {
                XCTFail("Dangling max.")
            }
        }
    }
    
    func testPopMaxSequential() {
        for _ in 1..<2000 {
            
            var masterList = generateMediumOrShortSequence()
            
            shuffle(&masterList)
            
            let bucket = RedBlackTree()
            for node in masterList {
                bucket.insert(node.clone())
            }
            
            var sortedList = Array(masterList.sorted())
            
            var i = sortedList.count - 1
            while i >= 0 {
                let expectedMax = sortedList.removeLast()
                let actualMax = bucket.popMax()!
                if expectedMax != actualMax {
                    XCTFail("Wrong max. \(actualMax) (actual) vs \(expectedMax) (expected)")
                    return
                }
                
                i -= 1
            }
            
            if bucket.popMax() !== nil {
                XCTFail("Dangling max.")
                return
            }
        }
    }
    
    func testAutomtonOperations() {
        
        var addedSet = Set<RedBlackTreeNode>()
        var deletedSet = Set<RedBlackTreeNode>()
        var spawnIndex: Int = 0
        var bucket = RedBlackTree()
        
        automatonAddSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
        
        for _ in 0..<80 {
            let operation = Int(arc4random() & 0x7FFF) % 6
            if operation == 0 {
                automatonAddSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            } else if operation == 1 {
                automatonDeleteSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            } else if operation == 2 {
                automatonPopMin(&bucket, &addedSet, &deletedSet, &spawnIndex)
            } else if operation == 3 {
                automatonPopMax(&bucket, &addedSet, &deletedSet, &spawnIndex)
            } else if operation == 4 {
                automatonReAddDeletedNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
        }
        
        while bucket.count > 0 {
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonAddSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonReAddDeletedNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonPopMin(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonPopMax(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonDeleteSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            automatonPopMax(&bucket, &addedSet, &deletedSet, &spawnIndex)
            automatonDeleteSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            automatonPopMin(&bucket, &addedSet, &deletedSet, &spawnIndex)
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonAddSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonPopMin(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonPopMax(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonDeleteSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            }
            
            automatonDeleteSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
            automatonDeleteSomeNodes(&bucket, &addedSet, &deletedSet, &spawnIndex)
        }
    }
    
    /// Mark: Automata helpers.
    
    func automatonAddSomeNodes(_ bucket: inout RedBlackTree,
                               _ addedSet: inout Set<RedBlackTreeNode>,
                               _ deletedSet: inout Set<RedBlackTreeNode>,
                               _ spawnIndex: inout Int) {
        var count = Int(arc4random() & 0x7FFF) % 20 + 5
        if (Int(arc4random() & 0x7FFF) % 2) == 0 {
            count += 500
        }
        
        for _ in 0..<count {
            let node = spawn(spawnIndex)
            spawnIndex += 1
            bucket.insert(node.clone())
            if !bucket.search(node) {
                XCTFail("Does not have inserted node")
                return
            }
            addedSet.insert(node)
        }
        automatonVerifyAll(&bucket, &addedSet, &deletedSet)
    }
    
    func automatonDeleteSomeNodes(_ bucket: inout RedBlackTree,
                               _ addedSet: inout Set<RedBlackTreeNode>,
                               _ deletedSet: inout Set<RedBlackTreeNode>,
                               _ spawnIndex: inout Int) {
        var count = Int(arc4random() & 0x7FFF) % 20 + 5
        if (Int(arc4random() & 0x7FFF) % 5) == 0 {
            count += 500
        }
        
        for _ in 0..<count {
            if let element = addedSet.randomElement() {
                bucket.remove(element.clone())
                if bucket.search(element) {
                    XCTFail("Retained the deleted node")
                    return
                }
                addedSet.remove(element)
                deletedSet.insert(element)
            }
            
        }
        
        automatonVerifyAll(&bucket, &addedSet, &deletedSet)
    }
    
    func automatonReAddDeletedNodes(_ bucket: inout RedBlackTree,
                               _ addedSet: inout Set<RedBlackTreeNode>,
                               _ deletedSet: inout Set<RedBlackTreeNode>,
                               _ spawnIndex: inout Int) {
        var count = Int(arc4random() & 0x7FFF) % 20 + 5
        if (Int(arc4random() & 0x7FFF) % 5) == 0 {
            count += 200
        }
        
        let deletedArray = Array(deletedSet)
        var index = 0
        
        for _ in 0..<count {
            
            if index < deletedArray.count {
                let item = deletedArray[index]
                deletedSet.remove(item)
                addedSet.insert(item)
                bucket.insert(item.clone())
             
                if !bucket.search(item) {
                    XCTFail("Does not have inserted node")
                    return
                }
            }
            index += 1
        }
        
        automatonVerifyAll(&bucket, &addedSet, &deletedSet)
    }
    
    func automatonAddAndDelete(_ bucket: inout RedBlackTree,
                               _ addedSet: inout Set<RedBlackTreeNode>,
                               _ deletedSet: inout Set<RedBlackTreeNode>,
                               _ spawnIndex: inout Int) {
        var count = Int(arc4random() & 0x7FFF) % 50 + 10
        if (Int(arc4random() & 0x7FFF) % 5) == 0 {
            count += 100
        }
        
        for _ in 0..<count {
            
            let type = Int(arc4random() & 0x7FFF) % 2
            
            if type == 0 {
                let node = spawn(spawnIndex)
                spawnIndex += 1
                bucket.insert(node.clone())
                if !bucket.search(node) {
                    XCTFail("Does not have inserted node")
                    return
                }
                addedSet.insert(node)
            } else {

                if let element = addedSet.randomElement() {
                    
                    bucket.remove(element.clone())
                    if bucket.search(element) {
                        XCTFail("Retained the deleted node")
                        return
                    }
                    addedSet.remove(element)
                    deletedSet.insert(element)
                }
            }
        }
        automatonVerifyAll(&bucket, &addedSet, &deletedSet)
    }
    
    func automatonPopMin(_ bucket: inout RedBlackTree,
    _ addedSet: inout Set<RedBlackTreeNode>,
    _ deletedSet: inout Set<RedBlackTreeNode>,
    _ spawnIndex: inout Int) {
        
        var count = Int(arc4random() & 0x7FFF) % 10 + 1
        if (Int(arc4random() & 0x7FFF) % 5) == 0 {
            count += 100
        }
        
        var sorted = Array(Array(addedSet).sorted().reversed())
        for _ in 0..<count {
            if sorted.count > 0 {
                let expectedMin = sorted.removeLast()
                let actualMin = bucket.popMin()!
                if expectedMin != actualMin {
                    XCTFail("Wrong min. \(actualMin) (actual) vs \(expectedMin) (expected)")
                    return
                }
                addedSet.remove(actualMin)
            } else {
                let actualMin = bucket.popMin()
                if actualMin !== nil {
                    XCTFail("Wrong min. \(actualMin!) (actual) vs NULL (expected)")
                    return
                }
            }
        }
    }
    
    func automatonPopMax(_ bucket: inout RedBlackTree,
    _ addedSet: inout Set<RedBlackTreeNode>,
    _ deletedSet: inout Set<RedBlackTreeNode>,
    _ spawnIndex: inout Int) {
        
        let count = Int(arc4random() & 0x7FFF) % 10 + 1
        var sorted = Array(addedSet).sorted()
        for _ in 0..<count {
            
            if sorted.count > 0 {
                let expectedMax = sorted.removeLast()
                let actualMax = bucket.popMax()!
                if expectedMax != actualMax {
                    XCTFail("Wrong max. \(actualMax) (actual) vs \(expectedMax) (expected)")
                    return
                }
                addedSet.remove(actualMax)
            } else {
                let actualMax = bucket.popMax()
                if actualMax !== nil {
                    XCTFail("Wrong max. \(actualMax!) (actual) vs NULL (expected)")
                    return
                }
            }
        }
    }
    
    func automatonVerifyAll(_ bucket: inout RedBlackTree,
                            _ addedSet: inout Set<RedBlackTreeNode>,
                            _ deletedSet: inout Set<RedBlackTreeNode>) {
        automatonVerifyAdded(&bucket, &addedSet, &deletedSet)
        automatonVerifyDeleted(&bucket, &addedSet, &deletedSet)
    }
    
    func automatonVerifyAdded(_ bucket: inout RedBlackTree,
                               _ addedSet: inout Set<RedBlackTreeNode>,
                               _ deletedSet: inout Set<RedBlackTreeNode>) {
        for node in addedSet {
            if !bucket.search(node) {
                XCTFail("Automata - failed to find added node")
                return
            }
        }
    }
    
    func automatonVerifyDeleted(_ bucket: inout RedBlackTree,
                               _ addedSet: inout Set<RedBlackTreeNode>,
                               _ deletedSet: inout Set<RedBlackTreeNode>) {
        for node in deletedSet {
            if bucket.search(node) {
                XCTFail("Automata - retained a deleted node")
                return
            }
        }
    }
    
    /// Mark: Helpers
    
    func generateData() -> Data {
        return generateData(1, 160)
    }
    
    func generateData(_ minSize: Int, _ maxSize: Int) -> Data {
        let range = (maxSize + 1) - minSize
        var resultSize = minSize
        if range > 0 { resultSize += Int(arc4random() & 0x7FFF) % range }
        var result = Data()
        for _ in 0..<resultSize { result.append(UInt8(arc4random() & 0xFF)) }
        return result
    }
    
    func spawn(_ value: Int) -> RedBlackTreeNode {
        let result = RedBlackTreeNode(value)
        return result
    }
    
    func generateSequence(_ sequenceCount: Int) -> [RedBlackTreeNode] {
        var result = [RedBlackTreeNode]()
        if sequenceCount > 0 {
            for i in 0..<sequenceCount {
                result.append(RedBlackTreeNode(i))
            }
        }
        return result
    }
    
    func generateShortSequence() -> [RedBlackTreeNode] {
        let count = Int(arc4random() & 0x7FFF) % 12
        var result = generateSequence(count)
        stir(&result)
        return result
    }
    
    func generateMediumSequence() -> [RedBlackTreeNode] {
        let count = Int(arc4random() & 0x7FFF) % 70 + 24
        var result = generateSequence(count)
        stir(&result)
        return result
    }
    
    func generateMediumOrShortSequence() -> [RedBlackTreeNode] {
        if (Int(arc4random() & 0x7FFF) % 2) == 0 {
            return generateShortSequence()
        } else {
            return generateMediumSequence()
        }
    }
    
    func randomSplit(_ nodeArray: inout [RedBlackTreeNode], half1: inout [RedBlackTreeNode], half2 : inout [RedBlackTreeNode]) {
        
        half1.removeAll()
        half2.removeAll()
        
        if nodeArray.count == 0 {
            return
        }
        
        let splitIndex = Int(arc4random() & 0x7FFF) % nodeArray.count
        
        if (Int(arc4random() & 0x7FFF) % 2) == 0 {
            var i: Int = 0
            while i < splitIndex {
                half2.append(nodeArray[i])
                i += 1
            }
            while i < nodeArray.count {
                half1.append(nodeArray[i])
                i += 1
            }
        } else {
            var i: Int = 0
            while i < splitIndex {
                half1.append(nodeArray[i])
                i += 1
            }
            while i < nodeArray.count {
                half2.append(nodeArray[i])
                i += 1
            }
        }
    }
    
    //Assume that the list is sorted.
    func stir(_ nodeArray: inout [RedBlackTreeNode]) {
        guard nodeArray.count > 1 else { return }
        
        let shuffleMode = Int(arc4random() & 0x7FFF) % 2
        if shuffleMode == 1 {
            shuffle(&nodeArray)
        }
        
        let reverseMode = Int(arc4random() & 0x7FFF) % 2
        if reverseMode == 1 {
            nodeArray.reverse()
        }
        
        let stirIndex = Int(arc4random() & 0x7FFF) % 8
        if stirIndex == 0 {
            nodeArray.append(nodeArray.removeFirst())
        } else if stirIndex == 1 {
            nodeArray.insert(nodeArray.removeLast(), at: 0)
        } else if stirIndex == 2 {
            nodeArray.append(nodeArray.removeFirst())
            nodeArray.append(nodeArray.removeFirst())
        } else if stirIndex == 3 {
            nodeArray.insert(nodeArray.removeLast(), at: 0)
            nodeArray.insert(nodeArray.removeLast(), at: 0)
        } else {
            
            var half1 = [RedBlackTreeNode]()
            var half2 = [RedBlackTreeNode]()
            
            for i in 0..<nodeArray.count {
                if i <= (nodeArray.count / 2) {
                    half1.append(nodeArray[i])
                } else {
                    half2.append(nodeArray[i])
                }
            }
            
            let recursiveMode = Int(arc4random() & 0x7FFF) % 10
            if recursiveMode == 0 {
                stir(&half1)
            } else if recursiveMode == 1 {
                stir(&half2)
            } else if recursiveMode == 2 {
                stir(&half1)
                stir(&half2)
            }

            nodeArray.removeAll()
            
            if stirIndex == 4 {
                for node in half1 {
                    nodeArray.append(node)
                }
                for node in half2 {
                    nodeArray.append(node)
                }
            } else if stirIndex == 5 {
                for node in half2 {
                    nodeArray.append(node)
                }
                for node in half1 {
                    nodeArray.append(node)
                }
            } else if stirIndex == 6 {
                for node in half2 {
                    nodeArray.append(node)
                }
                for node in half1 {
                    nodeArray.append(node)
                }
            } else {
                var i: Int = 0
                while i < half1.count || i < half2.count {
                    if i < half1.count {
                        nodeArray.append(half1[i])
                    }
                    if i < half2.count {
                        nodeArray.append(half2[i])
                    }
                    i += 1
                }
            }
        }
        
        for i in nodeArray.indices {
            let index = Int(arc4random() & 0x7FFF) % nodeArray.count
            let hold = nodeArray[i]
            nodeArray[i] = nodeArray[index]
            nodeArray[index] = hold
        }
    }
    
    func shuffle(_ nodeArray: inout [RedBlackTreeNode]) {
        guard nodeArray.count > 1 else { return }
        for i in nodeArray.indices {
            let index = Int(arc4random() & 0x7FFF) % nodeArray.count
            let hold = nodeArray[i]
            nodeArray[i] = nodeArray[index]
            nodeArray[index] = hold
        }
    }
    
    func allSubsets(_ nodeArray: [RedBlackTreeNode]) -> [[RedBlackTreeNode]] {
        let nodeArray = nodeArray.sorted()
        var result = [[RedBlackTreeNode]]()
        result.append([RedBlackTreeNode]())
        var i: Int = 0
        while i < nodeArray.count {
            var probe = i + 1
            while probe < nodeArray.count && nodeArray[probe] == nodeArray[i] {
                probe += 1
            }
            let dupeCount = probe - i
            let resultCount = result.count
            for n in 0..<resultCount {
                var arr = result[n]
                for _ in 0..<dupeCount {
                    arr.append(nodeArray[i])
                    result.append(arr)
                }
            }
            i += dupeCount
        }
        return result
    }
    
    func allPermutions(_ nodeArray: [RedBlackTreeNode]) -> [[RedBlackTreeNode]] {
        
        var res = [[RedBlackTreeNode]]()
        var nodeArray = nodeArray.sorted()
        
        while true {
            res.append(nodeArray)
            
            var x = nodeArray.count - 2
            while x >= 0 && nodeArray[x] >= nodeArray[x + 1] {
                x -= 1
            }
            
            if x < 0 { break }
            
            var successor = nodeArray[x + 1]
            var successorIndex = x + 1
            
            var i = x + 1
            
            while i < nodeArray.count {
                if nodeArray[i] > nodeArray[x] && nodeArray[i] <= successor {
                    successor = nodeArray[i]
                    successorIndex = i
                }
                
                i += 1
            }
            
            nodeArray.swapAt(x, successorIndex)
            
            var lo = x + 1
            var hi = nodeArray.count - 1
            while lo < hi {
                nodeArray.swapAt(lo, hi)
                lo += 1
                hi -= 1
            }
        }
        return res
    }
}
