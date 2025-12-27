package com.conference.conference.controller;

import com.conference.conference.dto.ConferenceDTO;
import com.conference.conference.service.ConferenceService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/conferences")
@RequiredArgsConstructor
public class ConferenceController {
    
    private final ConferenceService conferenceService;
    
    @GetMapping
    public ResponseEntity<List<ConferenceDTO>> getAllConferences() {
        return ResponseEntity.ok(conferenceService.getAllConferences());
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<ConferenceDTO> getConferenceById(@PathVariable Long id) {
        return ResponseEntity.ok(conferenceService.getConferenceById(id));
    }
    
    @PostMapping
    public ResponseEntity<ConferenceDTO> createConference(@Valid @RequestBody ConferenceDTO conferenceDTO) {
        ConferenceDTO createdConference = conferenceService.createConference(conferenceDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdConference);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<ConferenceDTO> updateConference(@PathVariable Long id, 
                                                          @Valid @RequestBody ConferenceDTO conferenceDTO) {
        ConferenceDTO updatedConference = conferenceService.updateConference(id, conferenceDTO);
        return ResponseEntity.ok(updatedConference);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteConference(@PathVariable Long id) {
        conferenceService.deleteConference(id);
        return ResponseEntity.noContent().build();
    }
    
    @PostMapping("/{id}/register")
    public ResponseEntity<ConferenceDTO> registerAttendee(@PathVariable Long id) {
        ConferenceDTO updatedConference = conferenceService.registerAttendee(id);
        return ResponseEntity.ok(updatedConference);
    }
    
    @GetMapping("/active")
    public ResponseEntity<List<ConferenceDTO>> getActiveConferences() {
        return ResponseEntity.ok(conferenceService.getActiveConferences());
    }
    
    @GetMapping("/available")
    public ResponseEntity<List<ConferenceDTO>> getAvailableConferences() {
        return ResponseEntity.ok(conferenceService.getAvailableConferences());
    }
    
    @GetMapping("/test")
    public ResponseEntity<String> testEndpoint() {
        return ResponseEntity.ok("Conference Service is working!");
    }
}