module Bench
  class FacilitatorsController < BaseController
    before_action :set_facilitator, only: [:show, :edit, :update, :destroy, :actions]

    private
    def set_facilitator
      @facilitator = Facilitator.find params[:id]
    end

  end
end
