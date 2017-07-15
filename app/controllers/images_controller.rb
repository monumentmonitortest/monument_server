
class ImagesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper


  def index
    images_scope = Image.all
    images_scope = images_scope.like(params[:filter]) if params[:filter]

    if params[:images_smart_listing] && params[:images_smart_listing][:page].blank?
      params[:images_smart_listing][:page] = 1
    end

    @images = @images ||= smart_listing_create :images, images_scope, partial: "images/list"
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
