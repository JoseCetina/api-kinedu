require 'rails_helper'

RSpec.describe "Users", type: :request do
  #Create User
  describe "POST /users" do
    context "when a user is create successfully" do
      let!(:user_params) { { email: "jose.cetina@gmail.com", password: "pepe123" } }

      it "is the user created" do
        post '/users', params: user_params
        
        expect(response).to have_http_status(200)
        
        expect(User.count).to eq(1)
        
        expect(JSON.parse(response.body)["user"]["email"]).to eq("jose.cetina@gmail.com")
      end
    end

    context "when a user is not create successfully" do
      context "when the email is already created" do
        let!(:user_params) { { email: "jose.cetina@gmail.com", password: "pepe123" } }

        before do
          post '/users', params: user_params
        end

        it "error messages" do
          post '/users', params: user_params

          expect(JSON.parse(response.body)["error"]).to eq("El email ya está registrado")
        end
      end

      context "when the email is empty" do
        let!(:user_params) { { password: "pepe123" } }

        it "error messages" do
          post '/users', params: user_params
        
          expect(JSON.parse(response.body)["error"]).to eq("El campo email no puede estar vacío")
        end
      end

      context "when the email is not a email" do
        let!(:user_params) { { email: "jose.cetina", password: "pepe123" } }

        it "error messages" do
          post '/users', params: user_params
        
          expect(JSON.parse(response.body)["error"]).to eq("El email es inválido")
        end
      end

      context "when the password is too short" do
        let!(:user_params) { { email: "jose.cetina@gmail.com", password: "pepe" } }

        it "error messages" do
          post '/users', params: user_params
        
          expect(JSON.parse(response.body)["error"]).to eq("La contraseña es demasiado corta. Mínimo 6 caractéres")
        end
      end

      context "when the password is empty" do
        let!(:user_params) { { email: "jose.cetina@gmail.com", password: "" } }

        it "error messages" do
          post '/users', params: user_params
        
          expect(JSON.parse(response.body)["error"]).to eq("El campo contraseña no puede estar vacío")
        end
      end
    end
  end

  #Login User
  describe "POST /users/sign_in" do
    context "when a user is login successfully" do
      
    end

    context "when a user is not login successfully" do
      it "is not the email sign up" do

      end

      it "is the password wrong" do

      end
    end
  end
  
end
