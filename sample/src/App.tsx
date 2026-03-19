import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import * as React from 'react';
import { Usercentrics, UsercentricsOptions } from '@usercentrics/react-native-sdk';
import { CustomScreen, GppTestingScreen, HomeScreen, WebviewIntegrationScreen } from './screens';

const Stack = createNativeStackNavigator();

const App = () => {
  React.useEffect(() => {
    let options: UsercentricsOptions = { settingsId: "Yi9N3aXia" };
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
        <Stack.Screen
          name="GPPTesting"
          component={GppTestingScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  )
}
export default App;