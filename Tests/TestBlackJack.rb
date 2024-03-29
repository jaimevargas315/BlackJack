require 'minitest/autorun'
require './BlackJack'

class TestBlackJack < Minitest::Test
  def test_Card
    card = Card.new("Hearts", "Queen", 10)
    assert_equal "Hearts", card.suit , "Card suit creation failed"
    assert_equal "Queen", card.face , "Card face creation failed"
    assert_equal 10, card.value , "Card value creation failed"
  end

  def test_Player
    deck1 = Deck.new
    card1 = deck1.deck.pop
    card2 = deck1.deck.pop
    player = Player.new("Jaime", 500, [card1, card2])
    assert_equal "Jaime", player.name , "Player name creation failed"
    assert_equal 500, player.money, "Player money creation failed"
    assert_equal [card1, card2], player.hand, "Player hand creation failed"
  end

  def test_House
    deck1 = Deck.new
    card1 = deck1.deck.pop
    card2 = deck1.deck.pop
    house = House.new([card1, card2])
    assert_equal [card1, card2], house.hand, "House hand creation failed"
  end
end
