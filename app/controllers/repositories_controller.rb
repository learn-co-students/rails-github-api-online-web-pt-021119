class RepositoriesController < ApplicationController

  def index
    client_id = ENV['GITHUB_CLIENT']
    client_secret = ENV['GITHUB_SECRET']
    auth_token = session[:token]

    user_response = Faraday.get "https://api.github.com/user" do |req|
      req.headers = {'Authorization': "token #{auth_token}", 'Accept': 'application/json'}
    end

    user_body = JSON.parse(user_response.body)

    @username = user_body['login']

    repo_response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers = {'Authorization': "token #{auth_token}", 'Accept': 'application/json'}
      req.headers['Accept'] = 'application/json'
    end

    @repo_body = JSON.parse(repo_response.body)

  end

end
