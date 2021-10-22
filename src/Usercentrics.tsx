import { NativeModules } from 'react-native'
import { UsercentricsOptions, UsercentricsUIOptions, UsercentricsConsentUserResponse, UsercentricsReadyStatus } from './models';

const { RNUsercentricsModule } = NativeModules;

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

    restoreUserSession: (controllerId: string): Promise<UsercentricsReadyStatus> => {
        return RNUsercentricsModule.restoreUserSession(controllerId);
    },

    getControllerId: (): Promise<string> => {
        return RNUsercentricsModule.getControllerId();
    },

    getTCFString: (): Promise<string> => {
        return RNUsercentricsModule.getTCFString();
    },

    reset: () => {
        RNUsercentricsModule.reset()
    }
}
