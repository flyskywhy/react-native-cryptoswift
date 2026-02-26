import CryptoSwift


@objc(RNCryptography)

class RNCryptography : NSObject {
    
    let errorDomain : String = "RNCryptographyErrorDomain"
    let errorCodeAesEncrypt : Int = -101
    let errorCodeAesDecrypt : Int = -102
    
    
    @objc(md5:resolver:rejecter:)
    func md5(_ value: String,
             resolver resolve: @escaping RCTPromiseResolveBlock,
             rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        
        let data = value.bytes
        resolve(data.md5().toHexString())
    }
    
    
    @objc(sha256:resolver:rejecter:)
    func sha256(_ value: String,
                resolver resolve: @escaping RCTPromiseResolveBlock,
                rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        
        let data = value.bytes
        resolve(data.sha256().toHexString())
    }
    
    
    @objc(sha512:resolver:rejecter:)
    func sha512(_ value: String,
                resolver resolve: @escaping RCTPromiseResolveBlock,
                rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        
        let data = value.bytes
        resolve(data.sha512().toHexString())
    }
    

    @objc(encryptAesCcm:key:iv:tagLength:aad:resolver:rejecter:)
    func encryptAesCcm (_ plaintext : Array<UInt8>,
                        key: Array<UInt8>,
                        iv: Array<UInt8>,
                        tagLength: Int,
                        aad: Array<UInt8>,
                        resolver resolve: @escaping RCTPromiseResolveBlock,
                        rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        do {
            let ccm = CCM(iv: iv, tagLength: tagLength, messageLength: plaintext.count, additionalAuthenticatedData: aad)
            let aes = try AES(key: key, blockMode: ccm, padding: .noPadding)
            let result = try aes.encrypt(plaintext)
            let splitIndex = max(0, result.count - tagLength)
            let ciphertext = Array(result.prefix(upTo: splitIndex))
            let authTag = Array(result.suffix(from: splitIndex))
            resolve(["ciphertext": ciphertext, "authTag": authTag])
        } catch {
            let error = NSError(domain: errorDomain, code: errorCodeAesEncrypt, userInfo: nil)
            reject(String(errorCodeAesEncrypt), "cannot encrypt (AES-CCM)", error)
        }
    }


    @objc(decryptAesCcm:key:iv:authTag:tagLength:aad:resolver:rejecter:)
    func decryptAesCcm (_ ciphertext : Array<UInt8>,
                        key: Array<UInt8>,
                        iv: Array<UInt8>,
                        authTag: Array<UInt8>,
                        tagLength: Int,
                        aad: Array<UInt8>,
                        resolver resolve: @escaping RCTPromiseResolveBlock,
                        rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        do {
            let ccm = CCM(iv: iv, tagLength: tagLength, messageLength: ciphertext.count, authenticationTag:authTag, additionalAuthenticatedData: aad)
            let aes = try AES(key: key, blockMode: ccm, padding: .noPadding)
            let plaintext = try aes.decrypt(ciphertext + authTag)
            resolve(plaintext)
        } catch {
            let error = NSError(domain: errorDomain, code: errorCodeAesDecrypt, userInfo: nil)
            reject(String(errorCodeAesDecrypt), "cannot decrypt (AES-CCM)", error)
        }
    }


    @objc(encryptAesGcm:key:iv:tagLength:aad:resolver:rejecter:)
    func encryptAesGcm (_ plaintext : Array<UInt8>,
                        key: Array<UInt8>,
                        iv: Array<UInt8>,
                        tagLength: Int,
                        aad: Array<UInt8>,
                        resolver resolve: @escaping RCTPromiseResolveBlock,
                        rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        do {
            let gcm = GCM(iv: iv, additionalAuthenticatedData: aad, tagLength: tagLength, mode: .combined)
            let aes = try AES(key: key, blockMode: gcm, padding: .noPadding)
            let result = try aes.encrypt(plaintext)
            let splitIndex = max(0, result.count - tagLength)
            let ciphertext = Array(result.prefix(upTo: splitIndex))
            let authTag = Array(result.suffix(from: splitIndex))
            resolve(["ciphertext": ciphertext, "authTag": authTag])
        } catch {
            let error = NSError(domain: errorDomain, code: errorCodeAesEncrypt, userInfo: nil)
            reject(String(errorCodeAesEncrypt), "cannot encrypt (AES-GCM)", error)
        }
    }


    @objc(decryptAesGcm:key:iv:authTag:tagLength:aad:resolver:rejecter:)
    func decryptAesGcm (_ ciphertext : Array<UInt8>,
                        key: Array<UInt8>,
                        iv: Array<UInt8>,
                        authTag: Array<UInt8>,
                        tagLength: Int,
                        aad: Array<UInt8>,
                        resolver resolve: @escaping RCTPromiseResolveBlock,
                        rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        do {
            let gcm = GCM(iv: iv, authenticationTag:authTag, additionalAuthenticatedData: aad, mode: .detached)
            let aes = try AES(key: key, blockMode: gcm, padding: .noPadding)
            let plaintext = try aes.decrypt(ciphertext)
            resolve(plaintext)
        } catch {
            let error = NSError(domain: errorDomain, code: errorCodeAesDecrypt, userInfo: nil)
            reject(String(errorCodeAesDecrypt), "cannot decrypt (AES-GCM)", error)
        }
    }


    @objc(encryptAES:key:iv:resolver:rejecter:)
    func encryptAES (_ message : String,
                     key: String,
                     iv: String,
                     resolver resolve: @escaping RCTPromiseResolveBlock,
                     rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        do {
            let aes = try AES(key: key, iv: iv)
            let ciphertext = try aes.encrypt(Array(message.utf8))
            resolve(ciphertext.toBase64())
        } catch {
            let error = NSError(domain: errorDomain, code: errorCodeAesEncrypt, userInfo: nil)
            reject(String(errorCodeAesEncrypt), "cannot encrypt (AES)", error)
        }
    }
    
    
    @objc(decryptAES:key:iv:resolver:rejecter:)
    func decryptAES (_ message : String,
                     key: String,
                     iv: String,
                     resolver resolve: @escaping RCTPromiseResolveBlock,
                     rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        do {
            let aes = try AES(key: key, iv: iv)
            let decrypted = try message.decryptBase64ToString(cipher: aes)
            resolve(decrypted)
        } catch {
            let error = NSError(domain: errorDomain, code: errorCodeAesDecrypt, userInfo: nil)
            reject(String(errorCodeAesDecrypt), "cannot decrypt (AES)", error)
        }
    }
}
