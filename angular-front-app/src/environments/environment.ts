export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080/api',
  keycloak: {
    url: 'http://localhost:9090/auth',
    realm: 'conference-realm',
    clientId: 'conference-frontend'
  }
};
