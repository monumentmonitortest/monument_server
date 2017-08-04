class ImagesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    @scope ||= Image.all
    options = {}
    options = options.merge(query: params[:filter]) if params[:filter].present?
    options = options.merge(filters: params[:f]) if params[:f].present?
    @scope = Image.all_with_filter(options, @scope)

    if params[:images_smart_listing] && params[:images_smart_listing][:page].blank?
      params[:images_smart_listing][:page] = 1
    end

    @images ||= smart_listing_create :images, @scope, partial: "images/list", page_sizes: [10, 25, 50]
  end

  def csv
    respond_to do |format|
      format.csv { send_data Image.all.to_csv, filename: "collection-#{Date.today}.csv" }
    end
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
      redirect_to images_path
    else
      render 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to images_path
  end

  def search
    render json: Image.where("LOWER(site) LIKE LOWER(?)", "%#{params[:q]}%")
  end


  private
  def set_image
    @image = Image.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:url, :site, :reliable, :twitter_id)
  end

end
