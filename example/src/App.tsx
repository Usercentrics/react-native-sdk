import React, { Component } from 'react'
import { Button, StyleSheet, Text, View } from 'react-native'
import { UsercentricsOptions, UsercentricsLoggerLevel, UsercentricsServiceConsent, UsercentricsUIOptions } from '../../src/models'
import { Usercentrics } from '../../src/Usercentrics' 

class App extends Component { 

  constructor(props: any) {
    super(props)

    let options = new UsercentricsOptions("eQ6JwYNPb")
    // options.defaultLanguage = "pt"
    options.loggerLevel = UsercentricsLoggerLevel.debug
    // options.version = "1.2.3"
    // options.timeoutMillis = 123
    Usercentrics.configure(options)
  }

  async componentDidMount() {
    const status = await Usercentrics.status();
    
    if(status.shouldShowCMP) {
      this.showCMP(false)
    } else { 
      this.applyConsents(status.consents)
    }
  }

  async showCMP(showCloseButton: boolean) { 
    const options = new UsercentricsUIOptions(showCloseButton)

    options.customLogo = "logo"
    // options.fontName = "Lora"
    // options.fontSize = 14

    const response = await Usercentrics.showCMP(options)
    console.log("Consents -> ${response.consents}", response.consents);
    console.log("User Interaction -> ${response.userInteraction}", response.userInteraction);
    console.log("Controller Id -> ${response.controllerId}", response.controllerId);
  }

  async printMethods() {
    const controllerId = await Usercentrics.getControllerId();
    const tcfString = await Usercentrics.getTCFString();

    console.log("Controller Id -> ${controllerId}", controllerId);
    console.log("TCF String -> ${tcfString}", tcfString);
  }

  applyConsents(consents: [UsercentricsServiceConsent]) {
      // https://docs.usercentrics.com/cmp_in_app_sdk/latest/apply_consent/apply-consent/#apply-consent-to-each-service
  }

  render() {
    const styles = StyleSheet.create({
      container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        height: 200,
      }
    })

    return(
    <View style={styles.container}>
      <Button title="Show PredefinedUI" onPress={ () => {
          this.showCMP(false);
      }} />
      <Button onPress={() => {
          this.printMethods();
      }} title="Show Custom UI" />
    </View>
    )
  }
}

export default App
