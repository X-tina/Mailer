class MailObject < ActionMailer::Base

  default from: "username.idap@gmail.com"

  def create_mails(mail, head, body, attachs)
    @mail, @head, @body, @attachments = mail, head, body, attachs

    attach_name = @attachments.split("/").last
    attachments["#{attach_name}"] = File.read("#{@attachments}")

    mail(to: @mail, subject: @head)
  end

  def mail_list(mails)
    @mails = mails
    @@mails = Proc.new { @mails }
  end

end
