module Bench
  class FacilitateResellsController < BaseController
    before_action :set_facilitate, only: [:show]
    before_action :set_facilitate_taxons, only: [:index, :buy]
    before_action :set_cart, only: [:index, :show, :buy]
    before_action :require_user

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:facilitate_taxon_id)

      @facilitates = Facilitate.default_where(q_params).page(params[:page])
    end

    private
    def set_facilitate_resell
      @facilitate = Facilitate.find(params[:id])
    end

    def set_cart
      if current_user
        @cart = Trade::Cart.get_cart(params, good_type: 'Bench::FacilitateResell', user_id: current_user.id, **default_form_params)
      end
    end

  end
end
