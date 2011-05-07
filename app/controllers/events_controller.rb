class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    @events = Event.recent.page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events }
    end
  end
  
  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    @attendance = current_user.attendance(@event)
    
    @json = @event.to_gmaps4rails

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @event }
    end
  end

  
  # GET /events/new
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  def create
    if params[:event] && params[:event][:starts_at].match(/^(\d{4})(\/|-)(\d{2})(\/|-)(\d{2})/)
      datetime_starts_at = Time.new($1, $3, $5, params[:event]["starts_at(4i)"], params[:event]["starts_at(5i)"] )
      params[:event]["starts_at(4i)"] = nil
      params[:event]["starts_at(5i)"] = nil
      params[:event][:starts_at] = nil
    end
    @event = current_user.events.new(params[:event])
    @event.starts_at = datetime_starts_at
    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /events/1
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
    end
  end
end