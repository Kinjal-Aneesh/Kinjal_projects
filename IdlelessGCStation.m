classdef IdlelessGCStation
    properties
        ACK_delay = 1;  % Time delay for sending ACKs
    end
    
    methods
        function obj = IdlelessGCStation()
            % Constructor for IdlelessGCStation class
        end
        
        function obj = receive_incoming_data(obj, transmitting_drones)
            % Process the data received from the transmitting drones
            disp('Receiving data from drones...');
            for i = 1:length(transmitting_drones)
                drone = transmitting_drones(i);
                disp(['Drone ', num2str(drone.ID), ' transmitting.']);
            end
        end
        
        function obj = send_ACKs(obj)
            % Simulate ACKs being sent by the ground control station in idle slots
            disp('Idle slot detected. Sending ACKs.');
        end
    end
end
