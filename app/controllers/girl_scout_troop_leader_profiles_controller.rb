class GirlScoutTroopLeaderProfilesController < ApplicationController

  def new
    @profile = GirlScoutTroopLeaderProfile.new
  end

  def create
    @profile = GirlScoutTroopLeaderProfile.new(params[:girl_scout_troop_leader_profile])
    @profile.user_id = current_user.id
    if @profile.save
      flash[:success] = 'Profile saved successfully'
      redirect_to homepage_url
    else
      render :new, :notice => "Something wrong please try again"
    end
  end

  def edit
    @profile = GirlScoutTroopLeaderProfile.find(params[:id])
  end

  def update
    @profile = GirlScoutTroopLeaderProfile.find(params[:id])
    if @profile.update_attributes(params[:girl_scout_troop_leader_profile])
      flash[:success] = 'Profile Updated successfully'
      redirect_to homepage_url
    else
      render :edit, :notice => "Something wrong please try again"
    end
  end
end
