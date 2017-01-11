class RestaurantTagsController < ApplicationController
  def index
    @q = RestaurantTag.ransack(params[:q])
    @restaurant_tags = @q.result(:distinct => true).includes(:restaurant, :tag).page(params[:page]).per(10)

    render("restaurant_tags/index.html.erb")
  end

  def show
    @restaurant_tag = RestaurantTag.find(params[:id])

    render("restaurant_tags/show.html.erb")
  end

  def new
    @restaurant_tag = RestaurantTag.new

    render("restaurant_tags/new.html.erb")
  end

  def create
    @restaurant_tag = RestaurantTag.new

    @restaurant_tag.restaurant_id = params[:restaurant_id]
    @restaurant_tag.tag_id = params[:tag_id]

    save_status = @restaurant_tag.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurant_tags/new", "/create_restaurant_tag"
        redirect_to("/restaurant_tags")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant tag created successfully.")
      end
    else
      render("restaurant_tags/new.html.erb")
    end
  end

  def edit
    @restaurant_tag = RestaurantTag.find(params[:id])

    render("restaurant_tags/edit.html.erb")
  end

  def update
    @restaurant_tag = RestaurantTag.find(params[:id])

    @restaurant_tag.restaurant_id = params[:restaurant_id]
    @restaurant_tag.tag_id = params[:tag_id]

    save_status = @restaurant_tag.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurant_tags/#{@restaurant_tag.id}/edit", "/update_restaurant_tag"
        redirect_to("/restaurant_tags/#{@restaurant_tag.id}", :notice => "Restaurant tag updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant tag updated successfully.")
      end
    else
      render("restaurant_tags/edit.html.erb")
    end
  end

  def destroy
    @restaurant_tag = RestaurantTag.find(params[:id])

    @restaurant_tag.destroy

    if URI(request.referer).path == "/restaurant_tags/#{@restaurant_tag.id}"
      redirect_to("/", :notice => "Restaurant tag deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Restaurant tag deleted.")
    end
  end
end
