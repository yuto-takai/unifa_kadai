require 'uri'
class PostedPhotosController < ApplicationController
  before_action :login_check

  def index
    @posted_photos = PostedPhoto.all.order(created_datetime: 'DESC')
    @auth_req_url = auth_req_url
  end

  def new
    @posted_photo = PostedPhoto.new
  end

  def create
    file = posted_photo_params[:image]
    file_name = file&.original_filename
    @posted_photo = PostedPhoto.new(title: posted_photo_params[:title], image: file_name)
    if @posted_photo.save
      save_path = Rails.root.join('public/posted_photos', file_name)
      File.open(save_path, 'wb'){ |f| f.write(file.read) }
      redirect_to action: :index
    else
      render "new"
    end
  end

  private

  def posted_photo_params
    params.require(:posted_photo).permit(:title, :image)
  end

  def auth_req_url
    base_url = 'https://arcane-ravine-29792.herokuapp.com/oauth/authorize?'
    redirect_url_q = URI.encode_www_form(redirect_uri: 'http://localhost:3000/oauth/callback')
    response_type_q = URI.encode_www_form(response_type: 'code')
    client_id_q = URI.encode_www_form(client_id: 'd7c39097d19b5efe7fce7f8f4fe63ead3a6ba5b79fa09f0f60cc221e3fd03f0d')
    base_url + redirect_url_q + '&' + response_type_q + '&' + client_id_q
  end
end
