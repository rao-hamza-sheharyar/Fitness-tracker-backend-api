module Api::V1
  class DietPlansController < ApplicationController
    before_action :authorize_request
    before_action :set_diet_plan, only: [:show, :update]

    def create
      diet_plan = DietPlan.new(diet_plan_params)
      authorize diet_plan  # 🔐 Only admins allowed

      if diet_plan.save
        render json: diet_plan, status: :created
      else
        render json: { errors: diet_plan.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      authorize @diet_plan

      render json: @diet_plan, include: {
        meals: {
          include: :meal_items
        }
      }
    end

    def update
      authorize @diet_plan

      if @diet_plan.update(diet_plan_params)
        render json: @diet_plan, include: { meals: { include: :meal_items } }
      else
        render json: { errors: @diet_plan.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def user_plans
      user = current_user.admin? ? User.find(params[:id]) : current_user

      if user == current_user || current_user.admin?
        plans = user.diet_plans.includes(meals: :meal_items)
        render json: plans, include: { meals: { include: :meal_items } }
      else
        render json: { error: "Not authorized" }, status: :forbidden
      end
    end

    def destroy
      diet_plan = DietPlan.find(params[:id])
      authorize diet_plan
      diet_plan.destroy
      head :no_content
    end

    private

    def set_diet_plan
      @diet_plan = DietPlan.includes(meals: :meal_items).find(params[:id])
    end

    def diet_plan_params
      params.require(:diet_plan).permit(
        :user_id,
        :name,
        meals_attributes: [
          :id, :name, :_destroy,
          meal_items_attributes: [:id, :name, :calories, :_destroy]
        ]
      )
    end
  end
end
