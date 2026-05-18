module Bench
  class Admin::FacilitateProvidesController < Admin::BaseController
    before_action :set_facilitate
    before_action :set_facilitate_provide, only: [:show, :task_templates, :edit, :update, :destroy]
    before_action :set_new_facilitate_provide, only: [:new, :create]
    before_action :set_provides, only: [:new, :create, :edit, :update]

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
      @facilitate_provide = FacilitateProvide.find(params[:id])
    end

    def set_provides
      @provides = Provide.where(default_params)
    end

    def facilitate_provide_params
      params.fetch(:facilitate_provide, {}).permit(
        :provide_id,
        :default,
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
