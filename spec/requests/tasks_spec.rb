# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) {User.create(email: "jose.cetina.vega@hotmail.com", password: "pepe619")}

  before {sign_in(user)}

  describe "GET /tasks" do
    context "when the index is open" do
      before do
        Task.create(
          title: "Ejercicios para niños",
          description: "Esta sección es para compartir",
          user_id: user.id
        )
        Task.create(
          title: "Post de bebes",
          description: "Esta sección es para hablar",
          user_id: user.id
        )
      end

      context "when the index does not recived any param" do
        it "get JSON" do
          get "/tasks"
          
          expect(JSON.parse(response.body)["tasks"].count).to eq(2)
        end
      end

      context "when the index recived limit" do
        it "get JSON limited in 1" do
          get "/tasks", params: {limit: 1}
          
          expect(JSON.parse(response.body)["tasks"].count).to eq(1)
        end
      end

      context "when the index recived order and direction" do
        it "get JSON order by title in descending way" do
          get "/tasks", params: {order: "title", direction: "desc"}
          
          expect(JSON.parse(response.body)["tasks"].count).to eq(2)
          expect(JSON.parse(response.body)["tasks"][0]["title"]).to eq("Post de bebes")
        end
      end
    end
  end

  describe "GET /tasks/:id" do
    let(:task) do
      Task.create(
        title: "Ejercicios para bebes",
        description: "Esta sección es para hablar de las diferentes", 
        user_id: user.id
      )
    end

    context "when a task is returned" do
      it "task returned" do
        get "/tasks/#{task.id}", params: {}

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["task"]["title"]).to eq("Ejercicios para bebes")
      end
    end

    context "when a task does not exist" do
      it "error" do
        get "/tasks/#{task.id + 1}", params: {}

        expect(JSON.parse(response.body)["error"]).to eq('La tarea no existe')
      end
    end
  end

  describe "POST /tasks" do
    context "when the task is created" do
      it "task created" do
        post "/tasks", params: {
          task: {
            title: "Ejercicios para bebes",
            description: "Esta sección es para hablar de las diferentes"
          }
        }
        
        expect(response).to have_http_status(200)
        expect(Task.count).to eq(1)
        expect(JSON.parse(response.body)["task"]["title"]).to eq("Ejercicios para bebes")
      end
    end 

    context "When the task is not created" do
      context "when the title exist" do
        before do
          Task.create(
            title: "Ejercicios para bebes",
            description: "Esta sección es para hablar de las diferentes", 
            user_id: user.id
          )
        end

        it "error messages" do
        post "/tasks", params: {
          task: {
            title: "Ejercicios para bebes",
            description: "Esta sección es para hablar de las diferentes"
          }
        }
        
        expect(Task.count).to eq(1)
        expect(JSON.parse(response.body)["error"]).to eq("Este título ya se encuentra registrado.")
        end 
      end

      context "when the title is empty" do
        it "error messages" do
        post "/tasks", params: {
          task: {
            title: "",
            description: "Esta sección es para hablar de las diferentes"
          }
        }
        
        expect(Task.count).to eq(0)
        expect(JSON.parse(response.body)["error"]).to eq("Introduce un título.")
        end
      end

      context "when the title is nill" do
        it "error messages" do
        post "/tasks", params: {
          task: {
            description: "Esta sección es para hablar de las diferentes"
          }
        }
        
        expect(Task.count).to eq(0)
        expect(JSON.parse(response.body)["error"]).to eq("Introduce un título.")
        end
      end
    end
  end

  describe "PUT /tasks/:id" do
    let(:task) do
      Task.create(
        title: "Ejercicios para bebes",
        description: "Esta sección es para hablar de las diferentes",
        user_id: user.id
      )
    end

    context "when the task is updated" do
      context "when the title is the same" do
        it "task updated" do
          put "/tasks/#{task.id}", params: {
            task: {
              title: task.title, 
              description: "Este blog es para discutir"
            }
          }
  
          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body)["task"]["title"]).to eq("Ejercicios para bebes")
        end
      end
      
      context "when the title is updated" do
        it "task updated" do
          put "/tasks/#{task.id}", params: {
            task: {
              title: "Ejercicios para niños",
              description: "Este blog es para discutir"
            }
          }
  
          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body)["task"]["title"]).to eq("Ejercicios para niños")
        end
      end
    end

    context "when the task is not updated" do
      context "when the title is empty" do
        it "error messages" do
          put "/tasks/#{task.id}", params: {
            task: {
              title: "",
              description: "Este blog es para discutir"
            }
          }
          
          expect(JSON.parse(response.body)["error"]).to eq("Introduce un título.")
        end
      end

      context "when the title already exist" do
        before do
          Task.create(
            title: "Ejercicios para niños",
            description: "Esta sección es para compartir",
            user_id: user.id
          )
        end
        
        it "error messages" do
          put "/tasks/#{task.id}", params: {
            task: {
              title: "Ejercicios para niños",
              description: "Este blog es para discutir"
            }
          }
          
          expect(JSON.parse(response.body)["error"]).to eq("Este título ya se encuentra registrado.")
        end
      end
    end
  end

  describe "DELETE /tasks/:id" do
    let(:task) do
      Task.create(
        title: "Ejercicios para bebes",
        description: "Esta sección es para hablar de las diferentes",
        user_id: user.id
      )
    end

    context "when the task is deleted" do
      it "task deleted" do
        delete "/tasks/#{task.id}", params: {}

        expect(response).to have_http_status(200)
        expect(Task.count).to eq(0)
      end
    end

    context "when the task does not exist" do
      it "error" do
        delete "/tasks/#{task.id + 1}", params: {}

        expect(response).to have_http_status(200)
        expect(Task.count).to eq(1)
      end
    end
    
  end
end
