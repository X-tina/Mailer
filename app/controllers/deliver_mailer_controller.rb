class DeliverMailerController < ApplicationController
  
  def index
    @mails = mail_request if mail_request.kind_of?(Array)
  end

  private

  def mail_request
    if params[:mails_path]
      check_path
    else
      flash.now[:alert] = "Write path to the mails"
    end
  end

  def convert_string_to_path(path)
    path.split("_").join("/").insert(0, "/")
  end

  def check_path
    begin
      doc = File.open("#{convert_string_to_path(params[:mails_path])}", 'r') { |file| file.read }.split("\n")
      if doc
      	doc
      end
    rescue
      flash.now[:alert] = "No such file or directory #{convert_string_to_path(params[:mails_path])}"
    end
  end

end
