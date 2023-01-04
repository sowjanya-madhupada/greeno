class GalleryController < ApplicationController
  def index
    @plants = Store.where.not(quantity: 0)
    return @plants unless params[:q] && params[:filter]
    @plants = @plants.where("name like? ","%"+params[:q]+"%") if params[:q]
    filter_array = ["Flowers","Indoor","Outdoor","Gifts"]
    if filter_array.any?(params[:filter])
      @plants = @plants.where("plants_type like? ","%"+params[:filter]+"%")
    elsif !(params[:filter]=="All")
      @plants = @plants.where("season like? ","%"+params[:filter]+"%")
    end 
  end
end
