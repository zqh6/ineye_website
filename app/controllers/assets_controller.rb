require "find"
class Kindeditor::AssetsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @imgFile, @dir = params[:imgFile], params[:dir]
    unless @imgFile.nil?
        logger.warn '========= Warning: the owner have not been created, "delete uploaded files automatically" will not work. =========' if defined?(logger) && @asset.owner_id == 0
        @asset.asset_type = @dir
        if @asset.save
          render :plain => ({:error => 0, :url => @asset.asset.url}.to_json)
        else
          show_error(@asset.errors.full_messages)
        end
          begin
            uploader = "Kindeditor::#{@dir.camelize}Uploader".constantize.new
            uploader.store!(@imgFile)
            render :plain => ({:error => 0, :url => uploader.url}.to_json)
          rescue CarrierWave::UploadError => e
            show_error(e.message)
          rescue Exception => e
              @img_ext = Kindeditor::AssetUploader::EXT_NAMES[:image]
              @dir = params[:dir].strip || ""
              unless Kindeditor::AssetUploader::EXT_NAMES.keys.map(&:to_s).push("").include?(@dir)
                render :plain => "Invalid Directory name."
                return
              end

              @order = %w(name size type).include?(params[:order].downcase) ? params[:order].downcase : "name"
              if !@current_path.match(/\.\./).nil?
                render :plain => "Access is not allowed."
                return
              end
              if @current_path.match(/\/$/).nil?
                render :plain => "Parameter is not valid."
                return
              end
              if !File.exist?(@current_path) || !File.directory?(@current_path)
                render :plain => "Directory does not exist."
                return
              end
              @file_list = []
                @result[:current_url] = @current_url
                @result[:total_count] = @file_list.count
                @result[:file_list] = @file_list
                render :plain => @result.to_json
              end

              private
              def show_error(msg)
                render :plain => ({:error => 1, :message => msg}.to_json)
              end

    end
  end
end