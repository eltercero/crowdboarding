class AttendancesController < ApplicationController
  # POST /create
  def create
    @event = Event.find params[:format]
    @attendance = current_user.attendances.build(:event_id => params[:format])
    if @attendance.save
      redirect_to event_path(@event)
    else
      redirect_to root_url
    end
  end
  
  def destroy
    @attendance = Attendance.find(:all, :conditions => ["event_id = ? AND user_id = #{current_user.id}", params[:id]]).first
    @attendance.destroy
    
    redirect_to current_user
  end
end