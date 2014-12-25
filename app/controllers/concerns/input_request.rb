module InputRequest
  extend ActiveSupport::Concern

  def mail_request
    if params[:mails_path]
      check_path_to_list(params[:mails_path])
    else
      flash.now[:alert] = "Write path to the mails"
    end
  end

  def check_path_to_list(path_to_file)
    begin
      doc = File.open("#{convert_string_to_path(path_to_file)}", 'r') { |file| file.read }.split("\n")
      if doc
      	doc
      end
    rescue
      flash.now[:alert] = "No such file or directory #{convert_string_to_path(path_to_file)}"
    end
  end

  def convert_string_to_path(path)
    path.split("_").join("/").insert(0, "/")
  end

  def head?
    !!params[:head]
  end

  def body?
    !!params[:body]
  end

  def attach_path?
    !!params[:attach_path]
  end

  def convert_to_text(key)
    params[key] ? params[key].split("_").join(" ") : " "
  end


end