class ActivitysController < ApplicationController

    def index
        # Display activities for only the logged in user
        @activitys = Activity.where(user: current_user.email).order("created_at DESC")
    end

    def new
        @activity = Activity.new
    end

    def create
        @activity = Activity.new(activity_params)
        @activity.user = current_user.email
        if (@activity.save)
            redirect_to @activity
        else
            render 'new'
        end
    end

    def show
        @activity = Activity.find(params[:id])
    end

    def edit
        # get the post to edit
        @activity = Activity.find(params[:id])
    end

    def update
        # get the post from DB using url params :id
        @activity = Activity.find(params[:id])

        # update the activity
        if(@activity.update(activity_params))
            redirect_to @activity
        else
            render 'edit'
        end
    end

    def destroy
        @activity = Activity.find(params[:id])
        @activity.destroy
        redirect_to activitys_path
    end

    private def activity_params
        # tells the form what to accept
        params.require(:activity).permit(:name, :title, :description, :distance, :duration, :elevation, :date, :time, :exertion)
    end
end
