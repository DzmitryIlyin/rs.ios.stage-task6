//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?
    
    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        let canToss = hand?.first(where: {$0.value == card.value})
        return canToss != nil
    }
    
    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        let handValuesSet = valueToSet(cards: hand!)
        let firstTurnSet = valueToSet(cards: Array(table.keys))
        let secondTurnSet = valueToSet(cards: Array(table.values))
        return !handValuesSet.intersection(firstTurnSet).isEmpty || !handValuesSet.intersection(secondTurnSet).isEmpty
    }
    
    private func valueToSet(cards: [Card]) -> Set<Value> {
        return Set(cards.map{$0.value})
    }
}

