module Api
  class CommentsController < ApiController
    before_action :authenticate_user

    def destroy
      authorize Comment
      Comment.destroy(params[:id])
      render json: {"id": params[:id]}, status: :ok
    end

    def get_deleted
      authorize Comment
      render json: Comment.only_deleted
    end
  end
end