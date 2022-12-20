class GalleryController < ApplicationController
  def index
    @plants = Store.all
  end

  def search
  end
end
