classdef Drone
    properties 
        ID
        state % 0 = no transmission, 1 = transmission
        access_probability
    end
    
    methods
        function obj = Drone(ID)
            obj.ID = ID;
            obj.state = 0; % Initially, no transmission
            obj.access_probability = 0.3; % Default access probability
        end
        
        function obj = set_access_probability(obj, prob)
            obj.access_probability = prob; % Dynamically set access probability
        end

        function obj = decide_to_transmit(obj)
            if rand() < obj.access_probability
                obj.state = 1; % Drone decides to transmit
            else
                obj.state = 0; % Drone does not transmit
            end
        end
    end
end
