module Bench
  class My::FacilitatingsController < My::BaseController
    before_action :set_item

    def index
      @facilitatings = @item.facilitatings
    end

    private
    def set_item
      @item = Trade::Item.find params[:item_id]
    end

    def set_facilitating
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
