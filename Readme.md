        //Encription
        //Dictionary > JSON Data > String ASCII > Data UTF8 > Encripted Data
        let json = ["key1":"value1","ket2":"value2"]
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
        let stringData = string.data(using: .utf8)!
        let encrypted = try! AES(key: AppDelegate.encryptionKey.bytes, blockMode: .ECB, padding: .pkcs7).encrypt([UInt8](stringData))
        let encryptedData = Data(encrypted)

        
        //Decription
        //Encripted Data > Decripted Data > String ASCII > JSON Data > Dictionary
        let decrypted = try! AES(key: AppDelegate.encryptionKey.bytes, blockMode: .ECB, padding: .pkcs7).decrypt([UInt8](encryptedData))
        let decryptedStringData = Data(decrypted)
        let decryptedString = String(bytes: decryptedStringData.bytes, encoding: .utf8) ?? "Could not decrypt"
        let decryptedData = decryptedString.data(using:String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
        let decryptedJson = try! JSONSerialization.jsonObject(with: decryptedData, options: JSONSerialization.ReadingOptions.allowFragments)
        print(decryptedJson)
