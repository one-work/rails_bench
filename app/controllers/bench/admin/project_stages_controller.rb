module Bench
  class Admin::ProjectStagesController < Admin::BaseController
    before_action :set_project_stage, only: [:show, :edit, :update, :destroy]
    before_action :set_new_project_stage, only: [:new, :create]

    def index
      @project_stages = ProjectStage.page(params[:page])
    end

    private
    def set_project_stage
      @project_stage = ProjectStage.find(params[:id])
    end

    def set_new_project_stage
      @project_stage = ProjectStage.new(project_stage_params)
    end

    def project_stage_params
      params.fetch(:project_stage, {}).permit(
        :name,
        :begin_on,
        :end_on
      )
    end

  end
end
