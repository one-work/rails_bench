module Bench
  class My::ItemFacilitatingsController < My::BaseController
    before_action :set_item
    before_action :set_new_facilitating, only: [:new, :create]

    def index
      @facilitatings = @item.facilitatings
    end

    private
    def set_item
      @item = Trade::Item.find params[:item_id]
    end

    def set_new_facilitating
      @facilitating = @item.facilitatings.build(facilitating_params)
      @facilitating.facilitate_id = @item.good_id
    end

    def facilitating_params
      params.fetch(:facilitating, {}).permit(
        extra: {}
      )
    end

  end
end
