package com.conference.keynote.service;

import com.conference.keynote.dto.KeynoteDTO;
import com.conference.keynote.entity.Keynote;
import com.conference.keynote.exception.ResourceNotFoundException;
import com.conference.keynote.mapper.KeynoteMapper;
import com.conference.keynote.repository.KeynoteRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class KeynoteService {
    
    private final KeynoteRepository keynoteRepository;
    private final KeynoteMapper keynoteMapper;
    
    public List<KeynoteDTO> getAllKeynotes() {
        return keynoteRepository.findAll()
                .stream()
                .map(keynoteMapper::toDTO)
                .collect(Collectors.toList());
    }
    
    public KeynoteDTO getKeynoteById(Long id) {
        Keynote keynote = keynoteRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Keynote not found with id: " + id));
        return keynoteMapper.toDTO(keynote);
    }
    
    @Transactional
    public KeynoteDTO createKeynote(KeynoteDTO keynoteDTO) {
        Keynote keynote = keynoteMapper.toEntity(keynoteDTO);
        Keynote savedKeynote = keynoteRepository.save(keynote);
        log.info("Created keynote with id: {}", savedKeynote.getId());
        return keynoteMapper.toDTO(savedKeynote);
    }
    
    @Transactional
    public KeynoteDTO updateKeynote(Long id, KeynoteDTO keynoteDTO) {
        Keynote keynote = keynoteRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Keynote not found with id: " + id));
        
        keynoteMapper.updateEntityFromDTO(keynoteDTO, keynote);
        Keynote updatedKeynote = keynoteRepository.save(keynote);
        log.info("Updated keynote with id: {}", id);
        return keynoteMapper.toDTO(updatedKeynote);
    }
    
    @Transactional
    public void deleteKeynote(Long id) {
        if (!keynoteRepository.existsById(id)) {
            throw new ResourceNotFoundException("Keynote not found with id: " + id);
        }
        keynoteRepository.deleteById(id);
        log.info("Deleted keynote with id: {}", id);
    }
    
    @Transactional
    public KeynoteDTO publishKeynote(Long id) {
        Keynote keynote = keynoteRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Keynote not found with id: " + id));
        
        keynote.setIsPublished(true);
        Keynote publishedKeynote = keynoteRepository.save(keynote);
        log.info("Published keynote with id: {}", id);
        return keynoteMapper.toDTO(publishedKeynote);
    }
    
    @Transactional
    public KeynoteDTO registerAttendee(Long id) {
        Keynote keynote = keynoteRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Keynote not found with id: " + id));
        
        if (!keynote.getIsPublished()) {
            throw new IllegalStateException("Keynote is not published");
        }
        
        if (keynote.getCurrentAttendees() >= keynote.getMaxAttendees()) {
            throw new IllegalStateException("Keynote is full");
        }
        
        keynote.setCurrentAttendees(keynote.getCurrentAttendees() + 1);
        Keynote updatedKeynote = keynoteRepository.save(keynote);
        log.info("Registered attendee for keynote id: {}, current attendees: {}", 
                id, updatedKeynote.getCurrentAttendees());
        return keynoteMapper.toDTO(updatedKeynote);
    }
    
    public List<KeynoteDTO> getPublishedKeynotes() {
        return keynoteRepository.findByIsPublishedTrue()
                .stream()
                .map(keynoteMapper::toDTO)
                .collect(Collectors.toList());
    }
    
    public List<KeynoteDTO> getKeynotesByConference(Long conferenceId) {
        return keynoteRepository.findByConferenceId(conferenceId)
                .stream()
                .map(keynoteMapper::toDTO)
                .collect(Collectors.toList());
    }
}