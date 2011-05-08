class RelationshipsController < ApplicationController
  # GET /relationships
  def index
    @user = User.find params[:user_id]
  end
  
  # POST /create
  def create
    user = User.find(params[:user_id])
    @relationship = current_user.relationships.build(:related_user_id => user.id)
    respond_to do |format|
      if @relationship.save
        format.html { redirect_to(user, :notice => 'Relationship was successfully created.') }
      else
        format.html { redirect_to(user, :error => 'Relationship was not created.') }
      end
    end
  end
  
  def destroy
    @relationship = current_user.friendships.find(params[:id])
    @relationship.destroy
    
    redirect_to current_user
  end
end