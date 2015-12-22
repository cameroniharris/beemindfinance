require 'httparty'
require 'json'
require 'active_support/all'


# Use the class methods to get down to business quickly
#response = HTTParty.get('https://www.beeminder.com/api/v1/users/cgamer1/goals.json?auth_token=zUrTPByjFRDSS6rA5jdC')

#parsed_json = ActiveSupport::JSON.decode(response) 

class Beeminder
    include HTTParty
    base_uri 'https://www.beeminder.com/api/v1/'
    
    def initialize(auth)
        @token = auth
    end 
    
    def goals
       puts self.class.get("/users/cgamer1/goals/budget/datapoints.json?auth_token=#{@token}" ) 
    end
end

class Buxfer 
    include HTTParty
    base_uri "https://www.buxfer.com/api/"
    
    def initialize(email, password)
       @login= self.class.get("/login?userid=#{email}&password=#{password}") 
       
    end    
    
    def token 
        @buxfertoken =JSON.parse(@login)
        @buxfertoken = @buxfertoken["response"]["token"]
    end
    
    def budget
        @budget = self.class.get("/budgets?token=#{@buxfertoken}")
        @budget = JSON.parse(@budget)
        if @budget["response"]["budgets"][0]["spent"] >= @budget["response"]["budgets"][0]["limit"]
                @result = HTTParty.post("https://www.beeminder.com/api/v1/users/cgamer1/goals/budget/datapoints.json?auth_token=zUrTPByjFRDSS6rA5jdC".to_str, 
                    :body => { 
                        :value =>'10',
    
                 }.to_json,
             :headers => { 'Content-Type' => 'application/json' } )
        
        else 
                 @result = HTTParty.post("https://www.beeminder.com/api/v1/users/cgamer1/goals/budget/datapoints.json?auth_token=zUrTPByjFRDSS6rA5jdC".to_str, 
                    :body => { 
                               :value =>'0',
                
                             }.to_json,
                    :headers => { 'Content-Type' => 'application/json' } )
                        
            
        end
        
    end 
    
end 



buxfer =Buxfer.new("cameroniharris1@gmail.com", "Playstation1@" )
puts buxfer.token
puts buxfer.budget
#beeminder = Beeminder.new("zUrTPByjFRDSS6rA5jdC")
#puts beeminder.goals