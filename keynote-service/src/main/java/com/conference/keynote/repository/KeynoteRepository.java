package com.conference.keynote.repository;

import com.conference.keynote.entity.Keynote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface KeynoteRepository extends JpaRepository<Keynote, Long> {
    
    List<Keynote> findByIsPublishedTrue();
    
    List<Keynote> findByConferenceId(Long conferenceId);
    
    List<Keynote> findBySpeaker(String speaker);
    
    List<Keynote> findByLocation(String location);
}
