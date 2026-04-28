module Bench
  class Admin::FacilitatingsController < Admin::BaseController
    before_action :set_facilitators, only: [:new, :create, :edit, :update]

    def index
      q_params = {}
      q_params.merge! default_params

      @facilitatings = Facilitating.includes(:orders).where(orders: { payment_status: 'all_paid' }).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def all
      q_params = {}
      q_params.merge! default_params

      @facilitatings = Facilitating.includes(:orders).default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_facilitators
      @facilitators = Facilitator.where(default_params)
    end

    def facilitating_params
      params.fetch(:facilitating, {}).permit(
        :facilitator_id
      )
    end

  end
end
