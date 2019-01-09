class ImagesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    @scope ||= Image.all
    @scope = @scope.reliable if params[:reliable?] == "1"

    options = {}
    options = options.merge(query: params[:filter]) if params[:filter].present?
    options = options.merge(filters: params[:f]) if params[:f].present?
    
    @scope = Image.all_with_filter(options, @scope)

    if params[:images_smart_listing] && params[:images_smart_listing][:page].blank?
      params[:images_smart_listing][:page] = 1
    end

    @images ||= smart_listing_create :images, @scope, partial: "images/list", page_sizes: [10, 25, 50]
    # binding.pry
  end

  def new
    @image = Image.new
  end

  def show
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
  end

  def update
    @image.update_attributes(image_params)
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
  end

  def search
    render json: Image.where("LOWER(site) LIKE LOWER(?)", "%#{params[:q]}%")
  end


  private
  def set_image
    @image = Image.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:reliable, :source, :site, :category, :submission, :record_taken)
  end
end
