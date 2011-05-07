class AttendancesController < ApplicationController
  # POST /create
  def create
    @event = Event.find params[:format]
    @attendance = current_user.attendances.build(:event_id => params[:format])
    if @attendance.save
      redirect_to @event
    else
      redirect_to root_url
    end
  end
  
  def destroy
    @attendance = current_user.attendances.find(params[:id])
    event = @attendance.event
    @attendance.destroy
    
    redirect_to event
  end
end