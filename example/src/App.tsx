import React, { useEffect } from 'react'
import { Button, NativeModules, StyleSheet, Text, View } from 'react-native'
import RNUsercentricsModule from 'react-native-usercentrics'

const App = () => {
  useEffect(() => {
    console.log(RNUsercentricsModule)
  })

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
      <Button onPress={() => console.log("clicou")} title="Show PredefinedUI" />
      <Button onPress={() => console.log("clicou")} title="Show Custom UI" />
    </View>
  )
}

export default App
