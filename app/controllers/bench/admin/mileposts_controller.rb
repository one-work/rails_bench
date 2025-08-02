module Bench
  class Admin::MilepostsController < Admin::BaseController
    before_action :set_milepost, only: [:show, :edit, :update, :move_higher, :move_lower, :destroy]
    before_action :set_new_milepost, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! default_params

      @mileposts = Milepost.default_where(q_params).page(params[:page])
    end

    private
    def set_milepost
      @milepost = Milepost.find params[:id]
    end

    def set_new_milepost
      @milepost = Milepost.new(milepost_params)
    end

    def milepost_params
      p = params.fetch(:milepost, {}).permit(
        :name
      )
      p.merge! default_form_params
    end

  end
end
