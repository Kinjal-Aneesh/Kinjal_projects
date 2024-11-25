classdef GCStation
    properties
        received_drones
    end

    methods
        function gcStation = GCStation()
            gcStation.received_drones = {}; 
        end

        function updated_drones = send_beacon(gcStation, drones, access_probabilities)
            disp('Initiating idle-less random access session.');
            if length(drones) ~= length(access_probabilities)
                error('Number of drones must match the number of access probabilities.');
            end
            for i = 1:length(drones)
                updated_drones(i) = drones(i).set_transmit_probability(access_probabilities(i));
            end            
            disp('Access probabilities sent to drones.');
        end

        function successful_drones = send_acks(gcStation)
            successful_drones = [];             
            received = gcStation.received_drones;
            for i = 1:length(received)
                if received{i}.state == 1  % Access drone using curly braces
                    successful_drones = [successful_drones, received{i}.receive_ack()];  % Access drone using curly braces
                end
            end
        end


        function gcStation = receive_incoming_data(gcStation, transmitting_drones)
            number_drones_attempting_to_transmit = length(transmitting_drones);
            if number_drones_attempting_to_transmit == 0
                disp('Idle slot detected. Sending ACKs.');
            elseif number_drones_attempting_to_transmit > 1
                disp('Collision detected.');
            elseif number_drones_attempting_to_transmit == 1
                drone = transmitting_drones{1};  % Access drone using curly braces
                existing_drone_ids = arrayfun(@(d) d.ID, gcStation.received_drones);  
                if ~ismember(drone.ID, existing_drone_ids) 
                    gcStation.received_drones = [gcStation.received_drones, drone];  % Add drone properly
                end
                disp(['ID packet successfully received from Drone ', num2str(drone.ID), '.']);
            end
        end
    end
end
