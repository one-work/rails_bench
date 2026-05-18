module Bench
  class Admin::ProvidesController < Admin::BaseController
    before_action :set_provide, only: [:show, :edit, :update, :destroy, :actions, :invite]
    before_action :set_new_provide, only: [:new, :create]

    def index
      @provides = Provide.where(default_params).order(facilitate_provides_count: :desc).page(params[:page])
    end

    private
    def set_new_provide
      @provide = Provide.new(provide_params)
    end

    def set_provide
      @provide = Provide.find params[:id]
    end

    def provide_params
      _p = params.fetch(:provide, {}).permit(
        :name,
        :provider_id
      )
      _p.merge! default_form_params
    end

  end
end
