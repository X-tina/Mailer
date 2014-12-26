class MailObject < ActionMailer::Base
  include InputRequest

  default from: "username.idap@gmail.com"

  def create_mails(mails, head, body, attachs)
    @mails, @head, @body, @attachments = mails, head, body, attachs

    attach_name = @attachments.split("/").last
    attachments["#{attach_name}"] = File.read("#{@attachments}")

    mail(to: @mails, subject: @head)
  end

  def mail_list(mails)
    @mails = mails
    @@mails = Proc.new { @mails }
  end

end
