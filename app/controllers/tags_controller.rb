class TagsController < ApplicationController
  def index
    @tags = Tag.where(["name LIKE ?", "%#{params[:q]}%"])
    respond_to do |format|
      format.html
      format.json { render :json => @tags.map(&:attributes) }
    end
  end
  
  def show
    @tag = Tag.find(params[:id])
    @events = Event.tagged_with(@tag.name).page(params[:page]).per(10)
  end
end