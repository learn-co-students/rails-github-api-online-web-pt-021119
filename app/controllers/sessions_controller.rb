class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    client_id = ENV["GITHUB_CLIENT"]
    client_secret = ENV["GITHUB_SECRET"]
    code = params["code"]
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
      req.headers['Accept'] = 'application/json'
    end
    session[:token] = JSON.parse(resp.body)["access_token"]

    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    session[:username] = JSON.parse(resp.body)["login"]
    redirect_to '/'
  end
end
