class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get "https://github.com/login/oauth/access_token" do |req|
      req.params
    end
  end
end
