class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_privileges!, only: [:show]

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create 
    @profile = Profile.new
    if @profile.create(profile_params) 

     redirect_to root_path
   else
     render :new
   end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params) 

     redirect_to root_path
   else
     render :edit
   end
  end

  def destroy 
  end

  private 

  def profile_params 
    params.require(:profile).permit(:first_name, :last_name, :description)
  end

  def check_privileges!
    redirect_to root_path, notice: "You dont have enough permissions" unless current_user == Profile.find(params[:id]).user
  end
end
