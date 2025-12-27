package com.conference.conference.repository;

import com.conference.conference.entity.Conference;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ConferenceRepository extends JpaRepository<Conference, Long> {
    
    List<Conference> findByIsActiveTrue();
    
    List<Conference> findByLocation(String location);
    
    @Query("SELECT c FROM Conference c WHERE c.startDate >= :start AND c.endDate <= :end")
    List<Conference> findConferencesBetweenDates(@Param("start") LocalDateTime start, 
                                                 @Param("end") LocalDateTime end);
    
    @Query("SELECT c FROM Conference c WHERE c.currentAttendees < c.maxAttendees AND c.isActive = true")
    List<Conference> findAvailableConferences();
}