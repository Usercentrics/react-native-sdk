import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { CustomScreen, HomeScreen } from './screens';
import Consent from './screens/Consent';

const Stack = createNativeStackNavigator();

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name="Home"
          component={HomeScreen}
        />
        <Stack.Screen
          name="CustomUI"
          component={Consent} />
      </Stack.Navigator>
    </NavigationContainer>
  )
}
export default App;