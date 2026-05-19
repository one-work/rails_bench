module Bench
  class Board::OrgansController < Org::Board::OrgansController
    before_action :set_provide
    before_action :set_organ, only: [:show, :edit, :update, :destroy, :actions, :bind]

    def index
      q_params = {}
      #q_params.merge! provider_id: [current_organ.id, nil] if current_organ
      q_params.merge! 'who_roles.role_id' => params[:role_id] if params[:role_id].present?

      @members = current_user.members.includes(:organ).default_where(q_params)
    end

    def create
      if @organ.save
        @provide.update(provider_id: @organ.id)
        render :create, locals: { model: @organ }
      else
        render :new, locals: { model: @organ }, status: :unprocessable_entity
      end
    end

    def bind
      @provide.update provider_id: @organ.id
      @members = current_user.members.includes(:organ).order(id: :asc)
    end

    private
    def set_provide
      @provide = Provide.find_by invite_token: params[:invite_token]
    end

  end
end
