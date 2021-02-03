class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => ENV['secret_user'], :password => ENV['secret_password']

  
  def show
  end
end
