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

  # GET /bookmarks/:user_id
  def bookmarks
    @user = User.find(params[:user_id])
    @all = []
    @articles = @user.articles
    @articles = @user.articles.sort { |a, b| a.created_at <=> b.created_at }
    @articles.each do |article|
      new_article = {a: article, count: article.total_saves}
      @all << new_article
    end

    render json: @all
  end

  # PUT /bookmarks/:id/:user_id
  def remove
    @user = User.find(params[:user_id])
    @article = @user.articles[params[:id].to_i]
      if !@article.users.nil?
        @article.users.delete(@user)
        @article.save
        render json: @user.articles
      else 
        render json: {:errors => "User has no bookmarked articles to display."}, status: 422 
      end
  end

# POST /bookmarks
  def create_bookmark
    @article = Article.find_or_create_by(author: article_params[:author], title: article_params[:title], description: article_params[:description],
    url: article_params[:url], urlToImage: article_params[:urlToImage], publishedAt: article_params[:publishedAt],
    content: article_params[:content], source: article_params[:source],)
    if !@article.users.include?(User.find(article_params[:user_id]))
      @article.users << User.find(article_params[:user_id]) unless @article.users.include?(User.find(article_params[:user_id]))
      if @article.save
        render json: @article, status: :created, location: @article
      end 
    elsif @article.users.include?(User.find(article_params[:user_id]))
      render json: {:errors => "Article has already been bookmarked."}, status: 422 
    else 
      render json: {:errors => @article.errors.full_messages}, status: 422 
    end
  end

  # POST /articles
  def create
    @article = Article.find_or_create_by(author: article_params[:author], title: article_params[:title], description: article_params[:description],
    url: article_params[:url], urlToImage: article_params[:urlToImage], publishedAt: article_params[:publishedAt],
    content: article_params[:content], source: article_params[:source],)
    @article.timesSaved = @article.total_saves
      if @article.save
        render json: @article, status: :created, location: @article
      else 
        render json: {:errors => @article.errors.full_messages}, status: 422 
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
