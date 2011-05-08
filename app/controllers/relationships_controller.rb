class RelationshipsController < ApplicationController
  # GET /relationships
  def index
    @user = User.find params[:format]    
  end
  
  # POST /create
  def create
    @relationship = current_user.relationships.build(:related_user_id => params[:format])
    if @relationship.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  
  def destroy
    @relationship = current_user.friendships.find(params[:id])
    @relationship.destroy
    
    redirect_to current_user
  end
end