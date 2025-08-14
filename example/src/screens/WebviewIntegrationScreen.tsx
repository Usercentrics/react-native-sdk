import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import { WebView } from 'react-native-webview';
import {
    Usercentrics
} from '../../../src/index';

export const WebviewIntegrationScreen = () => {
    const [userSessionData, setUserSessionData] = React.useState<string>()

    const getUserSessionData = React.useCallback(async () => {
        let data = await Usercentrics.getUserSessionData();
        setUserSessionData(data);
    }, [])

    React.useEffect(() => {
        getUserSessionData();
    }, [getUserSessionData]);

    const styles = StyleSheet.create({
        container: {
            width: '100%',
            height: '100%',
        }
    })

    if (userSessionData == null) return null

    return (
        <View style={styles.container}>
            <WebView
                originWhitelist={['*']}
                javaScriptEnabled={true}
                androidLayerType="software"
                domStorageEnabled={true}
                allowFileAccess={true}
                injectedJavaScriptBeforeContentLoaded={`window.UC_UI_USER_SESSION_DATA = ${userSessionData};`.toString()}
                source={{ html: webviewHtml }}
                onError={(syntheticEvent) => {
                    const { nativeEvent } = syntheticEvent;
                    console.warn('WebView error: ', nativeEvent);
                }}
                onHttpError={(syntheticEvent) => {
                    const { nativeEvent } = syntheticEvent;
                    console.warn('WebView HTTP error: ', nativeEvent);
                }}
            />
        </View>
    );
};

const webviewHtml = `
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script>
        // Snippet from the implementation tab
        // Use legacy because old Android WebView implementation doesn't support the last one
        // https://admin.usercentrics.eu/#/v2/implementation?settingsId=XxXXxX
        function _addUsercentricsScript() {
            var settingsId = 'Yi9N3aXia';
            var script = document.createElement('script');
            script.id = 'usercentrics-cmp';
            script.setAttribute('data-settings-id', settingsId);
            script.setAttribute('src', 'https://app.usercentrics.eu/browser-ui/latest/bundle_legacy.js');
            script.async = true;
            document.head.appendChild(script);
        }

        _addUsercentricsScript();

    </script>
</head>

<body>
    <center>
        <p>In-App SDK to Browser SDK</p>
    </center>
</body>

</html>
`;