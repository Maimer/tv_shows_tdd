class ActorsController < ApplicationController
  def index
    @actors = Actor.all
    @actor = Actor.new
  end

  def show
    @actor = Actor.find(params[:id])
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)

    if @actor.save
      flash[:notice] = "Success, Actor Saved!"
      redirect_to '/actors'
    else
      flash.now[:notice] = "Your actor couldn't be saved."
      render :index
    end
  end

  private

  def actor_params
    params.require(:actor).permit(:name)
  end
end
