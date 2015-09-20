class GroupsController < ApplicationController
   before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def index
  	#flash[:notice] = "Morning!"
  	#flash[:alert] = "Good night"
  	#flash[:warning] = "This is a warning message"
  	@groups = Group.all
  end	

  def show
  	@group = Group.find(params[:id])
       @posts = @group.posts
  end

  def new
  	@group = Group.new
  end

  def edit
  	@group = current_user.groups.find(params[:id])
  end

  def create
  	@group = current_user.groups.new(group_params)

  	if @group.save
              current_user.join!(@group)
  		redirect_to groups_path
  	else
  		render :new
  	end
  end

  def update
  	@group = current_user.groups.find(params[:id])

  	if @group.update(group_params)
  		redirect_to groups_path, notice: "Edit success"
  	else  		
  		render :edit
  	end
  end

  def destroy 
  	@group = current_user.groups.find(params[:id])
  	@group.destroy
  	redirect_to groups_path, alert: "The discuss board has been delete"
  end
  
  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "Add discuss board success!"
    else
      flash[:warning] = "You are already discuss board member!"
    end
    redirect_to group_path(@group)
  end

   def quit
      @group = Group.find(params[:id])

      if current_user.is_member_of?(@group)
        current_user.quit!(@group)
        flash[:alert] = "Quit discuss board success!"
      else
        flash[:warning] = "You are not discuss board member!"
      end

      redirect_to group_path(@group)
    end

  private

  def group_params
  	params.require(:group).permit(:title, :description)
  end
end
