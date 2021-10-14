import React, { useEffect } from 'react'
import RNUsercentricsModule, { Counter } from 'react-native-usercentrics'

const App = () => {
  useEffect(() => {
    console.log(RNUsercentricsModule)
  })

  return <Counter />
}

export default App
