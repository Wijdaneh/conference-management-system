package com.conference.conference.mapper;

import com.conference.conference.dto.ConferenceDTO;
import com.conference.conference.entity.Conference;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = "spring", 
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface ConferenceMapper {
    
    ConferenceDTO toDTO(Conference conference);
    
    Conference toEntity(ConferenceDTO conferenceDTO);
    
    void updateEntityFromDTO(ConferenceDTO conferenceDTO, @MappingTarget Conference conference);
}