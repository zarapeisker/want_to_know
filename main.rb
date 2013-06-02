require "sinatra"
require "sinatra/reloader"
require "movies"
require "stock_quote"
require "image_suckr"

get "/" do
	erb :home
end

get "/movies" do
	unless params[:movie].nil?
		@movie = params[:movie]
		@result = Movies.find_by_title(@movie)
	end
	erb :movies
end

get "/stocks" do
	unless params[:symbol].nil?
		@symbol = params[:symbol]
		@result = StockQuote::Stock.quote(@symbol)
			unless @result.nil?
				@result = @result.last 
			end
			@result
	end
	erb :stocks
end

get "/images" do
	unless params[:image].nil?
		@image = params[:image]
		suckr = ImageSuckr::GoogleSuckr.new  
		@result = suckr.get_image_url({"q" => @image})
	end
	erb :images
end