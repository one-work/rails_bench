module Bench
  class Admin::FacilitateProvidesController < Admin::BaseController
    before_action :set_facilitate
    before_action :set_facilitate_provide, only: [:show, :task_templates, :edit, :update, :destroy]
    before_action :set_new_facilitate_provide, only: [:new, :create]

    def index
      @facilitate_provides = @facilitate.facilitate_provides.page(params[:page])
    end

    def task_templates
      @task_templates = @facilitate_provide.task_templates
    end

    private
    def set_facilitate
      @facilitate = Facilitate.find params[:facilitate_id]
    end

    def set_new_facilitate_provide
      @facilitate_provide = @facilitate.facilitate_provides.build(facilitate_provide_params)
    end

    def set_facilitate_provide
      @facilitate_provide = FacilitateProvider.find(params[:id])
    end

    def facilitate_provide_params
      params.fetch(:facilitate_provide, {}).permit(
        :selected,
        :note
      )
    end

    def task_template_params
      params.fetch(:task_template, {}).permit(
        :name,
        :description
      )
    end

  end
end
