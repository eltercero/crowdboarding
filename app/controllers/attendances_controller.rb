class AttendancesController < ApplicationController
  load_and_authorize_resource
  # POST /create
  def create
    @event = Event.find(params[:event_id])
    @attendance = current_user.attendances.build(:event_id => @event.id)
    if @attendance.save
      redirect_to @event
    else
      flash[:error] = "Error"
      redirect_to @event
    end
  end
  
  def destroy
    @attendance = current_user.attendances.find(params[:id])
    event = @attendance.event
    @attendance.destroy
    
    redirect_to event
  end
end