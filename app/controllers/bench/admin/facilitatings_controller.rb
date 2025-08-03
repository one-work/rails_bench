module Bench
  class Admin::FacilitatingsController < Admin::BaseController

    def index
      q_params = {}
      q_params.merge! default_params

      @facilitatings = Facilitating.default_where(q_params).order(id: :desc).page(params[:page])
    end

  end
end
