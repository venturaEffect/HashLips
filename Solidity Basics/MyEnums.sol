// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyEnums {
    enum Suit {
        Spades,
        Clubs,
        Diamonds,
        Hearts
    } 

    enum Value {
        Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, King, Queen, Ace
    }

    struct Card {
        Suit suit;
        Value value;
    }

    Card public myCard;

    function pickCard(Suit _suit, Value _value) public returns(Suit, Value) {
        myCard.suit = _suit;
        myCard.value = _value;
        return (myCard.suit, myCard.value);
    }
}