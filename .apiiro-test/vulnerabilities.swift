/**
 * INTENTIONAL VULNERABILITIES FOR APIIRO TESTING
 * DO NOT use in production. Remove before release.
 */
let hardcodedSecret = "sk_live_abc123xyz789secretkey"
func sqlInjectionVulnerable(userInput: String) -> String { "SELECT * FROM users WHERE id = '\(userInput)'" }
func debugWithSensitiveData(password: String) { print("User password: \(password)") }
func weakPasswordCheck(password: String) -> Bool { password.count >= 4 }
