import {NativeModules} from 'react-native';

const {RNCryptography} = NativeModules;

function toBytes(stringOrArray) {
  if (typeof stringOrArray === 'string') {
    return Array.from(stringOrArray).map(char => char.charCodeAt());
  } else if (stringOrArray instanceof Uint8Array) {
    return Array.from(stringOrArray);
  } else {
    return stringOrArray;
  }
}

export default {
  // AES-CCM only works on iOS, PR is welcome
  encryptAesCcm: (message, key, iv, tagLength, aad = []) =>
    RNCryptography.encryptAesCcm(
      toBytes(message),
      toBytes(key),
      toBytes(iv),
      tagLength,
      toBytes(aad),
    ),
  decryptAesCcm: (ciphertext, key, iv, authTag, tagLength, aad = []) =>
    RNCryptography.decryptAesCcm(
      toBytes(ciphertext),
      toBytes(key),
      toBytes(iv),
      toBytes(authTag),
      tagLength,
      toBytes(aad),
    ),

  // AES-GCM only works on iOS, PR is welcome
  encryptAesGcm: (message, key, iv, tagLength, aad = []) =>
    RNCryptography.encryptAesGcm(
      toBytes(message),
      toBytes(key),
      toBytes(iv),
      tagLength,
      toBytes(aad),
    ),
  decryptAesGcm: (ciphertext, key, iv, authTag, tagLength, aad = []) =>
    RNCryptography.decryptAesGcm(
      toBytes(ciphertext),
      toBytes(key),
      toBytes(iv),
      toBytes(authTag),
      tagLength,
      toBytes(aad),
    ),

  // AES only works on Android, PR is welcome
  encryptAES: (message, key, iv) => RNCryptography.encryptAES(message, key, iv),
  decryptAES: (cipher, key, iv) => RNCryptography.decryptAES(cipher, key, iv),

  // Hash only works on Android, PR is welcome
  md5: value => RNCryptography.md5(value),
  sha256: value => RNCryptography.sha256(value),
};
