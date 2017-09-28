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
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(
                name: params[:name],
                email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation],
                lat: params[:lat],
                long: params[:long]
                )
    redirect_to "/users/#{user.id}"
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to '/'    
  end
end
