module Api
  class ArticlesController < ApiController
    before_action :authenticate_user
    before_action :set_article, only: %i[show]

    def show
      render json: @article
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end
  end
end