import * as React from 'react';
import { Button, ScrollView, StyleSheet, Text, View } from 'react-native';
import { GppSectionChangePayload, Usercentrics } from '../../../src/index';

export const GppTestingScreen = () => {
    const [gppString, setGppString] = React.useState<string | null>(null);
    const [gppDataJson, setGppDataJson] = React.useState<string>('');
    const [lastEvent, setLastEvent] = React.useState<string>('No events yet');

    React.useEffect(() => {
        const subscription = Usercentrics.onGppSectionChange((payload: GppSectionChangePayload) => {
            setLastEvent(JSON.stringify(payload));
        });

        return () => {
            subscription.remove();
        };
    }, []);

    const fetchGppString = async () => {
        const value = await Usercentrics.getGPPString();
        setGppString(value);
    };

    const fetchGppData = async () => {
        const value = await Usercentrics.getGPPData();
        const asJson = JSON.stringify(value, null, 2);
        setGppDataJson(asJson);
    };

    const setUsNatSaleOptOut = async () => {
        await Usercentrics.setGPPConsent('usnat', 'SaleOptOut', 2);
    };

    const setUsFlSaleOptOut = async () => {
        await Usercentrics.setGPPConsent('usfl', 'SaleOptOut', 2);
    };

    return (
        <ScrollView contentContainerStyle={styles.container}>
            <Text style={styles.title}>GPP Testing</Text>

            <Button title="Get GPP String" onPress={fetchGppString} />
            <Text style={styles.value}>Current GPP String: {gppString ?? 'null'}</Text>

            <Button title="Get GPP Data" onPress={fetchGppData} />
            <View style={styles.block}>
                <Text style={styles.label}>GPP Data JSON</Text>
                <Text style={styles.mono}>{gppDataJson || 'Tap "Get GPP Data"'}</Text>
            </View>

            <Button title='Set usnat SaleOptOut = 2' onPress={setUsNatSaleOptOut} />
            <Button title='Set usfl SaleOptOut = 2' onPress={setUsFlSaleOptOut} />

            <View style={styles.block}>
                <Text style={styles.label}>Last onGppSectionChange event</Text>
                <Text style={styles.mono}>{lastEvent}</Text>
            </View>
        </ScrollView>
    );
};

const styles = StyleSheet.create({
    container: {
        padding: 16,
        gap: 12,
    },
    title: {
        fontSize: 20,
        fontWeight: '600',
    },
    value: {
        fontSize: 14,
    },
    block: {
        borderWidth: 1,
        borderColor: '#ddd',
        borderRadius: 8,
        padding: 12,
    },
    label: {
        fontWeight: '600',
        marginBottom: 8,
    },
    mono: {
        fontFamily: 'Courier',
        fontSize: 12,
    },
});
