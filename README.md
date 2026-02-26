# react-native-cryptoswift

[![npm version](http://img.shields.io/npm/v/react-native-cryptoswift.svg?style=flat-square)](https://npmjs.org/package/react-native-cryptoswift "View this project on npm")
[![npm downloads](http://img.shields.io/npm/dm/react-native-cryptoswift.svg?style=flat-square)](https://npmjs.org/package/react-native-cryptoswift "View this project on npm")
[![npm licence](http://img.shields.io/npm/l/react-native-cryptoswift.svg?style=flat-square)](https://npmjs.org/package/react-native-cryptoswift "View this project on npm")
[![Platform](https://img.shields.io/badge/platform-ios%20%7C%20android-989898.svg?style=flat-square)](https://npmjs.org/package/react-native-cryptoswift "View this project on npm")

Fork from [react-native-cryptography](https://www.npmjs.com/package/react-native-cryptography) v0.0.2

Crypto e.g. "ase-128-ccm" is invalid (always say `Error: CipherFactory.createCipher(...): Unknown cipher ase-128-ccm`) on iOS with [react-native-quick-crypto](https://github.com/margelo/react-native-quick-crypto) , so be this `react-native-cryptoswift` .

- iOS [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwi)

- Android `BouncyCastle` !TODO finish md5 and sha256!

## Cryptoswift functions

### Symetric ciphering

func      | ios                  | android
----------|----------------------|--------------
`AES CCM` | ✓                    | waiting PR
`AES GCM` | ✓                    | waiting PR
`AES 128` | waiting PR           | ✓
`AES 192` | waiting PR           | ✓
`AES 256` | waiting PR           | ✓

- AES 128 (pass 16 bytes key and iv)

- AES 192 (pass 24 bytes key and iv)

- AES 256 (pass 32 bytes key and iv)

### Hashing

func      | ios                  | android
----------|----------------------|--------------
`MD5`     | waiting PR           | TODO
`SHA256`  | waiting PR           | TODO

## Install

`$ npm install react-native-cryptoswift --save`

iOS: `cd ios/ && pod install`

## Usage
```javascript
import React, { Component } from 'react';
import { Button, StyleSheet, Text, TextInput, View } from 'react-native';
import CryptoSwift from 'react-native-cryptoswift';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 50,
    justifyContent: 'flex-start',
    alignItems: 'center',
  },
});

export default class App extends Component {
  static AES_KEY_128 = Array.from('keykeykeykeykeyk').map(char => char.charCodeAt());
  static AES_IV = Array.from('drowssapdrow').map(char => char.charCodeAt());
  static AUTH_TAG_LENGTH = 4;

  encryptAesCcm() {
    const utf8text = 'Hello, I am the message to cipher';
    const plaintext = Array.from(utf8text).map(char => char.charCodeAt());
    CryptoSwift.encryptAesCcm(plaintext, App.AES_KEY_128, App.AES_IV, App.AUTH_TAG_LENGTH)
      .then(({ciphertext, authTag}) => {
        this.encrypted = {ciphertext, authTag};
        console.log(this.encrypted);
      })
      .catch(err => console.error(err));
  }

  decryptAesCcm() {
    CryptoSwift.decryptAesCcm(this.encrypted.ciphertext, App.AES_KEY_128, App.AES_IV, this.encrypted.authTag, App.AUTH_TAG_LENGTH)
      .then(plaintext => console.log(plaintext))
      .catch(err => console.error(err));
  }

  md5() {
    // CryptoSwift.md5('string to digest').then(digest => console.log(digest));
  }

  sha256() {
    // CryptoSwift.sha256('string to digest').then(digest => console.log(digest));
  }

  render() {
    return (
      <View style={styles.container}>
        <Button onPress={this.encryptAesCcm} title={'encrypt with AES'} />
        <Button onPress={this.decryptAesCcm} title={'decrypt AES'} />
        <Button onPress={this.md5} title={'MD5'} />
        <Button onPress={this.sha256} title={'SHA256'} />
      </View>
    );
  }
}
```
