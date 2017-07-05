//
//  UserModel.swift
//
//  Created by indianic on 03/07/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class UserModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let body = "body"
    static let message = "message"

    
  }

  // MARK: Properties
  public var status: Bool? = false
  public var body: Body?
    public var message: String?


  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    status = json[SerializationKeys.status].boolValue
    body = Body(json: json[SerializationKeys.body])
    message = json[SerializationKeys.message].string

  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.status] = status
    if let value = body { dictionary[SerializationKeys.body] = value.dictionaryRepresentation() }
    if let value = message { dictionary[SerializationKeys.message] = value }

    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeBool(forKey: SerializationKeys.status)
    self.body = aDecoder.decodeObject(forKey: SerializationKeys.body) as? Body
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String

  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(body, forKey: SerializationKeys.body)
    aCoder.encode(message, forKey: SerializationKeys.message)

  }

}
