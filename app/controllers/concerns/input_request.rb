module InputRequest
  extend ActiveSupport::Concern

  def mail_request
    if params[:mails_path]
      check_path_to_list(params[:mails_path])
    else
      flash.now[:alert] = "Write path to the mails"
    end
  end

  def attach_request
    check_path_to_attach(params[:attach_path]) if attach_path?
  end

  def check_path_to_list(path_to_file)
    begin
      doc = File.open("#{convert_string_to_path(path_to_file)}", 'r') { |file| file.read }.split("\n")
      doc if doc
    rescue
      flash.now[:alert] = "No such file or directory #{convert_string_to_path(path_to_file)}"
      flash.now[:notice] = "Example: /path/to/file/file.type"
    end
  end

  def check_path_to_attach(path_to_file)
    begin
      file = File.read("#{convert_string_to_path(path_to_file)}")
      convert_string_to_path(path_to_file) if file
    rescue
      ""
    end
  end

  def convert_string_to_path(path)
    path.split("_").join("/")
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