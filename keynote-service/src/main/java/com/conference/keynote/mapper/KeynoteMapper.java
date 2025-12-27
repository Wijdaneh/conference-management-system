package com.conference.keynote.mapper;

import com.conference.keynote.dto.KeynoteDTO;
import com.conference.keynote.entity.Keynote;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = "spring", 
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface KeynoteMapper {
    
    KeynoteDTO toDTO(Keynote keynote);
    
    Keynote toEntity(KeynoteDTO keynoteDTO);
    
    void updateEntityFromDTO(KeynoteDTO keynoteDTO, @MappingTarget Keynote keynote);
}
