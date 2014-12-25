class MailObject < ActionMailer::Base
  include InputRequest

  # default to: Proc.new { mail_request },
          # from: 'Mailer@example.com'
  default from: "username.idap@gmail.com",
          to: "ex@gmail.com"

  def create_mails(head, body, attachs)
  	@head, @body, @attachments = head, body, attachs

    attach_name = @attachments.split("/").last
    attachments["#{attach_name}"] = File.read("#{@attachments}")

    mail subject: @head
  end

end
