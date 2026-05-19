module Bench
  class Out::FacilitatorsController < Admin::FacilitatorsController
    before_action :set_facilitate_provide
    before_action :set_new_facilitator, only: [:new, :create]
    skip_before_action :set_facilitate

    def index
      @facilitators = @facilitate_provide.facilitators.page(params[:page])
    end

    private
    def set_facilitate_provide
      @facilitate_provide = FacilitateProvide.find(params[:facilitate_provide_id])
    end

    def set_facilitator
      @facilitator = @facilitate_provide.facilitators.find(params[:id])
    end

    def set_new_facilitator
      @facilitator = @facilitate_provide.facilitators.build(facilitator_params)
    end

  end
end
