class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :login, :newuser, :createuser]
  def new
  end

  def show
    @user = User.find(session[:userid])
    @secrets = User.find(session[:userid]).secrets
  end

  def login
    user = User.find_by(email: params[:Email])
    if user && user.authenticate(params[:Password])
       
      session[:userid] = user.id
      redirect_to "/users/#{user.id}"

       
    else
     
      session[:userid] = nil
      flash[:error] = "Invalid Combination"
      redirect_to '/sessions/new'
    end
  end

  def logout
    session[:userid] = nil
    redirect_to '/sessions/new'
  end

  def newuser

  end

  def createuser
    # if (params[:Name] == "" && params[:Email] == "" && params[:Password] == "" && params[:Password_Confirmation] == "") 
    #   flash[:error] = "can't be blank"
    #   redirect_to '/users/new'
    if params[:Name] == "" || params[:Email] == "" || params[:Password] == "" || params[:Password_Confirmation] ==""
      flash[:error] = "can't be blank"
      
      redirect_to '/users/new'
    else
      if params[:Password] == params[:Password_Confirmation]
      user = User.create(name: params[:Name], email: params[:Email], password: params[:Password])
      session[:userid] = user.id
      redirect_to "/users/#{user.id}"
      else
      redirect_to "/sessions/new"
      end

    end

  
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(name: params[:Name], email: params[:Email])

    if user.save

      @user = User.find(params[:id])
      redirect_to "/users/#{params[:id]}"
    else
      # puts "============"
      # puts user.errors.full_messages
      # puts "============="
      flash[:error] = user.errors.full_messages
      redirect_to "/users/#{params[:id]}/edit"

    end

  end

  def delete
    user = User.find(params[:id])
    user.destroy
    session[:userid] = nil
    redirect_to "/users/new"
  end
end
