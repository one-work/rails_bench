module Bench
  class Admin::FacilitateResellsController < Admin::BaseController
    before_action :set_facilitate
    before_action :set_facilitate_resell, only: [:show, :edit, :update, :destroy]
    before_action :set_new_facilitate_resell, only: [:new, :create]
    before_action :set_provides, only: [:new, :create, :edit, :update]

    def index
      @facilitate_resells = @facilitate.facilitate_resells.page(params[:page])
    end

    private
    def set_facilitate
      @facilitate = Facilitate.find params[:facilitate_id]
    end

    def set_new_facilitate_resell
      @facilitate_resell = @facilitate.facilitate_resells.build(facilitate_resell_params)
    end

    def set_facilitate_resell
      @facilitate_resell = FacilitateProvide.find(params[:id])
    end

    def set_provides
      @provides = Provide.where(default_params)
    end

    def facilitate_resell_params
      _p = params.fetch(:facilitate_resell, {}).permit(
        :provide_id,
        :price,
        :note
      )
      _p.merge! default_form_params
    end

    def task_template_params
      params.fetch(:task_template, {}).permit(
        :name,
        :description
      )
    end

  end
end
