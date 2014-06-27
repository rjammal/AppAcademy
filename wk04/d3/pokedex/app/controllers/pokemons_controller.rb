class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all

    # with no render specified, it assumes there is a view with the same name
    render 'index'
  end

  def new

    render 'new'
  end

  def show
    @pokemon = Pokemon.find(params[:id])

    render 'show'
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      redirect_to :show
    else
      flash.now[:errors] = @pokemon.errors.full_messages
      render 'new'
    end
  end

  private 
  def pokemon_params
    params.require(:pokemon).permit(:type1, :type2, :gender, :name) 
  end
end
