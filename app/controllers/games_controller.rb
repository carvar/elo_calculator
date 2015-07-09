class GamesController < ApplicationController
  def index
    @games = Game.includes(:winner, :loser).most_recent
  end

  def new
  end

  def create
    creator = GameCreator.new(game_params[:winner_id], game_params[:loser_id])

    if creator.save
      @game = creator.game
      redirect_to @game
    else
      flash.now[:alert] = creator.errors.full_messages.join('. ')
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def destroy
    bad_game = Game.find(params[:id])
    destroyer = GameDestroyer.new(bad_game)

    if destroyer.undo_game!
      redirect_to new_game_path, notice: 'Game Destroyed'
    else
      flash.now[:alert] = destroyer.errors.full_messages.join('. ')
      render :show
    end
  end

  private

  def game_params
    params.require(:game).permit(:winner_id, :loser_id)
  end
end
