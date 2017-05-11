class ConfirmationsController < Devise::ConfirmationsController

  def show
    user = User.find_by(confirmation_token: params[:confirmation_token])
    if user
      user.update!(account_confirmed: true) 
      flash[:notice] = 'Ваш email подтвержден. Можете авторизоваться'
      super
    else
      flash[:notice] = 'Что-то пошло не так'
      redirect_to root_path
    end
  end
end
