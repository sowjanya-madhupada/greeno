class GalleryController < ApplicationController
  def index
    @plants = Store.all
    return @plants if params[:q].blank? && params[:filter]=="All"
    @plants = @plants.where("name like? ","%"+params[:q].to_s+"%") if params[:q]
    filter_array = ["Flowers","Indoor","Outdoor","Gifts"]
    if filter_array.any?(params[:filter])
      @plants = @plants.where("plants_type like? ","%"+params[:filter].to_s+"%")
    elsif !(params[:filter]=="All")
      @plants = @plants.where("season like? ","%"+params[:filter].to_s+"%")
    end 
  end
end
