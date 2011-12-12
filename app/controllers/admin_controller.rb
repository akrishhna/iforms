class AdminController < ApplicationController
  before_filter :is_admin?
  def index
  end

end
