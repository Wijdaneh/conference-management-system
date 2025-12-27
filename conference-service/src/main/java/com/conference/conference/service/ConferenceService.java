package com.conference.conference.service;

import com.conference.conference.dto.ConferenceDTO;
import com.conference.conference.entity.Conference;
import com.conference.conference.exception.ResourceNotFoundException;
import com.conference.conference.mapper.ConferenceMapper;
import com.conference.conference.repository.ConferenceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ConferenceService {
    
    private final ConferenceRepository conferenceRepository;
    private final ConferenceMapper conferenceMapper;
    
    public List<ConferenceDTO> getAllConferences() {
        return conferenceRepository.findAll()
                .stream()
                .map(conferenceMapper::toDTO)
                .collect(Collectors.toList());
    }
    
    public ConferenceDTO getConferenceById(Long id) {
        Conference conference = conferenceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Conference not found with id: " + id));
        return conferenceMapper.toDTO(conference);
    }
    
    @Transactional
    public ConferenceDTO createConference(ConferenceDTO conferenceDTO) {
        Conference conference = conferenceMapper.toEntity(conferenceDTO);
        conference.setCurrentAttendees(0);
        Conference savedConference = conferenceRepository.save(conference);
        log.info("Created conference with id: {}", savedConference.getId());
        return conferenceMapper.toDTO(savedConference);
    }
    
    @Transactional
    public ConferenceDTO updateConference(Long id, ConferenceDTO conferenceDTO) {
        Conference conference = conferenceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Conference not found with id: " + id));
        
        conferenceMapper.updateEntityFromDTO(conferenceDTO, conference);
        Conference updatedConference = conferenceRepository.save(conference);
        log.info("Updated conference with id: {}", id);
        return conferenceMapper.toDTO(updatedConference);
    }
    
    @Transactional
    public void deleteConference(Long id) {
        if (!conferenceRepository.existsById(id)) {
            throw new ResourceNotFoundException("Conference not found with id: " + id);
        }
        conferenceRepository.deleteById(id);
        log.info("Deleted conference with id: {}", id);
    }
    
    @Transactional
    public ConferenceDTO registerAttendee(Long id) {
        Conference conference = conferenceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Conference not found with id: " + id));
        
        if (!conference.getIsActive()) {
            throw new IllegalStateException("Conference is not active");
        }
        
        if (conference.getCurrentAttendees() >= conference.getMaxAttendees()) {
            throw new IllegalStateException("Conference is full");
        }
        
        conference.setCurrentAttendees(conference.getCurrentAttendees() + 1);
        Conference updatedConference = conferenceRepository.save(conference);
        log.info("Registered attendee for conference id: {}, current attendees: {}", 
                id, updatedConference.getCurrentAttendees());
        return conferenceMapper.toDTO(updatedConference);
    }
    
    public List<ConferenceDTO> getActiveConferences() {
        return conferenceRepository.findByIsActiveTrue()
                .stream()
                .map(conferenceMapper::toDTO)
                .collect(Collectors.toList());
    }
    
    public List<ConferenceDTO> getAvailableConferences() {
        return conferenceRepository.findAvailableConferences()
                .stream()
                .map(conferenceMapper::toDTO)
                .collect(Collectors.toList());
    }
}