import React, { Component } from 'react';
import { Alert } from 'react-native';
import {
    Usercentrics,
    UsercentricsLoggerLevel,
    UsercentricsOptions,
    UsercentricsServiceConsent,
    UsercentricsUIOptions,
} from '../../../src/index';

interface Props {
    children: Element;
}

interface State {
    consents: [UsercentricsServiceConsent] | null;
    ucReset: () => void;
}

export const ConsentContext = React.createContext<[UsercentricsServiceConsent] | null>(null);
export const DevelopemetConsentContext = React.createContext<null | (() => void)>(null);

class Consent extends Component<Props, State> {
    constructor(props: any) {
        super(props);
        const options = new UsercentricsOptions("Yi9N3aXia");
        // if (Config.EXPERIMENTAL_FEATURES) {
            options.loggerLevel = UsercentricsLoggerLevel.debug;
        // }
        // options.defaultLanguage = this.props.intl.locale;
        Usercentrics.configure(options);
        this.state = { consents: null, ucReset: Usercentrics.reset };
    }

    async componentDidMount() {
        const status = await Usercentrics.status();
        const mapped = status.consents.map( consent => {return consent.templateId});
        
        Alert.alert("Component Did Mount", `status ${status.shouldShowCMP}, consents: ${mapped}`)

        if (status.shouldShowCMP) {
            this.showCMP(false).then();
        } else {
            this.applyConsents(status.consents);
        }
    }

    async showCMP(showCloseButton: boolean) {
        const options = new UsercentricsUIOptions(showCloseButton);
        const response = await Usercentrics.showCMP(options);
        console.log('showCMP', response.consents);
        this.setState({ consents: response.consents });
    }

    applyConsents(consents: [UsercentricsServiceConsent]) {
        console.log('applyConsents', consents);
        this.setState({ consents });
    }

    render() {
        return (
            <ConsentContext.Provider value={this.state.consents}>
                {/* {Config.EXPERIMENTAL_FEATURES ? ( */}
                    <DevelopemetConsentContext.Provider value={this.state.ucReset}>
                        {this.props.children}
                    </DevelopemetConsentContext.Provider>
                {/* ) : (
                    this.props.children
                )} */}
            </ConsentContext.Provider>
        );
    }
}

export default Consent;