module Bench
  class My::FacilitatingsController < My::BaseController
    before_action :set_new_facilitating, only: [:new, :create]
    before_action :set_new_order, only: [:index]

    def index
      @facilitatings = current_user.facilitatings.order(id: :desc).page(params[:page])
    end

    private
    def set_new_facilitating
      @facilitating = current_user.facilitatings.build(facilitating_params)
    end

    def facilitating_params
      params.fetch(:facilitating, {}).permit(
        :facilitate_id,
        extra: {}
      )
    end

    def set_new_order
      @order = current_user.orders.build
      @order.items.build
    end

  end
end
