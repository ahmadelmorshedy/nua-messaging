class PaymentsController < ApplicationController
  def reissue_lost_script
    ReissueLostScript.call(User.current)
    flash[:notice] = 'Prescript request sent successfully'
    redirect_to root_path
  end
end

