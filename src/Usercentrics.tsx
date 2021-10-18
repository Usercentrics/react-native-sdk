import { NativeModules } from 'react-native'
import { UsercentricsOptions, UsercentricsServiceConsent, UsercentricsUIOptions, UsercentricsConsentUserResponse } from './models';

const { RNUsercentricsModule } = NativeModules;

export class UsercentricsReadyStatus {
    shouldShowCMP: boolean
    consents: [UsercentricsServiceConsent]

    constructor(shouldShowCMP: boolean, consents: [UsercentricsServiceConsent]) {
        this.shouldShowCMP = shouldShowCMP
        this.consents = consents
    }
}

export const Usercentrics = {
    configure: (options: UsercentricsOptions) => {
        RNUsercentricsModule.configure(options)
    },

    status: (): Promise<UsercentricsReadyStatus> => { 
        return RNUsercentricsModule.isReady();
    },

    showCMP: (options: UsercentricsUIOptions): Promise<UsercentricsConsentUserResponse> => {
        return RNUsercentricsModule.showCMP(options);
    },

    reset: () => {
        RNUsercentricsModule.reset()
    }
}
