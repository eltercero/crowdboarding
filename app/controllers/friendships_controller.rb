class FriendshipsController < ApplicationController
  load_and_authorize_resource
  # GET /friendships
  def index
    @user = User.find params[:user_id]
  end
  
  # POST /create
  def create
    user = User.find(params[:user_id])
    @friendship = current_user.friendships.build(:friend => user)
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to(user, :notice => 'Friendship was successfully created.') }
      else
        format.html { redirect_to(user, :error => 'Friendship was not created.') }
      end
    end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    
    redirect_to current_user
  end
end