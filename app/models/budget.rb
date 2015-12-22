class Budget < ActiveRecord::Base

require 'httparty'
require 'json'
require 'active_support/all'




def buxfer(email, password) 
        
        @login= HTTParty.get("https://www.buxfer.com/api/login?userid=#{ENV["email"]}&password=#{ENV["password"]}") 
        @buxfertoken =JSON.parse(@login)
        @buxfertoken = @buxfertoken["response"]["token"]
        @budget = HTTParty.get("https://www.buxfer.com/api/budgets?token=#{ENV["buxfer_token"]}")
        @budget = JSON.parse(@budget)
        if @budget["response"]["budgets"][0]["spent"] >= @budget["response"]["budgets"][0]["limit"]
                @result = HTTParty.post("https://www.beeminder.com/api/v1/users/cgamer1/goals/budget/datapoints.json?auth_token=#{ENV["beeminder_token"]}".to_str, 
                    :body => { 
                        :value =>'20',
    
                 }.to_json,
             :headers => { 'Content-Type' => 'application/json' } )
        
        else 
                 @result = HTTParty.post("https://www.beeminder.com/api/v1/users/cgamer1/goals/budget/datapoints.json?auth_token=#{ENV["beeminder_token"]}".to_str, 
                    :body => { 
                               :value =>'0',
                
                             }.to_json,
                    :headers => { 'Content-Type' => 'application/json' } )
                        
            
        end

        if @budget["response"]["budgets"][1]["spent"] >= @budget["response"]["budgets"][1]["limit"]
                @result = HTTParty.post("https://www.beeminder.com/api/v1/users/cgamer1/goals/groceries/datapoints.json?auth_token=#{ENV["beeminder_token"]}".to_str, 
                    :body => { 
                        :value =>'80',
        
                 }.to_json,
             :headers => { 'Content-Type' => 'application/json' } )
        
        else 
                 @result = HTTParty.post("https://www.beeminder.com/api/v1/users/cgamer1/goals/groceries/datapoints.json?auth_token=#{ENV["beeminder_token"]}".to_str, 
                    :body => { 
                               :value =>'0',
                
                             }.to_json,
                    :headers => { 'Content-Type' => 'application/json' } )
                        
            
        end 
    end

end

