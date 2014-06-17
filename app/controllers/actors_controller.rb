class ActorsController < ApplicationController
  def index
    @actors = Actor.all
  end

  def show

  end

  def new
    @actor = Actor.new
  end

  def create

  end
end
