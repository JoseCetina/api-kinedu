# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
   email = params[:email]
   password = params[:password]

   user = User.new(email: email, password: password)

   if user.save
    render json: {user: user}
   else
    if user.errors.messages[:email].present?
      if user.errors.messages[:email].include?('is invalid')
        render json: {error: 'El email es inválido'}
        return
      end
      
      if user.errors.messages[:email].include?('has already been taken')
        render json: {error: 'El email ya está registrado'}
        return
      end

      if user.errors.messages[:email].include?("can't be blank")
        render json: {error: 'El campo email no puede estar vacío'}
        return
      end
    end

    if user.errors.messages[:password].include?('is too short (minimum is 6 characters)')
      render json: {error: 'La contraseña es demasiado corta. Mínimo 6 caractéres'}
    end

    if user.errors.messages[:password].include?("can't be blank")
      render json: {error: 'El campo contraseña no puede estar vacío'}
    end
   end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
