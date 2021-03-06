#require 'rails_helper'

RSpec.describe GameDestroyer do
  let(:winner_id) { double 'winner id' }
  let(:loser_id) { double 'loser id' }
  let(:game_id) { double 'game id' }

  let(:winner_rating) { double 'winner rating' }
  let(:loser_rating) { double 'loser rating' }

  let(:winner) { double 'winner', id: winner_id, rating: winner_rating }
  let(:loser) { double 'loser', id: loser_id, rating: loser_rating }
  let(:bad_game) { double 'game', id: game_id, winner_rating: winner_rating, loser_rating: loser_rating }

  subject { described_class.new(bad_game) } 
  
  describe '#undo!' do
    

    context 'valid' do
        
      it 'rollsback the winner rating' do

      end

      it 'rollsback the loser rating' do

      end

      it 'deletes the game' do

      end
    end
    
  end
end

__END__
  #add two games
  #check the ratings
  #undo the second game
  #check the ratings
  #confirm that game was deleted
  it 'keeps correct player ratings and deletes game on undo' do
    winner = Player.create!(name: 'winner', rating: 1000)
    loser = Player.create!(name: 'loser', rating: 1000)
    creator = GameCreator.new(winner.id, loser.id)
    good_game = creator.game
    expect(creator.save).to eq true
    winner.reload
    loser.reload
    
    expect(winner.rating).to eq 1025
    expect(loser.rating).to eq 975

    creator_of_bad_game = GameCreator.new(winner.id, loser.id)
    expect(creator_of_bad_game.save).to eq true
    bad_game = creator_of_bad_game.game
    expect(GameDestroyer.new(good_game).undo_game!).to be false
    last_game = Game.last
    expect(bad_game).to eq last_game
  
    winner.reload
    loser.reload
    expect(winner.rating).to eq 1047
    expect(loser.rating).to eq 953
    
    destroyer = GameDestroyer.new(bad_game)
    
    expect(destroyer.undo_game!).to be true
    expect(bad_game.persisted?).to be false 
    winner.reload
    loser.reload
    expect(winner.rating).to be 1025
    expect(loser.rating).to be 975
  end
