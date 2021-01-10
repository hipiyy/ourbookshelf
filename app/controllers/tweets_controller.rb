require 'kconv'
class TweetsController < ApplicationController
    before_action :authenticate_user! 
    def index
        @tweets = Tweet.all
    end
    
    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user_id = current_user.id
        if tweet_params[:file]
            file = tweet_params[:file]
            name = file.original_filename
            @tweet.name = name
            result = uploadpdf(file,name)
        end
        #https://railsdoc.com/page/params_original_filename
        if @tweet.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def show
        @tweet = Tweet.find(params[:id])
    end

    def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to action: :index
    end
    def downloadpdf
        file_name = params[:name].to_s + ".pdf"
        filepath = Rails.root.join('public',file_name)
        stat = File::stat(filepath)
        send_file(filepath, :filename => file_name, :length => stat.size)
    end

    private
    def tweet_params
        params.require(:tweet).permit(:body, :image, :file, :tag_list)
    end
    
    def uploadpdf(file_object,file_name)
        ext = file_name[file_name.rindex('.') + 1, 4].downcase
        perms = ['.pdf']
        if !perms.include?(File.extname(file_name).downcase)
          result = 'アップロードできるのはpdfファイルのみです。'
        elsif file_object.size > 1000.megabyte
          result = 'ファイルサイズは10MBまでです。'
        else
          File.open("public/#{file_name.toutf8}", 'wb') { |f| f.write(file_object.read)}
          result = "success"
        end
        return result
    end
end

