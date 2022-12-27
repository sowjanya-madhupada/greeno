class GalleryController < ApplicationController
  def index
    @plants = Store.all
  end

  def search
    keyword = "%"+params[:search].to_s+"%"
    @plants = Store.find_by_sql ["Select * from stores WHERE name like? or season like? or plants_type like?",keyword,keyword,keyword]
  end
end
