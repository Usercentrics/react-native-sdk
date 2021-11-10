import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { CustomScreen, HomeScreen } from './screens';
import { UsercentricsOptions, UsercentricsLoggerLevel, Usercentrics } from '../../src/index';

const Stack = createNativeStackNavigator();

const App = () => {
  React.useEffect(() => {
    let options = new UsercentricsOptions("Yi9N3aXia");
    options.loggerLevel = UsercentricsLoggerLevel.debug;
    Usercentrics.configure(options);
  }, []);

  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name="Home"
          component={HomeScreen}
        />
        <Stack.Screen
          name="CustomUI"
          component={CustomScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  )
}
export default App;