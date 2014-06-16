class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def new
    @character = Character.new
  end

  def create
    @television_show = TelevisionShow.find(params[:television_show_id])

    @character = Character.new(character_params)

    @character.television_show = @television_show

    @character.television_show_id = params[:television_show_id]

    if @character.save
      flash[:notice] = "Success Character Saved!"
      redirect_to @television_show
    else
      flash.now[:notice] = "Your character couldn't be saved."
      render :'television_shows/show'
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :actor, :description)
  end
end
