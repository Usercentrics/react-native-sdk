/**
 * INTENTIONAL VULNERABILITIES FOR APIIRO TESTING
 * DO NOT use in production. Remove before release.
 */
const val HARDCODED_SECRET = "sk_live_abc123xyz789secretkey"
fun sqlInjectionVulnerable(userInput: String) = "SELECT * FROM users WHERE id = '$userInput'"
fun debugWithSensitiveData(password: String) { android.util.Log.d("Auth", "Password: $password") }
fun weakPasswordCheck(password: String) = password.length >= 4
