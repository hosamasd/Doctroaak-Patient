//
//  FavoriteStorage.swift
//  Doctroaak Patient
//
//  Created by hosam on 5/31/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class FavoriteStorage {
    
    private init() { }
    
    enum Directory {
        // Only documents and other data that is user-generated, or that cannot otherwise be recreated by your application, should be stored in the <Application_Home>/Documents directory and will be automatically backed up by iCloud.
        case documents
        
        // Data that can be downloaded again or regenerated should be stored in the <Application_Home>/Library/Caches directory. Examples of files you should put in the Caches directory include database cache files and downloadable content, such as that used by magazine, newspaper, and map applications.
        case caches
    }
    
    /// Returns URL constructed from specified directory
    static private func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }
        
        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    
    /// Store an encodable struct to the specified directory on disk
    ///
    /// - Parameters:
    ///   - object: the encodable struct to store
    ///   - directory: where to store the struct
    ///   - fileName: what to name the file where the struct data will be stored
    static func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func storesss<T: Encodable>(_ object: [T], to directory: Directory, as fileName: String) {
           let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
           
           let encoder = JSONEncoder()
           do {
               let data = try encoder.encode(object)
               if FileManager.default.fileExists(atPath: url.path) {
                   try FileManager.default.removeItem(at: url)
               }
               FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
           } catch {
               fatalError(error.localizedDescription)
           }
       }
    
    /// Retrieve and convert a struct from a file on disk
    ///
    /// - Parameters:
    ///   - fileName: name of the file where struct data is stored
    ///   - directory: directory where struct data is stored
    ///   - type: struct type (i.e. Message.self)
    /// - Returns: decoded struct model(s) of data
    static func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        print("Storage: \(url.path)")
        
        if !FileManager.default.fileExists(atPath: url.path) {
            print("File at path \(url.path) does not exist!")
            
            return nil
        }
        
        guard let data = FileManager.default.contents(atPath: url.path) else {
            print("No data at \(url.path)!")
            
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(type, from: data)
            return model
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func retrievess<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> [T]? {
           let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
           print("Storage: \(url.path)")
           
           if !FileManager.default.fileExists(atPath: url.path) {
               print("File at path \(url.path) does not exist!")
               
               return nil
           }
           
           guard let data = FileManager.default.contents(atPath: url.path) else {
               print("No data at \(url.path)!")
               
               return nil
           }
           let decoder = JSONDecoder()
           do {
            
               let model = try decoder.decode(type, from: data)
            return model as? [T]
           } catch {
               print(error.localizedDescription)
               return nil
           }
       }
    
    /// Remove all files at specified directory
    static func clear(_ directory: Directory) {
        let url = getURL(for: directory)
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Remove specified file from specified directory
    static func remove(_ fileName: String, from directory: Directory) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    static func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
}
