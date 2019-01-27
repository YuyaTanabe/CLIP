class InquiriesController < ApplicationController
  def index
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
  end

  def done
    @inquiry = Inquiry.new(inquiry_params)
    if params[:back]
      render :action => 'index'
    else
      InquiryMailer.received_email(@inquiry).deliver_now
      render :action => 'done'
    end
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :content)
  end
end
