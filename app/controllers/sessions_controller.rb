class SessionsController < ApplicationController
  skip_before_action :authenticate_user

	def create
		resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
			req.params['client_id'] = ENV['CLIENT_ID']
			req.params['client_secret'] = ENV['CLIENT_SECRET']
			req.params['code'] = params[:code]
		end
		session[:token] = resp.body.gsub("access_token=", "").split('&')[0]
		redirect_to root_path
  end
end
