package com.conference.conference.client;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "keynote-service")
public interface KeynoteClient {
    // Définir les endpoints pour appeler keynote-service
    // Exemple:
    // @GetMapping("/api/keynotes/{id}")
    // KeynoteDTO getKeynoteById(@PathVariable Long id);
}
