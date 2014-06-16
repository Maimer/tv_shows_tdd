class CharacterController < ApplicationController
  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)

    @character.television_show_id = params[:id]

    if @character.save
      flash[:notice] = "Success!"
      redirect_to "/television_shows/#{params[:id]}"
    else
      flash.now[:notice] = "Your character couldn't be saved."
      redirect_to "/television_shows/#{params[:id]}"
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :actor, :description)
  end
end
