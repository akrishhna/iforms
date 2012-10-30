class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.user_id = current_user.id
    if @profile.save
      flash[:success] = 'Profile saved successfully'
      service_provider = current_user.service_providers.first
      if service_provider.nil?
        redirect_to :controller => "consumer", :action => "index"
      elsif service_provider.id == 2
        redirect_to  girl_scouts_troop_leaders_path
      else
        redirect_to :controller => "consumer", :action => "index"
        end
    end
  end

  def edit
    @profile = Profile.find(params[:id]) rescue nil
    if @profile.nil?
      @troop_leader_profile = GirlScoutTroopLeaderProfile.find(params[:id])
      @profile = Profile.create(:user_id => current_user.id, :first_name => @troop_leader_profile.first_name, :last_name => @troop_leader_profile.last_name)
    end
  end

  def update
   @profile = Profile.find(params[:id])
   @troop_leader_profile = GirlScoutTroopLeaderProfile.find_by_user_id(@profile.user_id)
    if @profile.update_attributes(params[:profile])
      flash[:success] = 'Profile Updated successfully'
      service_provider = current_user.service_providers.first
      if service_provider.nil?
        redirect_to :controller => "consumer", :action => "index"
      elsif service_provider.id == 2
        @troop_leader_profile.update_attributes(params[:profile])
        redirect_to girl_scouts_troop_leaders_path
      else
        redirect_to :controller => "consumer", :action => "index"
      end
    else
      render :edit, :notice => "Something wrong please try again"
    end
  end
end
