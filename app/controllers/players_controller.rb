class PlayersController < ApplicationController
  def new
  end

  def index
    @players = Player.search(params[:search]) 
    @players = @players.paginate(:page => params[:page])
  end

  def index_intro
    @players = nil
  end

  def show
    pRel = Player.where(id: params[:id])
    @player = pRel[0]
  end
end
