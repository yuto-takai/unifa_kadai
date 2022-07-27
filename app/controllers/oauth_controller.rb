class OauthController < ApplicationController
  def callback    
    fetch_token_reqest
    session[:access_token] = fetch_token_reqest

    redirect_to posted_photos_path
  end

  def tweet

    uri = URI.parse("https://arcane-ravine-29792.herokuapp.com/api/tweets")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = { 
      "Content-Type" => "application/json",
      "Authorization" => "bearer #{session[:access_token]}"
    }

    request_body = {
      text: tweet_params[:title],
      url: "http://localhost:3000#{tweet_params[:image]}"
    }.to_json

    response = http.post(uri.path, request_body, headers)

    



    uri = URI('https://arcane-ravine-29792.herokuapp.com/api/tweets')

    res = Net::HTTP.post_form(
      uri,
      body: request_body,
    )
    
  end

  private

  def fetch_access_token
    request_params = {
      client_id: 'd7c39097d19b5efe7fce7f8f4fe63ead3a6ba5b79fa09f0f60cc221e3fd03f0d',
      client_secret: 'fa7911ce9538873b1694d18a473be2d35d44cc620c1b73ccc1f889fed374e73a',
      redirect_uri: 'http://localhost:3000/oauth/callback',
      code: params[:code],
      grant_type: 'authorization_code'
    }
    uri = URI('https://arcane-ravine-29792.herokuapp.com/oauth/token')
    res = Net::HTTP.post_form(
      uri,
      request_params
    )
    JSON.parse(res.body)['access_token']
  end

  def tweet_params
    params.require(:posted_photo).permit(:title, :image)
  end
end