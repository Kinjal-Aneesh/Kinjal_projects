function [throughput, access_probability] = IdlelessSlottedALOHA(gcs, drones, slots_per_frame, total_frames)
    throughput = 0;
    total_transmissions = 0;
    total_collisions = 0;
    
    % Simulating over multiple frames
    for frame = 1:total_frames
        disp(['-----------FRAME: ', num2str(frame), '-----------']);
        successful_transmissions = 0;
        transmitting_drones = [];

        % Simulating each slot within the frame
        for slot = 1:slots_per_frame
            disp(['---SLOT: ', num2str(slot), '---']);
            
            drones_in_slot = []; % Keep track of which drones are attempting to transmit
            for i = 1:length(drones)
                drone = drones(i).decide_to_transmit();
                if drone.state == 1
                    drones_in_slot = [drones_in_slot, drone.ID];
                    transmitting_drones = [transmitting_drones, drone];
                end
            end
            
            % If no drones are attempting to transmit, ground station sends ACK
            if isempty(drones_in_slot)
                gcs = gcs.send_ACKs();
            else
                disp('Drones attempting to transmit:');
                disp(drones_in_slot);
                
                % Handling transmission and collisions
                if length(drones_in_slot) == 1
                    successful_transmissions = successful_transmissions + 1;
                else
                    total_collisions = total_collisions + 1;
                end
            end
        end
        
        % Update throughput for this frame
        total_transmissions = total_transmissions + successful_transmissions;
    end
    
    throughput = total_transmissions / (total_frames * slots_per_frame);
    access_probability = mean([drones.access_probability]);
end
