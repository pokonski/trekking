class RoutesController < ApplicationController
  load_and_authorize_resource

  def index
    @routes = Route.order_by([:created_at,:desc]).page params[:page]

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @routes }
    end
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @route }
    end
  end

  # GET /routes/new
  # GET /routes/new.json
  def new
    @route = Route.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @route }
    end
  end

  # GET /routes/1/edit
  def edit

  end

  # POST /routes
  # POST /routes.json
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

  # PUT /routes/1
  # PUT /routes/1.json
  def update

    if params[:route][:waypoints]
      @route.waypoints.delete_all
      for waypoint in params[:route][:waypoints]
        @route.waypoints << Waypoint.new(waypoint[1])
      end
    end
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
    route = Route.find(params[:id])
    route.waypoints.delete_all
    if params[:route]
      for waypoint in params[:route][:waypoints]
        route.waypoints << Waypoint.new(waypoint[1])
      end
    end

    respond_to do |format|
      format.json {head :ok}
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route = Route.find(params[:id])
    @route.destroy

    respond_to do |format|
      format.html { redirect_to routes_url }
      format.json { head :ok }
    end
  end
end
