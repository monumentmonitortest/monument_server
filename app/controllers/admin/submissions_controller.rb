# frozen_string_literal: true

module Admin
  class SubmissionsController < ApplicationController
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper
    before_action :set_submission, only: %i[show edit update destroy]
    before_action :redirect_unless_admin
    respond_to :js, only: :create

    def index
      # TODO - move this to a service
      submissions_scope ||= reliable? ? Submission.with_attached_image.reliable : Submission.with_attached_image

      submissions_scope = search_site(submissions_scope, p_params[:site_filter]) if p_params[:site_filter].present?
      submissions_scope = submissions_scope.type_search(p_params[:type_filter]) if p_params[:type_filter].present?
      submissions_scope = submissions_scope.tagged_with(p_params[:tag]) if p_params[:tag].present?

      @submissions = smart_listing_create(:submissions, submissions_scope, partial: 'admin/submissions/list')
    end

    def show
      @submission = Submission.find(params[:id])
    end

    def edit; end

    def update
      @submission.update_attributes(submission_params)
      respond_to do |format|
        format.js { render 'admin/submissions/update.js.erb' }
      end
    end

    def new
      @submission = Submission.new(site_id: params[:site_id])
      @submission.build_type
      @presenter = ::Registrations::BasePresenter.new(@submission, view_context)
    end

    def create; end

    def destroy
      site = @submission.site
      @submission.destroy
      redirect_to admin_site_path(site.id)
    end

    private

    def p_params
      params.permit(:reliable,
                    :site_id,
                    :site_filter,
                    :type_filter,
                    :tag,
                    :bespoke_size,
                    :page)
    end

    def reliable?
      p_params[:reliable] == 'true'
    end

    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:reliable,
                                         :site_id,
                                         :type_id,
                                         :image,
                                         :record_taken,
                                         :submitted_at,
                                         :tag_list)
    end

    def search_site(collection, name)
      collection.where(site_id: Site.find_by(name: name))
    end
  end
end
