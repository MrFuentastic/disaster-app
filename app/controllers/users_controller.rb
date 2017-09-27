class UsersController < ApplicationController

  def new

  end

  def create
    user = User.new(
                    name: params[:name],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation],
                    lat: params[:lat],
                    long: params[:long]
                    )
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Successfully created account"
      redirect_to "/users/#{user.id}"
    else
      flash[:warning] = "Invalid email or password"
      redirect_to '/signup'
    end
  end

  def show
    @user = User.find(params[:id])
  end
#TODO - user editing after password confirmation
  def edit
  end

  def update
  end
end
