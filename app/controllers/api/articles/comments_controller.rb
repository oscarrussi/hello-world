module Api
  class Articles::CommentsController < ApiController
    before_action :authenticate_user
    before_action :set_article, only: %i[index]

    def index
      @pagy, @comments = pagy(@article.comments, page: params[:page])
      render json: { "pagy": @pagy, "comments": @comments }
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end
  end
end
