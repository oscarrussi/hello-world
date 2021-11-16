module Api
  class ArticlesController < ApiController
    before_action :authenticate_user
    before_action :set_article, only: %i[show]

    def show
      render json: @article
    end


    def create
      @article = @current_user.articles.new(articles_params)
      authorize  @article
      if @article.save
        render json: @article, status: :accepted
      end
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def articles_params
      params.require(:article).permit(:title, :content)
    end
  end
end