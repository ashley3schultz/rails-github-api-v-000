class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.get('https://github.com/login/oauth/access_token', {
      :client_id => 'b2c1d48b8d0cedb3e062',
      :client_secret => 'bd32ab4044c68851b047adde1bbb8d5c342bfa9f',
      :code => params[:code]}, {
        'Accept' => 'application/json'})
    session[:token] = JSON.parse(resp.body)["access_token"]
    user_response = Faraday.get("https://api.github.com/user", {}, {
      'Authorization' => "token #{session[:token]}",
      'Accept' => 'application/json'})
    session[:username] = JSON.parse(user_response.body)["login"]

    redirect_to root_path
  end

end
