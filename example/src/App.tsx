import React, { Component } from 'react'
import { Button, Image, StyleSheet, View } from 'react-native'
import { Usercentrics, UsercentricsFont, UsercentricsLoggerLevel, UsercentricsLogo, UsercentricsOptions, UsercentricsServiceConsent, UsercentricsUIOptions } from 'react-native-usercentrics';

class App extends Component {

  constructor(props: any) {
    super(props)

    let options = new UsercentricsOptions("Yi9N3aXia")
    // options.defaultLanguage = "pt"
    options.loggerLevel = UsercentricsLoggerLevel.debug
    // options.version = "1.2.3"
    // options.timeoutMillis = 123
    Usercentrics.configure(options)
  }

  async componentDidMount() {
    const status = await Usercentrics.status();

    if (status.shouldShowCMP) {
      this.showCMP(false)
    } else {
      this.applyConsents(status.consents)
    }
  }

  async showCMP(showCloseButton: boolean) {
    const options = new UsercentricsUIOptions(showCloseButton)
    const customLogo = new UsercentricsLogo("logo.png", Image.resolveAssetSource(require('../assets/images/logo.png')))

    options.customLogo = customLogo

    const font = new UsercentricsFont("Lora", 14)
    options.customFont = font

    const response = await Usercentrics.showCMP(options)
    console.log("Consents -> ${response.consents}", response.consents);
    console.log("User Interaction -> ${response.userInteraction}", response.userInteraction);
    console.log("Controller Id -> ${response.controllerId}", response.controllerId);
  }

  async printMethods() {
    const controllerId = await Usercentrics.getControllerId();
    const tcfString = await Usercentrics.getTCFString();
    const data = await Usercentrics.restoreUserSession("customSettingsId")

    console.log("Controller Id -> ${controllerId}", controllerId);
    console.log("TCF String -> ${tcfString}", tcfString);
    console.log("Restore User Session -> ${data}", data)
  }

  applyConsents(consents: [UsercentricsServiceConsent]) {
    // https://docs.usercentrics.com/cmp_in_app_sdk/latest/apply_consent/apply-consent/#apply-consent-to-each-service
  }

  render() {
    const styles = StyleSheet.create({
      container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'space-evenly',
        height: 200,
      },
      custom: {
        fontFamily: 'Lora',
        fontSize: 20,
      }
    })

    return (
      <View style={styles.container}>
        <Button onPress={() => {
          this.showCMP(false);
        }} title="Show PredefinedUI" />

        <Button onPress={() => {
          this.printMethods();
        }} title="Print Methods" />
      </View>
    )
  }
}

export default App
