class SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.get('https://github.com/login/oauth/access_token', {
      :client_id => ENV['CLIENT_ID'],
      :client_secret => ENV['CLIENT_SECRET'],
      :code => params[:code]}, {
        'Accept' => 'application/json'})
    session[:token] = JSON.parse(resp.body)["access_token"]
    user_response = Faraday.get("https://api.github.com/user", {}, {
<<<<<<< HEAD
      'Authorization' => "token #{session[:token]}",
=======
      'Authorization' => "token #{params[:code]}",
>>>>>>> e62e717b6f50f76a5736999658ef95404769a546
      'Accept' => 'application/json'})
    session[:username] = JSON.parse(user_response.body)["login"]

    redirect_to root_path
  end

end
