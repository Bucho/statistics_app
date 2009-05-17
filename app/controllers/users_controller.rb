class UsersController < ApplicationController
  
  def index
    redirect_to root_path
  end
  
  def show
    redirect_to root_path
  end
  
  def new
#    @user = User.new
    redirect_to root_path
  end
  
  def create
#    @user = User.new(params[:user])
#    if @user.save
#      flash[:notice] = "Registration successful."
#      redirect_to root_url
#    else
#      render :action => 'new'
#    end
    redirect_to root_path
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end
end
