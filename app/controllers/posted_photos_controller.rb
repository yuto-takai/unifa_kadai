class PostedPhotosController < ApplicationController
  before_action :login_check

  def index
    @posted_photos = PostedPhoto.all.order(created_datetime: "DESC") 
  end

  def new
    @new_photo = PostedPhoto.new
  end

  def create
  end
end
