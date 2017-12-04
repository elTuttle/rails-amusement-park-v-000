class AttractionsController < ApplicationController

  def index
    if !session[:user_id].nil?
      @user = User.find(session[:user_id])
      @attractions = Attraction.all
      if @user.admin
        @attraction = Attraction.new
      end
    end
  end

  def new
    @attraction = Attraction.new
  end

  def show
    @attraction = Attraction.find(params[:id])
    @user = User.find(session[:user_id])
  end

  def create
    #binding.pry
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    binding.pry
    @attraction = Attraction.update(attraction_params)
    binding.pry
    redirect_to attraction_path(@attraction)
  end

  def ride
    if !session[:user_id].nil?
      @attraction = Attraction.find(params[:id])
      @user = User.find(session[:user_id])
      ride = Ride.create(user_id: @user.id, attraction_id: @attraction.id)
      if @user.tickets < @attraction.tickets && @user.height < @attraction.min_height
        flash[:message] = "Sorry. You do not have enough tickets to ride the #{@attraction.name}. You are not tall enough to ride the #{@attraction.name}."
        redirect_to user_path(@user)
      elsif @user.tickets < @attraction.tickets
        flash[:message] =  "Sorry. You do not have enough tickets to ride the #{@attraction.name}."
        redirect_to user_path(@user)
      elsif @user.height < @attraction.min_height
        flash[:message] =  "Sorry. You are not tall enough to ride the #{@attraction.name}."
        redirect_to user_path(@user)
      else
        #binding.pry
        new_tickets = @user.tickets - @attraction.tickets
        new_happiness = @user.happiness + @attraction.happiness_rating
        new_nausea = @user.nausea + @attraction.nausea_rating
        @user.update(tickets: new_tickets, happiness: new_happiness, nausea: new_nausea)
        flash[:message] =  "Thanks for riding the #{@attraction.name}!"
        redirect_to user_path(@user)
      end
    else
      redirect_to '/'
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height )
  end

end
