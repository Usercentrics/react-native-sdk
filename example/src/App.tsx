import React, { useEffect } from 'react'
import { Button, NativeModules, StyleSheet, Text, View } from 'react-native'
import { Usercentrics, UsercentricsLoggerLevel, UsercentricsOptions } from '../../src/Usercentrics'

const App = () => {
  
  const styles = StyleSheet.create({
    container: {
      flex: 1,
      alignItems: 'center',
      justifyContent: 'center',
      height: 200,
    },
  })

  return (
    <View style={styles.container}>
      <Button title="Show PredefinedUI" onPress={() => {
        let options = new UsercentricsOptions("abc")
        options.defaultLanguage = "pt"
        options.loggerLevel = UsercentricsLoggerLevel.debug
        options.version = "1.2.3"
        options.timeoutMillis = 123
        Usercentrics.configure(options)
      }} />
      <Button onPress={() => console.log("cde")} title="Show Custom UI" />
    </View>
  )
}

export default App
