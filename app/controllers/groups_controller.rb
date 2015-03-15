class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@groups = Group.all
  end

  def new
  	@group = Group.new
  end

  def create
  	@group = Group.new(permitted_params)

  	if @group.save
  		respond_to do |format|
  			format.html { redirect_to groups_path }
  			format.json { render json: group }
  		end
  	else
  		respond_to do |formate|
  			format.html { render :new }
  			format.json { render json: @group.errors }
  		end
  	end

  end

  def edit
  	@group = Group.find_by_id(params[:id])
  end

  def update
  	@group = Group.new(permitted_params)

  	if @group.save
  		respond_to do |format|
  			format.html { redirect_to groups_path }
  			format.json { render json: @group }
  		end
  	else
  		respond_to do |formate|
  			format.html { render :new }
  			format.json { render json: @group.errors }
  		end
  	end
  end

  private
    def permitted_params
    	params.require(:group).permit(:name, user_ids: [])
    end
end
