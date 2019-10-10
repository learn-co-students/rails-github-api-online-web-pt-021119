class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get "https://api.github.com/user/repos", 
    {['Authorization'] => "token #{session[:token]}", 
    ['Accept'] => 'application/json' }
  end

end