require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

set :bind, '192.168.33.10'
set :port, 3000

class Contribution < ActiveRecord::Base
    establish_connection(adapter: "sqlite3", database: "./db/development.db")
end

get '/' do
    
    @contents = Contribution.order("id desc").all
    erb :index
end

post '/new' do
    
    logger.info "名前:#{params[:user_name]}, 内容:#{params[:body]}"
    Contribution.create(:name => params[:user_name],
                        :body => params[:body],
                        :img => "")

if params[:file]
    contents = Contribution.last
    id = contents.id
    ext = params[:file][:filename].split(".")[1]
    imgName = "#{id}-bbs.#{ext}"
    contents.update_attribute(:img, imgName)
    
    save_path = "./public/images/#{imgName}"
    
    File.open(save_path, 'wb') do |f|
        p params[:file][:tempfile]
        f.write params[:file][:tempfile].read
        logger.info "Upload has successed"
        
        end
    else
        logger.info "Upload has failed"
    end
        
        
    redirect '/'

    end

