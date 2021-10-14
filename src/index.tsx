import * as React from 'react'
import { Button, NativeModules, StyleSheet, Text, View } from 'react-native'

export const addOne = (input: number) => input + 1

export default NativeModules.RNUsercentricsModule
