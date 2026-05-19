module Bench
  class Admin::FacilitatingsController < Admin::BaseController
    before_action :set_facilitators, only: [:new, :create, :edit, :update]
    before_action :set_provides, only: [:new, :create, :edit, :update]
    before_action :set_filter_columns, only: [:index, :all]

    def index
      q_params = {}
      q_params.merge! default_params

      @facilitatings = Facilitating.includes(:orders).where(orders: { payment_status: 'all_paid' }).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def all
      q_params = {}
      q_params.merge! default_params

      @facilitatings = Facilitating.includes(:facilitate, :facilitator).default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_facilitators
      @facilitators = Facilitator.where(default_params)
    end

    def set_provides
      @provides = Provide.where(default_params)
    end

    def facilitating_params
      params.fetch(:facilitating, {}).permit(
        :facilitator_id,
        :provide_id,
        :start_at,
        :finish_at
      )
    end

  end
end
