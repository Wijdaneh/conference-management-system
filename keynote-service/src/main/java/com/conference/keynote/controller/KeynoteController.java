package com.conference.keynote.controller;

import com.conference.keynote.dto.KeynoteDTO;
import com.conference.keynote.service.KeynoteService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/keynotes")
@RequiredArgsConstructor
public class KeynoteController {
    
    private final KeynoteService keynoteService;
    
    @GetMapping
    public ResponseEntity<List<KeynoteDTO>> getAllKeynotes() {
        return ResponseEntity.ok(keynoteService.getAllKeynotes());
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<KeynoteDTO> getKeynoteById(@PathVariable Long id) {
        return ResponseEntity.ok(keynoteService.getKeynoteById(id));
    }
    
    @PostMapping
    public ResponseEntity<KeynoteDTO> createKeynote(@Valid @RequestBody KeynoteDTO keynoteDTO) {
        KeynoteDTO createdKeynote = keynoteService.createKeynote(keynoteDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdKeynote);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<KeynoteDTO> updateKeynote(@PathVariable Long id, 
                                                    @Valid @RequestBody KeynoteDTO keynoteDTO) {
        KeynoteDTO updatedKeynote = keynoteService.updateKeynote(id, keynoteDTO);
        return ResponseEntity.ok(updatedKeynote);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteKeynote(@PathVariable Long id) {
        keynoteService.deleteKeynote(id);
        return ResponseEntity.noContent().build();
    }
    
    @PostMapping("/{id}/publish")
    public ResponseEntity<KeynoteDTO> publishKeynote(@PathVariable Long id) {
        KeynoteDTO publishedKeynote = keynoteService.publishKeynote(id);
        return ResponseEntity.ok(publishedKeynote);
    }
    
    @PostMapping("/{id}/register")
    public ResponseEntity<KeynoteDTO> registerAttendee(@PathVariable Long id) {
        KeynoteDTO updatedKeynote = keynoteService.registerAttendee(id);
        return ResponseEntity.ok(updatedKeynote);
    }
    
    @GetMapping("/published")
    public ResponseEntity<List<KeynoteDTO>> getPublishedKeynotes() {
        return ResponseEntity.ok(keynoteService.getPublishedKeynotes());
    }
    
    @GetMapping("/conference/{conferenceId}")
    public ResponseEntity<List<KeynoteDTO>> getKeynotesByConference(@PathVariable Long conferenceId) {
        return ResponseEntity.ok(keynoteService.getKeynotesByConference(conferenceId));
    }
    
    @GetMapping("/test")
    public ResponseEntity<String> testEndpoint() {
        return ResponseEntity.ok("Keynote Service is working!");
    }
}
