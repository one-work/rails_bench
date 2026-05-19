module Bench
  class Out::FacilitateProvidesController < Out::BaseController
    before_action :set_facilitate, only: [:show, :edit, :update, :destroy]

    def index
      @facilitate_provides = current_organ.facilitate_provides.includes(:organ, :facilitate).page(params[:page])
    end

    private
    def set_facilitate
      @facilitate = Facilitate.find(params[:id])
    end

  end
end
