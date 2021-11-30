module Api
  class Articles::CommentsController < ApiController
    before_action :authenticate_user
    before_action :set_article, only: %i[index]

    def index
      @pagy, @comments = pagy(@article.comments_with_user_email, page: [params[:page].to_i, 1].max)
      render json: { "pagy": @pagy, "comments": serialize_collection(@comments) }
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end
  end
end
