class GroupsController < ApplicationController
  def index
  	#flash[:notice] = "Morning!"
  	#flash[:alert] = "Good night"
  	#flash[:warning] = "This is a warning message"
  	@groups = Group.all
  end	

  def show
  	@group = Group.find(params[:id])
  end

  def new
  	@group = Group.new
  end

  def edit
  	@group = Group.find(params[:id])
  end

  def create
  	@group = Group.create(group_params)

  	if @group.save
  		redirect_to groups_path
  	else
  		render :new
  	end
  end

  def update
  	@group = Group.find(params[:id])

  	if @group.update(group_params)
  		redirect_to groups_path, notice: "Edit success"
  	else  		
  		render :edit
  	end
  end

  def destroy 
  	@group = Group.find(params[:id])
  	@group.destroy
  	redirect_to groups_path, alert: "The discuss board has been delete"
  end
  
  private

  def group_params
  	params.require(:group).permit(:title, :description)
  end
end
