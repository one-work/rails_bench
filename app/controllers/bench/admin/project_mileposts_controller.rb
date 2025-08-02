module Bench
  class Admin::ProjectMilepostsController < Admin::BaseController
    before_action :set_project
    before_action :set_project_milepost, only: [:edit, :update, :destroy]
    before_action :set_new_project_milepost, only: [:new, :create]
    before_action :prepare_form

    def new
      @project_milepost = @project.project_mileposts.build
      @project_milepost.recorded_on = Date.current
    end

    private
    def set_project
      @project = Project.find params[:project_id]
    end

    def set_project_milepost
      @project_milepost = @project.project_mileposts.find params[:id]
    end

    def set_new_project_milepost
      @project_milepost = @project.project_mileposts.build(project_milepost_params)
    end

    def set_project_mileposts
      @project_mileposts = @project.project_mileposts
    end

    def prepare_form
      q_params = {}
      q_params.merge! default_params

      @mileposts = Milepost.default_where(q_params).where.not(id: @project.milepost_ids)
    end

    def project_milepost_params
      params.fetch(:project_milepost, {}).permit(
        :milepost_id,
        :recorded_on,
        :current
      )
    end

  end
end
