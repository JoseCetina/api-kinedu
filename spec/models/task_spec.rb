require 'rails_helper'

RSpec.describe Task, type: :model do
  context "validations" do
    context "uniqueness" do
      let(:user) {User.create(email: "jose.cetina.vega@gmail.com", password: "pepe619")}

      before do
        Task.create(title: "Ejercicios para niños", description: "Esta sección es sobre ejercicios para niños", user_id: user.id)
      end

      it "user created" do
        task = Task.create(title: "Ejercicios para bebes", description: "Esta sección es sobre ejercicios para bebes", user_id: user.id)
        
        expect(task).to be_valid
      end

      it "not valid" do
        task = Task.create(title: "Ejercicios para niños", description: "Esta sección es sobre ejercicios para bebes", user_id: user.id)
        
        expect(task).to_not be_valid
      end      
    end

    context "presence" do
      let(:user) {User.create(email: "jose.cetina.vega@gmail.com", password: "pepe619")}

      context "when the email is presence" do
        it "user created" do
          task = Task.create(title: "Ejercicios para bebes", description: "Esta sección es sobre ejercicios para bebes", user_id: user.id)
          
          expect(task).to be_valid
        end 
      end
      
      context "when the email is not presence" do
        it "not valid (empty)" do
          task = Task.create(title: "", description: "Esta sección es sobre ejercicios para bebes", user_id: user.id)
          
          expect(task).to_not be_valid
        end
  
        it "not valid (null)" do
          task = Task.create(description: "Esta sección es sobre ejercicios para bebes", user_id: user.id)
          
          expect(task).to_not be_valid
        end   
      end

      context "when the user is presence" do
        it "user created" do
          task = Task.create(title: "Ejercicios para bebes", description: "Esta sección es sobre ejercicios para bebes", user_id: user.id)
          
          expect(task).to be_valid
        end  
      end 
   
      context "when the user is not presence" do
        it "not valid (empty)" do
          task = Task.create(title: "", description: "Esta sección es sobre ejercicios para bebes", user_id: '')
          
          expect(task).to_not be_valid
        end
  
        it "not valid (null)" do
          task = Task.create(description: "Esta sección es sobre ejercicios para bebes")
          
          expect(task).to_not be_valid
        end   
      end      
    end
  end  
end
