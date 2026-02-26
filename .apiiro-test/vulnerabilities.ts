/**
 * INTENTIONAL VULNERABILITIES FOR APIIRO TESTING
 * DO NOT use in production. Remove before release.
 */

// ============ HIGH SEVERITY ============
export const HARDCODED_SECRET = 'sk_live_abc123xyz789secretkey';
export const API_KEY = 'AIzaSyB1234567890abcdefghijklmnop';

export function sqlInjectionVulnerable(userInput: string): string {
  return `SELECT * FROM users WHERE id = '${userInput}'`;
}

export function evalVulnerable(userInput: string): unknown {
  return eval(userInput);
}

// ============ MEDIUM SEVERITY ============
export function insecureRandomToken(): string {
  return Math.random().toString(36).substring(2);
}

export function debugWithSensitiveData(user: { password: string }) {
  console.log('User auth:', user);
}

// ============ LOW SEVERITY ============
// TODO: Security fix needed
// FIXME: Add validation
export function weakPasswordCheck(password: string): boolean {
  return password.length >= 4;
}

export const INSECURE_URL = 'http://api.example.com/data';
