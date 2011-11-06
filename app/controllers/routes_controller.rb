class RoutesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new,:edit,:create,:update,:update_waypoints]
  def index
    @routes = Route.order_by([:created_at,:desc]).page params[:page]

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @routes }
    end
  end

  def search
    redirect_to near_routes_path(:address => params[:address].gsub(" ","+"))
  end

  def near
    radius = 6371
    distance = 50
    loc = Geocoder.coordinates(params[:address])
    if loc.nil?
      @routes = []
    else
      @routes = Route.where("waypoints.location" => {"$within" => {"$centerSphere" => [loc.reverse, (distance.fdiv radius)]}}).page params[:page]
    end

    respond_to do |format|
      format.html
      format.json { render json: @routes }
    end
  end


  def show
    @route = Route.find(params[:id])
    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @route }
    end
  end

  def new
    @route = Route.new
    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @route }
    end
  end

  def edit
    @route = Route.find(params[:id])
  end

  def create
    @route = Route.new(params[:route])
    @route.user = current_user

    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { head :ok }
      else
        format.html { render action: "new" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @route = Route.find(params[:id])
    respond_to do |format|
      if @route.update_attributes(params[:route])
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_waypoints
    @route = Route.find(params[:id])
    waypoints = []
    if params[:route]
      for waypoint in params[:route][:waypoints]
        w = Waypoint.new(:location => waypoint[1][:location].collect{|c| c.to_f})
        waypoints << w
      end
    end

   @route.waypoints = waypoints

    respond_to do |format|
      format.json {head :ok}
    end
  end

  def destroy
    @route = Route.find(params[:id])
    @route.destroy

    respond_to do |format|
      format.html { redirect_to routes_url }
      format.json { head :ok }
    end
  end
end
