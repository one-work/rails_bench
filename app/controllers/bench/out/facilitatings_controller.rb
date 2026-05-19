module Bench
  class Out::FacilitatingsController < Out::BaseController
    before_action :set_facilitate_provide
    before_action :set_facilitating, only: [:show, :edit, :update, :destroy]
    before_action :set_facilitators, only: [:edit, :update]

    def index
      @facilitatings = @facilitate_provide.facilitatings.page(params[:page])
    end

    private
    def set_facilitate_provide
      @facilitate_provide = FacilitateProvide.find(params[:facilitate_provide_id])
    end

    def set_facilitating
      @facilitating = @facilitate_provide.facilitatings.find(params[:id])
    end

    def set_facilitators
      @facilitators = @facilitate_provide.facilitators
    end

  end
end
