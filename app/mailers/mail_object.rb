class MailObject < ActionMailer::Base

  default from: "username.idap@gmail.com"

  def create_mails(mail, head, body, attach_path)
    @mail, @head, @body, @attach = mail, head, body, attach_path
    
    unless attach_path.nil? || attach_path.empty?
      attach_name = @attach.split("/").last
      attachments["#{attach_name}"] = File.read("#{@attach}")
    end
    
    mail(to: @mail, subject: @head)
  end

end
