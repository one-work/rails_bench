module Bench
  class My::FacilitatingsController < My::BaseController
    before_action :set_new_facilitating, only: [:new, :create]

    def index
      @facilitatings = current_user.facilitatings
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

  end
end
