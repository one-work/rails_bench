module Bench
  class Me::BaseController < MeController

    def set_facilitator
      @facilitator = current_member.facilitator
    end

  end
end
