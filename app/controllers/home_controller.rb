class HomeController < ApplicationController
  
  def index
    
  end
  
  def user
  @user = User.find(params[:id])
  end
  
end
