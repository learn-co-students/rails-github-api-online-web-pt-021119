class RepositoriesController < ApplicationController

  def index
    user_response = Faraday.get "https://api.github.com/user" do |req|
      req.headers = { 'Authorization': "token #{session[:token]}", 'Accept': 'application/json' }
    end

    user_body = JSON.parse(user_response.body)

    @username = user_body['login']

    repo_response = Faraday.get "https://api.github.com/user/repos?per_page=100" do |req|
      req.headers = { 'Authorization': "token #{session[:token]}", 'Accept': 'application/json' }
    end

    @repo_body = JSON.parse(repo_response.body)

  end

  def create
    new_repo = params["name"].split(" ").join("-")

    x = Faraday.post "https://api.github.com/user/repos" do |req|
      req.body = { 'name': new_repo }.to_json
      req.headers = { 'Authorization': "token #{session[:token]}" }
    end

    binding.pry

    redirect_to root_path

  end

end
