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
    
    func testInsertion1() {
        let tree = RedBlackTree()
        tree.insert(5)
    }
    
    func testInsertion2() {
        let masterList = generateSequence(15)
        let tree = RedBlackTree()
        for value in masterList {
            tree.insert(value)
        }
        //
        for value in masterList {
            if !tree.contains(value) {
                XCTFail("couldnt find value \(value)")
                return
            }
        }
    }
    
    func testInsertionMixer() {
        for i in 2..<8 {
            let masterList = generateSequence(i)
            let permutations = allPermutions(masterList)
            for permutation in permutations {
                let tree = RedBlackTree()
                for value in permutation {
                    tree.insert(value)
                }
                for value in permutation {
                    if !tree.contains(value) {
                        XCTFail("couldnt find value \(value)")
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
            
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            
            for value in masterList {
                if !tree.contains(value) {
                    XCTFail("couldnt find value \(value)")
                    return
                }
            }
        }
    }
    
    func testInsertionLargeShuffledDataSets() {
        var masterList = generateSequence(5000)
        for _ in 0..<50 {
            shuffle(&masterList)
            
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            
            for value in masterList {
                if !tree.contains(value) {
                    XCTFail("couldnt find value \(value)")
                    return
                }
            }
        }
    }
    
    func testDeletion1() {
        let tree = RedBlackTree()
        let value = 5
        tree.insert(value)
        tree.remove(value)
        XCTAssertFalse(tree.contains(value))
    }
    
    func testDeletion2() {
        let masterList = generateSequence(15)
        for value in masterList {
            let tree = RedBlackTree()
            for insert in masterList {
                tree.insert(insert)
            }
            
            tree.remove(value)
            if tree.contains(value) {
                XCTFail("found deleted value \(value)")
                return
            }
        }
        XCTAssertTrue(true)
    }
    
    func testDeletion3() {
        
        let s1 = 2
        let s2 = 0
        let s3 = 1
        let s4 = 3
        
        let tree = RedBlackTree()
        
        tree.insert(s1)
        tree.insert(s2)
        tree.insert(s3)
        tree.insert(s4)
        
        tree.remove(s1)
        
        if tree.contains(s1) {
            XCTFail("found deleted value \(s1)")
        }
        
        if !tree.contains(s2) {
            XCTFail("lost inserted value \(s2)")
        }
        
        if !tree.contains(s3) {
            XCTFail("lost inserted value \(s3)")
        }
        
        if !tree.contains(s4) {
            XCTFail("lost inserted value \(s4)")
        }
    }
    
    func testDeletion4() {
        
        let s1 = 3
        let s2 = 0
        let s3 = 2
        let s4 = 1
        let s5 = 4
        
        let tree = RedBlackTree()
        
        tree.insert(s1)
        tree.insert(s2)
        tree.insert(s3)
        tree.insert(s4)
        tree.insert(s5)
        tree.remove(s1)
        
        if tree.contains(s1) {
            XCTFail("found deleted value \(s1)")
        }
        
        if !tree.contains(s2) {
            XCTFail("lost inserted value \(s2)")
        }
        
        if !tree.contains(s3) {
            XCTFail("lost inserted value \(s3)")
        }
        
        if !tree.contains(s4) {
            XCTFail("lost inserted value \(s4)")
        }
        
        if !tree.contains(s5) {
            XCTFail("lost inserted value \(s4)")
        }
    }
    
    func testDeletion5() {
        
        let s1 = 1
        let s2 = 2
        let s3 = 0
        
        let tree = RedBlackTree()
        
        tree.insert(s1)
        tree.insert(s2)
        tree.insert(s3)
        
        tree.remove(s3)
        tree.remove(s1)
        
        if tree.contains(s1) {
            XCTFail("found deleted value \(s1)")
        }
        
        if !tree.contains(s2) {
            XCTFail("lost inserted value \(s2)")
        }
        
        if tree.contains(s3) {
            XCTFail("found deleted value \(s1)")
        }
    }
    
    func testDeletion6() {
        
        let s1 = 1
        let s2 = 2
        let s3 = 0
        let s4 = 5
        let s5 = 3
        let s6 = 4
        
        let tree = RedBlackTree()
        
        tree.insert(s1)
        tree.insert(s2)
        tree.insert(s3)
        tree.insert(s4)
        tree.insert(s5)
        tree.insert(s6)
        
        tree.remove(s3)
        tree.remove(s5)
        
        if tree.contains(s3) {
            XCTFail("found deleted value \(s3)")
        }
        
        if tree.contains(s5) {
            XCTFail("found deleted value \(s5)")
        }
        
        if !tree.contains(s1) {
            XCTFail("lost inserted value \(s1)")
        }
        
        if !tree.contains(s2) {
            XCTFail("lost inserted value \(s2)")
        }
        
        if !tree.contains(s4) {
            XCTFail("lost inserted value \(s4)")
        }
        
        if tree.contains(s5) {
            XCTFail("found deleted value \(s5)")
        }
    }
    
    func testDeletion7() {
        
        let s1 = 1
        let s2 = 2
        let s3 = 3
        let s4 = 0
        
        let tree = RedBlackTree()
        
        tree.insert(s1)
        tree.insert(s2)
        tree.insert(s3)
        tree.insert(s4)
        
        tree.remove(s2)
        
        if tree.contains(s2) {
            XCTFail("found deleted value \(s2)")
        }
        
        if !tree.contains(s1) {
            XCTFail("lost inserted value \(s1)")
        }
        
        if !tree.contains(s3) {
            XCTFail("lost inserted value \(s3)")
        }
        
        if !tree.contains(s4) {
            XCTFail("lost inserted value \(s4)")
        }
    }
    
    func testDeletionSingleNodeMixer() {
        for i in 2..<8 {
            let masterList = generateSequence(i)
            let permutations = allPermutions(masterList)
            for permutation in permutations {
                
                for deletionTarget in masterList {
                    let clone = deletionTarget
                    
                    let tree = RedBlackTree()
                    for value in permutation {
                        tree.insert(value)
                    }
                    
                    tree.remove(clone)
                    
                    if tree.contains(clone) {
                        XCTFail("found deleted value \(clone) \(permutation) {\(clone)}")
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
                    let clone1 = deletionTarget1
                    for deletionTarget2 in masterList where deletionTarget2 != deletionTarget1 {
                        let clone2 = deletionTarget2
                        
                        let tree = RedBlackTree()
                        for value in permutation {
                            tree.insert(value)
                        }
                        
                        tree.remove(clone1)
                        tree.remove(clone2)
                        
                        if tree.contains(clone1) {
                            XCTFail("found deleted value 1 \(clone1)")
                            return
                        }
                        
                        if tree.contains(clone2) {
                            XCTFail("found deleted value 2 \(clone2)")
                            return
                        }
                    }
                }
            }
        }
    }
    
    func testAddLargeSequence() {
        for _ in 0..<20 {
            var masterList = generateSequence(25000)
            shuffle(&masterList)
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            
            for value in masterList {
                if !tree.contains(value) {
                    XCTFail("value not founnd 1 \(value)")
                    return
                }
            }
        }
    }
    
    func testAddDeleteLargeSequence() {
        for _ in 0..<20 {
            var masterList = generateSequence(25000)
            shuffle(&masterList)
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            shuffle(&masterList)
            for value in masterList {
                tree.remove(value)
            }
            if tree.count > 0 {
                XCTFail("Failed to delete all 1M values")
                return
            }
        }
    }
    
    func testAddDeletionSetMixer() {
        
        // there are just way too many permutations to do them all, so we will
        // just randomize the order a few hundred times. This should be good enough.
        
        var masterListSize = 3
        while masterListSize < 8 {
            for i in 0..<500 {
                var masterList = generateSequence(masterListSize)
                shuffle(&masterList) //This is a "permutation" - hopefully this is enough shuffles for high statistical confidence.
                
                let deleteSets = allSubsets(masterList)
                for deleteList in deleteSets {
                    
                    let tree = RedBlackTree()
                    for value in masterList {
                        tree.insert(value)
                    }
                    
                    let deleteSet = Set<Int>(deleteList)
                    let keepSet = Set<Int>(masterList).subtracting(deleteSet)
                    
                    for value in deleteSet {
                        tree.remove(value)
                    }
                    
                    for value in keepSet {
                        if !tree.contains(value) {
                            XCTFail("missing keep value iter \(i) \(value) ks: \(keepSet) ds: \(deleteSet), ml: \(masterList)")
                            return
                        }
                    }
                    
                    for value in deleteSet {
                        if tree.contains(value) {
                            XCTFail("retaining delete value iter \(i) \(value) ks: \(keepSet) ds: \(deleteSet), ml: \(masterList)")
                            return
                        }
                    }
                }
            }
            masterListSize += 1
        }
    }
    
    func testAddAllDeleteAllInOrder() {
        for _ in 0..<2000 {
            let masterList = generateMediumOrShortSequence()
            
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            
            for value in masterList {
                tree.remove(value)
            }
            
            for value in masterList {
                if tree.contains(value) {
                    XCTFail("value was retained ml: \(masterList)")
                    return
                }
            }
            
            if tree.count > 0 {
                XCTFail("wrong count")
                return
            }
        }
    }
    
    func testAddAllDeleteAllAddAllDeleteAll() {
        for _ in 0..<5000 {
            var masterList = generateMediumOrShortSequence()
            
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            
            shuffle(&masterList)
            
            for value in masterList {
                tree.remove(value)
            }
            
            for value in masterList {
                if tree.contains(value) {
                    XCTFail("value was retained ml: \(masterList)")
                    return
                }
            }
            
            if tree.count > 0 {
                XCTFail("wrong count")
                return
            }
        }
    }
    
    func testSplitAddReAdd() {
        for _ in 0..<2500 {
            var masterList = generateMediumOrShortSequence()
            
            //Add all the values...
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            
            var half1 = [Int]()
            var half2 = [Int]()
            randomSplit(&masterList, half1: &half1, half2: &half2)
            
            // delete everything from half 1, make sure they are gone...
            for value in half1 {
                tree.remove(value)
            }
            
            //everything in half 2 should still be here...
            for value in half2 {
                if !tree.contains(value) {
                    XCTFail("missing keep value")
                    return
                }
            }
            
            //everything in half 1 should be gone...
            for value in half1 {
                if tree.contains(value) {
                    XCTFail("retaining delete value")
                    return
                }
             }
            
            // re-add everything from half 1, make sure they are here...
            for value in half1 {
                tree.insert(value)
            }
            
            //everything in half 1 should be here...
            for value in half1 {
                if !tree.contains(value) {
                    XCTFail("missing keep value")
                    return
                }
             }
            
            //Delete everything from half 1 again...
            for value in half1 {
                tree.remove(value)
            }
            
            //everything in half 1 should be gone...
            for value in half1 {
                if tree.contains(value) {
                    XCTFail("retaining delete value")
                    return
                }
             }
            
            //everything in half 2 should still be here...
            for value in half2 {
                if !tree.contains(value) {
                    XCTFail("missing keep value")
                    return
                }
            }
            
            //Delete everything from half 2
            for value in half2 {
                tree.remove(value)
            }
            
            //Everything should be gone.
            if tree.count > 0 || tree._root !== nil {
                XCTFail("not empty, should be...")
            }
        }
    }
    
    func testAddDeleteLargeDisjointSets() {
        
        for _ in 0..<200 {
            var addList = generateLongSequence()
            stir(&addList)
            
            var removeList = generateLongSequence()
            stir(&removeList)
            
            let tree = RedBlackTree()
            for value in addList {
                tree.insert(value)
            }
            
            for value in removeList {
                tree.remove(value)
            }
            
            for value in removeList {
                if tree.contains(value) {
                    XCTFail("value was retained")
                    return
                }
            }
        }
    }
    
    func testPopMinBasic() {
        
        let tree = RedBlackTree()
        for length in 1..<10 {
            let masterList = generateSequence(length)
            for value in masterList {
                tree.insert(value)
            }
            
            var sortedList = Array(masterList.reversed())
            
            var i = sortedList.count - 1
            while i >= 0 {
                
                let expectedMin = sortedList.removeLast()
                let actualMin = tree.popMin()!
                if expectedMin != actualMin {
                    XCTFail("Wrong min. \(actualMin) (actual) vs \(expectedMin) (expected)")
                }
                
                i -= 1
            }
            
            if tree.popMin() != nil {
                XCTFail("Dangling min.")
            }
        }
    }
    
    func testPopMinSequential() {
        
        for _ in 1..<2000 {
            
            var masterList = generateMediumOrShortSequence()
            
            shuffle(&masterList)
            
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            
            var sortedList = Array(masterList.sorted().reversed())
            
            var i = sortedList.count - 1
            while i >= 0 {
                let expectedMin = sortedList.removeLast()
                let actualMin = tree.popMin()!
                if expectedMin != actualMin {
                    XCTFail("Wrong min. \(actualMin) (actual) vs \(expectedMin) (expected)")
                }
                
                i -= 1
            }
            
            if tree.popMin() != nil {
                XCTFail("Dangling min.")
            }
        }
    }
    
    func testPopMaxBasic() {
        let tree = RedBlackTree()
        for length in 1..<10 {
            let masterList = generateSequence(length)
            for value in masterList {
                tree.insert(value)
            }
            
            var sortedList = Array(masterList)
            
            var i = sortedList.count - 1
            while i >= 0 {
                
                let expectedMax = sortedList.removeLast()
                let actualMax = tree.popMax()!
                if expectedMax != actualMax {
                    XCTFail("Wrong max. \(actualMax) (actual) vs \(expectedMax) (expected)")
                }
                
                i -= 1
            }
            
            if tree.popMax() != nil {
                XCTFail("Dangling max.")
            }
        }
    }
    
    func testPopMaxSequential() {
        for _ in 1..<2000 {
            
            var masterList = generateMediumOrShortSequence()
            
            shuffle(&masterList)
            
            let tree = RedBlackTree()
            for value in masterList {
                tree.insert(value)
            }
            
            var sortedList = Array(masterList.sorted())
            
            var i = sortedList.count - 1
            while i >= 0 {
                let expectedMax = sortedList.removeLast()
                let actualMax = tree.popMax()!
                if expectedMax != actualMax {
                    XCTFail("Wrong max. \(actualMax) (actual) vs \(expectedMax) (expected)")
                    return
                }
                
                i -= 1
            }
            
            if tree.popMax() != nil {
                XCTFail("Dangling max.")
                return
            }
        }
    }
    
    func testAutomtonOperations() {
        
        var addedSet = Set<Int>()
        var deletedSet = Set<Int>()
        var spawnIndex: Int = 0
        var tree = RedBlackTree()
        
        automatonAddSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
        
        for _ in 0..<225 {
            let operation = Int(arc4random() & 0x7FFF) % 6
            if operation == 0 {
                automatonAddSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            } else if operation == 1 {
                automatonDeleteSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            } else if operation == 2 {
                automatonPopMin(&tree, &addedSet, &deletedSet, &spawnIndex)
            } else if operation == 3 {
                automatonPopMax(&tree, &addedSet, &deletedSet, &spawnIndex)
            } else if operation == 4 {
                automatonReAddDeletedNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
        }
        
        while tree.count > 0 {
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonAddSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonReAddDeletedNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonPopMin(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonPopMax(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonDeleteSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            automatonPopMax(&tree, &addedSet, &deletedSet, &spawnIndex)
            automatonDeleteSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            automatonPopMin(&tree, &addedSet, &deletedSet, &spawnIndex)
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonAddSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonPopMin(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonPopMax(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            
            if (Int(arc4random() & 0x7FFF) % 2) == 0 {
                automatonDeleteSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            }
            
            automatonDeleteSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
            automatonDeleteSomeNodes(&tree, &addedSet, &deletedSet, &spawnIndex)
        }
    }
    
    /// Mark: Automata helpers.
    
    func automatonAddSomeNodes(_ tree: inout RedBlackTree,
                               _ addedSet: inout Set<Int>,
                               _ deletedSet: inout Set<Int>,
                               _ spawnIndex: inout Int) {
        var count = Int(arc4random() & 0x7FFF) % 20 + 5
        if (Int(arc4random() & 0x7FFF) % 2) == 0 {
            count += 500
        }
        
        for _ in 0..<count {
            let value = spawnIndex
            spawnIndex += 1
            tree.insert(value)
            if !tree.contains(value) {
                XCTFail("Does not have inserted value")
                return
            }
            addedSet.insert(value)
        }
        automatonVerifyAll(&tree, &addedSet, &deletedSet)
    }
    
    func automatonDeleteSomeNodes(_ tree: inout RedBlackTree,
                               _ addedSet: inout Set<Int>,
                               _ deletedSet: inout Set<Int>,
                               _ spawnIndex: inout Int) {
        var count = Int(arc4random() & 0x7FFF) % 20 + 5
        if (Int(arc4random() & 0x7FFF) % 5) == 0 {
            count += 500
        }
        
        for _ in 0..<count {
            if let element = addedSet.randomElement() {
                tree.remove(element)
                if tree.contains(element) {
                    XCTFail("Retained the deleted value")
                    return
                }
                addedSet.remove(element)
                deletedSet.insert(element)
            }
            
        }
        
        automatonVerifyAll(&tree, &addedSet, &deletedSet)
    }
    
    func automatonReAddDeletedNodes(_ tree: inout RedBlackTree,
                               _ addedSet: inout Set<Int>,
                               _ deletedSet: inout Set<Int>,
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
                tree.insert(item)
             
                if !tree.contains(item) {
                    XCTFail("Does not have inserted value")
                    return
                }
            }
            index += 1
        }
        
        automatonVerifyAll(&tree, &addedSet, &deletedSet)
    }
    
    func automatonAddAndDelete(_ tree: inout RedBlackTree,
                               _ addedSet: inout Set<Int>,
                               _ deletedSet: inout Set<Int>,
                               _ spawnIndex: inout Int) {
        var count = Int(arc4random() & 0x7FFF) % 50 + 10
        if (Int(arc4random() & 0x7FFF) % 5) == 0 {
            count += 100
        }
        
        for _ in 0..<count {
            let type = Int(arc4random() & 0x7FFF) % 2
            if type == 0 {
                let value = spawnIndex
                spawnIndex += 1
                tree.insert(value)
                if !tree.contains(value) {
                    XCTFail("Does not have inserted value")
                    return
                }
                addedSet.insert(value)
            } else {
                if let element = addedSet.randomElement() {
                    tree.remove(element)
                    if tree.contains(element) {
                        XCTFail("Retained the deleted value")
                        return
                    }
                    addedSet.remove(element)
                    deletedSet.insert(element)
                }
            }
        }
        automatonVerifyAll(&tree, &addedSet, &deletedSet)
    }
    
    func automatonPopMin(_ tree: inout RedBlackTree,
    _ addedSet: inout Set<Int>,
    _ deletedSet: inout Set<Int>,
    _ spawnIndex: inout Int) {
        
        var count = Int(arc4random() & 0x7FFF) % 10 + 1
        if (Int(arc4random() & 0x7FFF) % 5) == 0 {
            count += 100
        }
        
        var sorted = Array(Array(addedSet).sorted().reversed())
        for _ in 0..<count {
            if sorted.count > 0 {
                let expectedMin = sorted.removeLast()
                let actualMin = tree.popMin()!
                if expectedMin != actualMin {
                    XCTFail("Wrong min. \(actualMin) (actual) vs \(expectedMin) (expected)")
                    return
                }
                addedSet.remove(actualMin)
            } else {
                let actualMin = tree.popMin()
                if actualMin != nil {
                    XCTFail("Wrong min. \(actualMin!) (actual) vs NULL (expected)")
                    return
                }
            }
        }
    }
    
    func automatonPopMax(_ tree: inout RedBlackTree,
    _ addedSet: inout Set<Int>,
    _ deletedSet: inout Set<Int>,
    _ spawnIndex: inout Int) {
        
        let count = Int(arc4random() & 0x7FFF) % 10 + 1
        var sorted = Array(addedSet).sorted()
        for _ in 0..<count {
            
            if sorted.count > 0 {
                let expectedMax = sorted.removeLast()
                let actualMax = tree.popMax()!
                if expectedMax != actualMax {
                    XCTFail("Wrong max. \(actualMax) (actual) vs \(expectedMax) (expected)")
                    return
                }
                addedSet.remove(actualMax)
            } else {
                let actualMax = tree.popMax()
                if actualMax != nil {
                    XCTFail("Wrong max. \(actualMax!) (actual) vs NULL (expected)")
                    return
                }
            }
        }
    }
    
    func automatonVerifyAll(_ tree: inout RedBlackTree,
                            _ addedSet: inout Set<Int>,
                            _ deletedSet: inout Set<Int>) {
        automatonVerifyAdded(&tree, &addedSet, &deletedSet)
        automatonVerifyDeleted(&tree, &addedSet, &deletedSet)
    }
    
    func automatonVerifyAdded(_ tree: inout RedBlackTree,
                               _ addedSet: inout Set<Int>,
                               _ deletedSet: inout Set<Int>) {
        for value in addedSet {
            if !tree.contains(value) {
                XCTFail("Automata - failed to find added value")
                return
            }
        }
    }
    
    func automatonVerifyDeleted(_ tree: inout RedBlackTree,
                               _ addedSet: inout Set<Int>,
                               _ deletedSet: inout Set<Int>) {
        for value in deletedSet {
            if tree.contains(value) {
                XCTFail("Automata - retained a deleted value")
                return
            }
        }
    }
    
    /// Mark: Helpers
    
    func generateSequence(_ sequenceCount: Int) -> [Int] {
        var result = [Int]()
        if sequenceCount > 0 {
            for i in 0..<sequenceCount {
                result.append(Int(i))
            }
        }
        return result
    }
    
    func generateShortSequence() -> [Int] {
        let count = Int(arc4random() & 0x7FFF) % 12
        var result = generateSequence(count)
        stir(&result)
        return result
    }
    
    func generateMediumSequence() -> [Int] {
        let count = Int(arc4random() & 0x7FFF) % 70 + 24
        var result = generateSequence(count)
        stir(&result)
        return result
    }
    
    func generateMediumOrShortSequence() -> [Int] {
        if (Int(arc4random() & 0x7FFF) % 2) == 0 {
            return generateShortSequence()
        } else {
            return generateMediumSequence()
        }
    }
    
    func generateLongSequence() -> [Int] {
        let count = Int(arc4random() & 0x7FFF) % 2500 + 800
        var result = generateSequence(count)
        stir(&result)
        return result
    }
    
    func randomSplit(_ valueArray: inout [Int], half1: inout [Int], half2 : inout [Int]) {
        
        half1.removeAll()
        half2.removeAll()
        
        if valueArray.count == 0 {
            return
        }
        
        let splitIndex = Int(arc4random() & 0x7FFF) % valueArray.count
        
        if (Int(arc4random() & 0x7FFF) % 2) == 0 {
            var i: Int = 0
            while i < splitIndex {
                half2.append(valueArray[i])
                i += 1
            }
            while i < valueArray.count {
                half1.append(valueArray[i])
                i += 1
            }
        } else {
            var i: Int = 0
            while i < splitIndex {
                half1.append(valueArray[i])
                i += 1
            }
            while i < valueArray.count {
                half2.append(valueArray[i])
                i += 1
            }
        }
    }
    
    func stir(_ valueArray: inout [Int]) {
        guard valueArray.count > 1 else { return }
        
        let shuffleMode = Int(arc4random() & 0x7FFF) % 2
        if shuffleMode == 1 {
            shuffle(&valueArray)
        }
        
        let reverseMode = Int(arc4random() & 0x7FFF) % 2
        if reverseMode == 1 {
            valueArray.reverse()
        }
        
        let stirIndex = Int(arc4random() & 0x7FFF) % 8
        if stirIndex == 0 {
            valueArray.append(valueArray.removeFirst())
        } else if stirIndex == 1 {
            valueArray.insert(valueArray.removeLast(), at: 0)
        } else if stirIndex == 2 {
            valueArray.append(valueArray.removeFirst())
            valueArray.append(valueArray.removeFirst())
        } else if stirIndex == 3 {
            valueArray.insert(valueArray.removeLast(), at: 0)
            valueArray.insert(valueArray.removeLast(), at: 0)
        } else {
            
            var half1 = [Int]()
            var half2 = [Int]()
            
            for i in 0..<valueArray.count {
                if i <= (valueArray.count / 2) {
                    half1.append(valueArray[i])
                } else {
                    half2.append(valueArray[i])
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

            valueArray.removeAll()
            
            if stirIndex == 4 {
                for value in half1 {
                    valueArray.append(value)
                }
                for value in half2 {
                    valueArray.append(value)
                }
            } else if stirIndex == 5 {
                for value in half2 {
                    valueArray.append(value)
                }
                for value in half1 {
                    valueArray.append(value)
                }
            } else if stirIndex == 6 {
                for value in half2 {
                    valueArray.append(value)
                }
                for value in half1 {
                    valueArray.append(value)
                }
            } else {
                var i: Int = 0
                while i < half1.count || i < half2.count {
                    if i < half1.count {
                        valueArray.append(half1[i])
                    }
                    if i < half2.count {
                        valueArray.append(half2[i])
                    }
                    i += 1
                }
            }
        }
        
        for i in valueArray.indices {
            let index = Int(arc4random() & 0x7FFF) % valueArray.count
            let hold = valueArray[i]
            valueArray[i] = valueArray[index]
            valueArray[index] = hold
        }
    }
    
    func shuffle(_ valueArray: inout [Int]) {
        guard valueArray.count > 1 else { return }
        for i in valueArray.indices {
            let index = Int(arc4random() & 0x7FFF) % valueArray.count
            let hold = valueArray[i]
            valueArray[i] = valueArray[index]
            valueArray[index] = hold
        }
    }
    
    func allSubsets(_ valueArray: [Int]) -> [[Int]] {
        let valueArray = valueArray.sorted()
        var result = [[Int]]()
        result.append([Int]())
        var i: Int = 0
        while i < valueArray.count {
            var probe = i + 1
            while probe < valueArray.count && valueArray[probe] == valueArray[i] {
                probe += 1
            }
            let dupeCount = probe - i
            let resultCount = result.count
            for n in 0..<resultCount {
                var arr = result[n]
                for _ in 0..<dupeCount {
                    arr.append(valueArray[i])
                    result.append(arr)
                }
            }
            i += dupeCount
        }
        return result
    }
    
    func allPermutions(_ valueArray: [Int]) -> [[Int]] {
        
        var res = [[Int]]()
        var valueArray = valueArray.sorted()
        
        while true {
            res.append(valueArray)
            
            var x = valueArray.count - 2
            while x >= 0 && valueArray[x] >= valueArray[x + 1] {
                x -= 1
            }
            
            if x < 0 { break }
            
            var successor = valueArray[x + 1]
            var successorIndex = x + 1
            
            var i = x + 1
            
            while i < valueArray.count {
                if valueArray[i] > valueArray[x] && valueArray[i] <= successor {
                    successor = valueArray[i]
                    successorIndex = i
                }
                
                i += 1
            }
            
            valueArray.swapAt(x, successorIndex)
            
            var lo = x + 1
            var hi = valueArray.count - 1
            while lo < hi {
                valueArray.swapAt(lo, hi)
                lo += 1
                hi -= 1
            }
        }
        return res
    }
}
