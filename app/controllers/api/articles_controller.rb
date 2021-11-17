module Api
  class ArticlesController < ApiController
    before_action :authenticate_user
    before_action :is_admin
    before_action :set_article, only: %i[show]

    def index
      @articles = Article.pending_or_reviewing.map{|article| {article: article, 
        available_transitions: article.aasm.permitted_transitions
        .map{|s| {event: s[:event], state: s[:state]}}}}
      render json: @articles
    end

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