module Bench
  class Admin::FacilitatingsController < Admin::BaseController

    def index
      q_params = {}
      q_params.merge! default_params

      @facilitatings = Facilitating.includes(:orders).where(orders: { payment_status: 'all_paid' }).default_where(q_params).order(id: :desc).page(params[:page])
    end

  end
end
