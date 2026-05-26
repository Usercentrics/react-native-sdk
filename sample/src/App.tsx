import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import * as React from 'react';
import { Usercentrics, UsercentricsLoggerLevel } from '@usercentrics/react-native-sdk';
import { CustomScreen, GppTestingScreen, HomeScreen, WebviewIntegrationScreen } from './screens';

// Set to true when testing consent mediation. Keep false for normal builds.
const MEDIATION_TEST_ENABLED = false;
const SETTINGS_ID = 'EA4jnNPb9';

const Stack = createNativeStackNavigator();

const App = () => {
    React.useEffect(() => {
        Usercentrics.configure({
            settingsId: SETTINGS_ID,
            loggerLevel: UsercentricsLoggerLevel.debug,
            consentMediation: MEDIATION_TEST_ENABLED,
        });
    }, []);

    return (
        <NavigationContainer>
            <Stack.Navigator>
                <Stack.Screen name="Home" component={HomeScreen} />
                <Stack.Screen name="CustomUI" component={CustomScreen} />
                <Stack.Screen name="WebviewIntegration" component={WebviewIntegrationScreen} />
                <Stack.Screen name="GPPTesting" component={GppTestingScreen} />
            </Stack.Navigator>
        </NavigationContainer>
    );
};

export default App;
