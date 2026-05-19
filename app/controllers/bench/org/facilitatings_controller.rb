module Bench
  class Org::FacilitatingsController < Panel::BaseController
    before_action :set_facilitate_provide
    before_action :set_facilitating, only: [:show, :edit, :update, :destroy]

    def index
      @facilitatings = @facilitate_provide.facilitatings.page(params[:page])
    end

    private
    def set_facilitate_provide
      @facilitate_provide = FacilitateProvide.find(params[:facilitate_provide_id])
    end

  end
end
