class DeliverMailerController < ApplicationController
	include InputRequest
  
  def index
    @mails = mail_request if mail_request.kind_of?(Array)
    @head = convert_to_text(:head) if head?
    @body = convert_to_text(:body) if body?
    @attach = convert_string_to_path(params[:attach_path]) if attach_path?
    @mails.each do |mail|
      MailObject.create_mails(mail, @head, @body, @attach).deliver
    end
    flash.now[:notice] = "Email was send to: #{@mails}"
  end

end
