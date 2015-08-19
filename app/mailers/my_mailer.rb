class MyMailer < Devise::Mailer
  default :from => 'info.mydocumentvn@gmail.com'

  def self.mailer_name
    "devise/mailer"
  end
end