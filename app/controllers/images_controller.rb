
include SmartListing::Helper::ControllerExtensions
class ImagesController < ApplicationController
  helper  SmartListing::Helper


  def index
    # @images = Image.order(:created_at)
    # @images = smart_listing_create(:images, Image.active, partial: "images/listing")
    smart_listing_create :images,
                       Image.all,
                       partial: "images/list",
                       default_sort: {created_at: "asc"}
  end

  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image
    else
      render 'new'
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
  @image = Image.find(params[:id])
    if @image.update(image_params)
      redirect_to @image
    else
      render 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to images_path
  end

  private

  def image_params
    params.require(:image).permit(:url, :site)
  end

end
