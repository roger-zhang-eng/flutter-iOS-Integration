//
//  FlutterData.swift
//  MobileFlutterDemo
//
//  Created by Roger Zhang on 9/5/2024.
//

import Foundation

/// All the flutter data struct should conform to this protocol
protocol FlutterDataBase: Codable {}

extension FlutterDataBase {

	func jsonString() -> String? {
		do {
			let jsonData = try encodeToJsonData()
			if let jsonString = String(data: jsonData, encoding: .utf8) {
				return jsonString
			} else {
				print("Something is wrong while converting JSON data to JSON string.")
				return nil
			}
		} catch let error {
			print("Convert as json string failed: \(error)")
			return nil
		}
	}
	
	func encodeToJsonData() throws -> Data {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		return try encoder.encode(self)
	}

}

struct FlutterAuthToken: FlutterDataBase {
	let authToken: String
}
