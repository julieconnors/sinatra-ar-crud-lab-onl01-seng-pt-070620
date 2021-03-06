
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  get '/articles' do
    @articles = Article.all

    erb :index
  end

  get '/articles/new' do
    @article =  Article.new
    erb :new
  end

  post '/articles' do
    @article = Article.create(params)

    redirect to "/articles/#{ @article.id }"

    erb :new
  end
    
  get '/articles/:id' do
    @article = Article.all.find(params[:id])

    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.all.find(params[:id])

    erb :edit
  end

  patch '/articles/:id' do
    #binding.pry
    update_hash = {}
    update_hash[:title] = params[:title]
    update_hash[:content] = params[:content]
    @article = Article.all.find(params[:id])
    @article.update(update_hash)
    
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @article = Article.all.find(params[:id])
    @article.destroy

    redirect to "/index"
  end

end
