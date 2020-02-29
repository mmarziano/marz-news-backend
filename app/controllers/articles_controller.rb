class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.all

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.find_or_create_by(author: article_params[:author], title: article_params[:title], description: article_params[:description],
    url: article_params[:url], urlToImage: article_params[:urlToImage], publishedAt: article_params[:publishedAt],
    content: article_params[:content], source: article_params[:source],)
    @article.users << User.find(article_params[:user_id]) unless @article.users.include?(User.find(article_params[:user_id]))
    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:author, :title, :description, :url, :urlToImage, :publishedAt, :content, :source, :user_id)
    end
end
