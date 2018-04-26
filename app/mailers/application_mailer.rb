# frozen_string_literal: true

# ApplicationMailer
class ApplicationMailer < ActionMailer::Base
  default from: 'Testigos de la Colombia Humana <testigos@petro.com.co>'
  layout 'mailer'
end
