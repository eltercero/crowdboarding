class AttendancesController < ApplicationController
  load_and_authorize_resource
  # POST /create
  def create
    @event = Event.find(params[:event_id])
    @attendance = current_user.attendances.build(:event_id => @event.id)
    respond_to do |format|
      if @attendance.save
        format.html { redirect_to(@event, :notice => 'You successfully joined the event.') }
      else
        format.html { redirect_to(@event, :error => 'There was an error.') }
      end
    end
  end
  
  def destroy
    @attendance = current_user.attendances.find(params[:id])
    event = @attendance.event
    @attendance.destroy
    
    redirect_to event, :notice => 'You successfully stopped attending the event'
  end
end