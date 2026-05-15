module Bench
  class My::FacilitatingsController < My::BaseController
    before_action :set_facilitating, only: [:qrcode, :confirm]
    before_action :set_new_facilitating, only: [:new, :create]
    before_action :set_new_order, only: [:index]

    def index
      @facilitatings = current_user.facilitatings.order(id: :desc).page(params[:page])
    end

    def create
      if @facilitating.save
        order = current_user.orders.build(
          items_attributes: [{
            good_id: @facilitating.id,
            good_type: @facilitating.base_class_name,
            good_name: @facilitating.facilitate.name,
            status: 'ordered'
          }],
          **default_form_params
        )
        order.save

        redirect_to controller: 'trade/my/orders', action: 'payment_types', id: order.id
      end
    end

    def qrcode
    end

    def confirm
      @facilitating.confirmed = true
      @facilitating.user = current_user
      @facilitating.save
    end

    private
    def set_new_facilitating
      @facilitating = current_user.facilitatings.build(facilitating_params)
    end

    def set_facilitating
      @facilitating = Facilitating.find(params[:id])
    end

    def facilitating_params
      params.fetch(:facilitating, {}).permit(
        :facilitate_id,
        :start_at,
        :finish_at,
        extra: {}
      )
    end

    def set_new_order
      @order = current_user.orders.build
      @order.items.build
    end

  end
end
