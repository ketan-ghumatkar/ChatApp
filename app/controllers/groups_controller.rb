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

  def show
    @group = Group.find_by_id(params[:id])
  end

  def join
    @group = Group.find_by_id(params[:id])
    @group.users << current_user
    flash[:notice] = "You have joined group #{@group.name}. Start chatting with your friends"
    redirect_to group_path(@group)
  end

  def leave
    @group = Group.find_by_id(params[:id])
    @group.users.delete current_user
    flash[:notice] = "You have leaved group #{@group.name}. Start chatting with your friends"
    redirect_to groups_path
  end

  private
    def permitted_params
    	params.require(:group).permit(:name, user_ids: [])
    end
end
