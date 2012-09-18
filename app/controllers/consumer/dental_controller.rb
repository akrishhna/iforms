class Consumer::DentalController < ApplicationController
  def index
    session["consumer_tab_index"] = 1
    render :layout => false if request.xhr?
  end
end
