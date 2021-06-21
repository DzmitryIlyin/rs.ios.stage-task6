import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public mutating func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var deckCards = [Card]()
        for suite in suits {
            for value in values {
                deckCards.append(Card(suit: suite, value: value))
            }
        }
        return deckCards
    }

    public mutating func shuffle() {
        cards.shuffle()
    }

    public mutating func defineTrump() {
        if let randomTrump = cards.last {
            trump = randomTrump.suit
            setTrumpCards(for: randomTrump.suit)
        }
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        let minCardsCount = 6
        if total / players.count >= minCardsCount {
            players.forEach {
                var arr = [Card]()
                while(arr.count < minCardsCount) {
                    arr.append(cards.popLast()!)
                }
                $0.hand = arr
            }
        }
    }

    public mutating func setTrumpCards(for suit:Suit) {
        for i in 0..<cards.count {
            if cards[i].suit == suit {
                cards[i].isTrump = true
            }
        }
    }
}

