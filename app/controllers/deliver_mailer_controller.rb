class DeliverMailerController < ApplicationController
	include InputRequest
  
  def index
    @mails = mail_request if mail_request.kind_of?(Array)
    @head = convert_to_text(:head) if head?
    @body = convert_to_text(:body) if body?
    @attach_path = attach_request

    if attach_path?
      return_attach
    else
      send_mails(@mails, @attach_path = NIL) if @mails
    end

  end

  private

  def send_mails(mails, attach_path)
    mails.each do |mail|
      MailObject.create_mails(mail, @head, @body, attach_path).deliver
    end
    flash.now[:notice] = "Email was send to: #{@mails}"
  end

  def return_attach
    if @attach_path.nil? || @attach_path.empty?
      flash.now[:alert] = "No such file or directory #{convert_string_to_path(params[:attach_path])}"
      flash.now[:notice] = "Example: /path/to/file/file.type"
    else
      send_mails(@mails, @attach_path) if @mails
    end
  end

end
