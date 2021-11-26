module Api
  class ArticlesController < ApiController
    before_action :authenticate_user
    before_action :admin?, only: %i[index]
    before_action :set_article, only: %i[show]

    def index
      @articles = Article.pending_or_reviewing
      render json: @articles, each_serializer: ArticleSerializer
    end

    def show
      render json: @article
    end

    def create
      @article = @current_user.articles.new(articles_params)
      authorize @article
      @article.save!
      render json: @article, status: :accepted
    end

    def update_aasm
      @article = Article.find(params[:id])
      @article.aasm.fire!(params[:event])
      render json: @article, status: :accepted
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
