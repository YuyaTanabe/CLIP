class InquiryMailer < ApplicationMailer
  default to: ENV['GMAIL'] # 送信先アドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(subject: 'webサイト「CLIP」からお問い合わせが届きました。') do |format|
      format.text
    end
  end
end
