class Card
  attr_accessor :suit
  attr_accessor :face
  attr_accessor :value

  def initialize(suit,face, value)
    @suit = suit
    @face = face
    @value = value

  end
end

class House
  attr_accessor :hand

  def initialize(hand)
    @hand = hand
  end
end

class Player
attr_accessor :name
attr_accessor :money
attr_accessor :hand

  def initialize(name,money, hand)
    @name = name
    @money = money
    @hand = hand
  end
end

class Deck
  attr_accessor :deck
  def initialize
  holder = []
  suits = ["Spades","Diamonds","Hearts","Clubs"]
  faces = ["Ace",2,3,4,5,6,7,8,9,10,"Jack","Queen","King"]

    suits.each do |suit|
      faces.each do |face|
        value = 0
        if(face == "Jack" || face == "Queen" || face == "King")
          value = 10
        elsif(face == "Ace")
          value = 11
        else 
          value = face
        end
        card = Card.new(suit, face, value)
        holder << card
      end
    end
    @deck = holder.shuffle
  end
end


pp "Welcome to the DPI Casino. May I have your name?"
your_name = gets
your_name = your_name.delete("\n")
pp "Hello, #{your_name}. Let's play some BlackJack"

deck1 = Deck.new
player1 = Player.new(your_name, 500, [deck1.deck.pop, deck1.deck.pop])

play = "1"
while play == "1"

  deck1 = Deck.new
  player1.hand = [deck1.deck.pop, deck1.deck.pop]

  bust = false

  pp "What's your wager? You have $#{player1.money}"
  wager = gets.to_i

  while wager < 0 || wager > player1.money
    pp "Very funny, what's your actual wager?"
    wager = gets.to_i
  end

  pp "Dealing..."
  sleep(3)

  house1 = House.new([deck1.deck.pop, deck1.deck.pop])
  pp "The house has the #{house1.hand[0].face} of #{house1.hand[0].suit} and the #{house1.hand[1].face} of #{house1.hand[1].suit}"
  pp "You have the #{player1.hand[0].face} of #{player1.hand[0].suit} and the #{player1.hand[1].face} of #{player1.hand[1].suit}"

  pp "Enter '1' to hit, enter '2' to pass"
  hit = gets
  hit = hit.delete("\n")

  playerTotal = 0
  player1.hand.each do |sum|   
    playerTotal += sum.value  
  end
   

  while hit=="1"
    statement = "You have "
    player1.hand.push(deck1.deck.pop)
    player1.hand.each do |print|
      statement += "the #{print.face} of #{print.suit} "
    end


    total = 0
    player1.hand.each do |sum|   
      total += sum.value  
    end

    player1.hand.each do |aceCheck|
      if aceCheck.face == "Ace" && total>21
        total = total - 10
      end
    end
    pp statement
    sleep(3)
    pp "Your total is #{total}"
    playerTotal = total

    if(total > 21)
     pp "Bust! You lose $#{wager}."
     bust = true
     player1.money -= wager
     break
    end

    pp "Enter '1' to hit, enter '2' to pass"
    hit = gets
    hit = hit.delete("\n")
  end

  houseTotal = 0
  while hit == "2"

    soft17 = false

    total = 0
    house1.hand.each do |sum|   
     total += sum.value  
    end

    house1.hand.each do |aceCheck|
      if aceCheck.face == "Ace"
        soft17 = true
      end
      if aceCheck.face == "Ace" && total>21
        total = total - 10
      end
    end

    pp "House total is #{total}"
    houseTotal = total

    if(total > 21)
      pp "Bust! You win $#{wager}"
      bust = true
      player1.money += wager
     break
    end

    if total==17 && soft17 == true
      #continue
    end

    if(total==17 && soft17 == false)
     break
    end

    if(total>17)
      break
    end

   sleep(3) 
   statement = "House has " 
   house1.hand.push(deck1.deck.pop)
   house1.hand.each do |print|
      statement += "the #{print.face} of #{print.suit} "
    end

   pp statement
   sleep(2)
  end

  if(playerTotal > houseTotal && bust == false)
    pp "#{playerTotal} against #{houseTotal}. You win $#{wager}"
    player1.money += wager
  end

  if(houseTotal > playerTotal && bust == false)
    pp "#{houseTotal} against #{playerTotal}. You lose $#{wager}"
    player1.money -= wager
  end

  if(houseTotal == playerTotal && bust == false)
   pp "#{houseTotal} against #{playerTotal}. No one wins."
  end

  if player1.money == 0
    pp "You have $#{player1.money}"
    pp "The house always wins."
    pp "Game over."
    break
  end

  pp "Enter 1 to play again"
  play = gets
  play= play.delete("\n")

end
