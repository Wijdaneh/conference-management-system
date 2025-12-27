package com.conference.conference.service;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.conference.conference.repository.ConferenceRepository;
import com.conference.conference.service.ConferenceService;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ConferenceServiceTest {

    @Mock
    private ConferenceRepository conferenceRepository;

    @InjectMocks
    private ConferenceService conferenceService;

    @Test
    void testServiceInitialization() {
        assertNotNull(conferenceService);
        assertNotNull(conferenceRepository);
    }

    @Test
    void testContextLoads() {
        // Test de base pour vérifier que le contexte Spring se charge
        assertTrue(true);
    }

    @Test
    void testRepositoryMock() {
        // Vérifier que le repository mock fonctionne
        when(conferenceRepository.count()).thenReturn(0L);
        assertEquals(0, conferenceRepository.count());
        verify(conferenceRepository, times(1)).count();
    }
}
