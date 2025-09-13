import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import * as React from 'react';
import { Usercentrics, UsercentricsLoggerLevel, UsercentricsOptions } from '../../src/index';
import { CustomScreen, HomeScreen, WebviewIntegrationScreen } from './screens';

const Stack = createStackNavigator();

const App = () => {
  React.useEffect(() => {
    let options: UsercentricsOptions = { settingsId: "Yi9N3aXia" };
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
        <Stack.Screen
          name="WebviewIntegration"
          component={WebviewIntegrationScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  )
}
export default App;